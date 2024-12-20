#!/bin/bash

# Namen der Komponenten aus Datei lesen
source component_names.sh

# CSV-Datei hochladen
csvFile="test.csv"
s3CsvFile="s3://$bucket1/$csvFile"
aws s3 cp "$csvFile" "$s3CsvFile" || { echo "Fehler beim Hochladen der CSV-Datei"; exit 1; }
echo "CSV-Datei wurde hochgeladen"

# Warten auf die Konvertierung
echo "Warten auf die Konvertierung..."
jsonFile="test.json"
s3JsonFile="s3://$bucket2/$jsonFile"
localJsonFile="downloaded_$jsonFile"

while true; do
    if aws s3 ls "$s3JsonFile" &>/dev/null; then
        echo "JSON-Datei ist verfügbar"
        break
    fi
    sleep 5
done

# JSON-Datei herunterladen
aws s3 cp "$s3JsonFile" "$localJsonFile" || { echo "Fehler beim Herunterladen der JSON-Datei"; exit