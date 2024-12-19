#!/bin/bash

# Variablen für Buckets und Lambda-Funktion
bucket1original="csv-to-json-in"
bucket2original="csv-to-json-out"
functionNameoriginal="Csv2JsonFunction"
layerName="Csv2JsonLayer"
region="eu-central-1"

# Temporäre Dateien
cs="function.cs"
zipName="function.zip"

# Einzigartige Namen für Buckets und Lambda-Funktion finden
echo "Einzigartige Namen für Buckets und Lambda-Funktion werden gesucht..."
i=-1
while true; do
    i=$((i + 1))
    if [ "$i" -eq 0 ]; then
        bucket1="$bucket1original"
        bucket2="$bucket2original"
        functionName="$functionNameoriginal"
    else
        bucket1="$bucket1original-$i"
        bucket2="$bucket2original-$i"
        functionName="$functionNameoriginal-$i"
    fi

    if ! aws lambda get-function --function-name "$functionName" &>/dev/null && \
       ! aws s3api head-bucket --bucket "$bucket1" &>/dev/null && \
       ! aws s3api head-bucket --bucket "$bucket2" &>/dev/null; then
        break
    fi
done

echo "Gefunden: $bucket1, $bucket2, $functionName"

# Buckets erstellen
create_bucket() {
    aws s3 mb "s3://$1" &>/dev/null && echo "Bucket \"$1\" wurde erstellt"
    aws s3 wait bucket-exists --bucket "$1" &>/dev/null
}

create_bucket "$bucket1"
create_bucket "$bucket2"

# Lambda-Funktion erstellen
zip -r "$zipName" "$cs" &>/dev/null

aws lambda create-function \
    --function-name "$functionName" \
    --runtime dotnet6 \
    --zip-file "fileb://$zipName" \
    --handler "function::function.Function::FunctionHandler" \
    --role "arn:aws:iam::role/LabRole" \
    --region "$region" &>/dev/null

echo "Lambda Funktion \"$functionName\" wurde erstellt"

rm "$zipName"

# Berechtigungen für die Lambda-Funktion
aws lambda add-permission \
    --function-name "$functionName" \
    --action lambda:InvokeFunction \
    --statement-id s3invoke \
    --principal s3.amazonaws.com \
    --source-arn "arn:aws:s3:::$bucket1" &>/dev/null

echo "Berechtigungen für Lambda-Funktion gesetzt"

# S3-Trigger hinzufügen
eventJson='{
    "LambdaFunctionConfigurations": [
        {
            "Id": "'"$functionName"'",
            "LambdaFunctionArn": "arn:aws:lambda:'"$region"':function:'"$functionName"'",
            "Events": ["s3:ObjectCreated:*"],
            "Filter": {
                "Key": {
                    "FilterRules": [
                        {"Name": "suffix", "Value": ".csv"}
                    ]
                }
            }
        }
    ]
}'

aws s3api put-bucket-notification-configuration \
    --bucket "$bucket1" \
    --notification-configuration "$eventJson" &>/dev/null

echo "S3-Trigger wurde konfiguriert"

# Abschlussmeldung
echo ""
echo "Csv2Json-Service wurde erfolgreich eingerichtet!"
echo "In-Bucket: $bucket1"
echo "Out-Bucket: $bucket2"
echo "Lambda-Funktion: $functionName"
