#!/bin/bash

# Einzigartige Namen für Buckets und Lambda-Funktion finden
find_unique_names() {
    local i=-1
    while true; do
        i=$((i + 1))
        bucket1=${bucket1original}${i:+-$i}
        bucket2=${bucket2original}${i:+-$i}
        functionName=${functionNameoriginal}${i:+-$i}

        if aws lambda get-function --function-name "$functionName" &>/dev/null; then
            continue
        fi

        if ! aws s3api head-bucket --bucket "$bucket1" &>/dev/null && \
           ! aws s3api head-bucket --bucket "$bucket2" &>/dev/null; then
            break
        fi
    done
    echo "Gefunden: $bucket1, $bucket2, $functionName"
}

create_bucket() {
    aws s3 mb "s3://$1" &>/dev/null && echo "Bucket \"$1\" wurde erstellt"
    aws s3 wait bucket-exists --bucket "$1" &>/dev/null
}

create_lambda_function() {
    accountNumber=$(aws sts get-caller-identity | jq -r '.Account')
    zip -r9 "$zipName" "$csTemp" &>/dev/null
    aws lambda create-function \
        --function-name "$functionName" \
        --runtime dotnet6 \
        --zip-file "fileb://$zipName" \
        --handler "funktion::funktion.Function::FunctionHandler" \
        --role "arn:aws:iam::$accountNumber:role/LabRole" \
        --region "$region" \
        --layers "$layer" &>/dev/null
    echo "Lambda Funktion \"$functionName\" wurde erstellt"
    rm "$zipName"
}

add_notification() {
    local eventJson="{\"LambdaFunctionConfigurations\":[{\"Id\":\"$functionName\",\"LambdaFunctionArn\":\"arn:aws:lambda:$region:$accountNumber:function:$functionName\",\"Events\":[\"s3:ObjectCreated:*\"],\"Filter\":{\"Key\":{\"FilterRules\":[{\"Name\":\"prefix\",\"Value\":\"\"},{\"Name\":\"suffix\",\"Value\":\"\"}]}}}]}">

    for i in {1..10}; do
        if aws s3api put-bucket-notification-configuration --bucket "$bucket1" --notification-configuration "$eventJson" &>/dev/null; then
            echo "Notification erstellt"
            return
        fi
    done
    echo "Fehler beim Erstellen der Notification"
}

# Hauptablauf
find_unique_names
create_bucket "$bucket1"
create_bucket "$bucket2"

layer=$(aws lambda publish-layer-version \
    --layer-name "$layerName" \
    --zip-file "fileb://$pil" \
    --compatible-runtimes "dotnet6" \
    --region "$region" | jq -r '.LayerVersionArn')

echo "Layer \"$layerName\" wurde erstellt"

cp "$cs" "$csTemp"
sed -i -e "s/sourcebucket_replace/$bucket1/g" \
       -e "s/destbucket_replace/$bucket2/g" \
       -e "s/resizedPrefix_replace/$compressesPrefix/g" "$csTemp"

create_lambda_function
add_notification

# Testausführung
if testBildPfad=($(find "$testBildDir" -type f -exec file {} \; | grep -iE 'image|bitmap' | awk -F: '{print $1}')); then
    testBildName=$(basename "$testBildPfad")
    aws s3 cp "$testBildPfad" "s3://$bucket1"
    sleep 5

    if aws s3 cp "s3://$bucket2/$compressesPrefix$testBildName" "$testBildDir/$compressesPrefix$testBildName" &>/dev/null; then
        echo "Verkleinertes Bild gespeichert unter: $testBildDir/$compressesPrefix$testBildName"
    else
        echo "Fehler bei der Verarbeitung des Bildes"
        aws lambda delete-function --function-name "$functionName" &>/dev/null
        aws s3 rb "s3://$bucket1" --force &>/dev/null
        aws s3 rb "s3://$bucket2" --force &>/dev/null
    fi
else
    echo "Kein gültiges Bild im Verzeichnis $testBildDir gefunden"
fi

rm "$csTemp"
