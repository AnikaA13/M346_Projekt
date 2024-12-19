# M346-Projekt Dokumentation

## Inhalt

- [M346-Projekt Dokumentation](#projekt-dokumentation)
  - [Inhalt](#inhalt)
  - [Markdown Basics](#markdown-basics)
  - [Erste Schritte](#erste-schritte)
  - [Buckets](#buckets)
    - [Bilder](#bilder)
    - [Link](#link)
    - [Schrift](#schrift)

## Markdown Basics

### Bilder

![Das ist der Alternative Text](./Bild_Pfad)

### Link

[Alternativer Text](https://www.markdownguide.org/basic-syntax/)

### Schrift

**Bold**
_Kursiv_

- Liste
- Hallo
- Listeninhalt

## Erste Schritte

1. AWS auf der Konsole installieren. Anleitung [Hier.](https://docs.aws.amazon.com/de_de/cli/latest/userguide/getting-started-install.html)

2. Mit AWS verbinden über die Konsole. Anleitung [Hier.](https://docs.aws.amazon.com/de_de/cli/latest/userguide/getting-started-install.html)

3. Repository mit git klonen oder als Zip herunterladen und entzippen.

4. [Hier.](https://docs.aws.amazon.com/de_de/cli/latest/userguide/getting-started-install.html) in der Konsole aufrufen. Den rest erledigt das Skript.

## Buckets

Im AWS-Lab haben wir zwei neue Buckets erstellt. Ein Bucket heisst input-bucket346 dieser ist für den Input zuständig also da wird später die CSV-Datei geladen. Der zweite Bucket heisst output-bucket346 dieser ist für den Output zuständig, da wird später die JSON-Datei abgespeichert.

![Bucket Name](./Bilder/BucketName.png)

Auf diesem Bild seht man die Allzweck-Buckets. Da sieht man genau die zwei Buckets die wir erstellt haben.

![Bucket List](./Bilder/BucketList.png)


## Prozess
### Arbeitsverteilung
Wir haben uns die Aufgaben untereinander aufgeteilt. Anika ist für das bash Skript verantwortlich, Elisa für die Lambda Funktion und Emilija für die Dokumentation. 

### Reflexion
Auch wenn wir ab und zu etwas Probleme gehabt haben, haben wir uns wenn möglich immer in der Gruppe geholfen, oder andere Gruppen gefragt. Es war eine gute Arbeitsstimmung und alle haben ihren Part gut beigetragen.
##### Schwierigkeiten
Wir hatten Schwierigkeiten mit den Berechtigungen der Lambda Funktion.

#### Persönliche Reflexion Elisa
Ich fand das Projekt gut lösbar, da wir die Aufgaben gut untereinander aufteilen konnten und so immer gut vorwärtsgekommen sind. Wie haben gut als Gruppe zusammengearbeitet, und konnten uns gut austauschen. Ich konnte meine Funktion ziemlich schnell erledigen, da es nur ein paar Suchanfragen gebraucht hat, bis ich die Informationen gefunden habe, welche ich gebraucht habe, und ich schon viel mit C# gearbeitet hat. Dannach musste ich ein bisschen warten, bis Anika das Skript fertig geschrieben hat, damit ich testen konnte ob mein Code auch funktioniert.
Ich fand das Projekt spannend, und es hat mir definitiv geholfen, das Thema nochmal etwas besser zu verstehen. Bei meiner Arbeit hatte ich keine grossen Schwierigkeiten, nur der Zeitdruck, den wir wegen den anderen Projekten und Prüfungen hatten.

#### Persönliche Reflexion Anika


#### persönliche Reflexion Emilija



### spöter mömmer da no schöner mache
dotnet add package AWSSDK.S3
dotnet add package Amazon.Lambda.Core
dotnet add package Amazon.Lambda.S3Events
dotnet add package Amazon.Lambda.Serialization.SystemTextJson

in datei von Projekt einfügen damit nötige references für code gemacht werden können