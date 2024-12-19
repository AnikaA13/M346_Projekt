# M346-Projekt Dokumentation

## Inhalt

- [M346-Projekt Dokumentation](#projekt-dokumentation)
  - [Inhalt](#inhalt)
  - [Markdown Basics](#markdown-basics)
  - [Buckets](#buckets)
  - [Erste Schritte](#erste-schritte)
  - [Prozess](#prozess)
  - [Arbeitsverteilung](#erste-schritte)
  - [Reflexion](#erste-schritte)
  - [Schwierigkeiten](#erste-schritte)
  - [Persönliche Reflexion Elisa](#persönliche-reflexion-elisa)
  - [Persönliche Reflexion Anika](#persönliche-reflexion-anika)
  - [Persönliche Reflexion Emilija](#persönliche-reflexion-emilija)

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
Emilija hatte schwierigkeiten bei der genauen beschreibung der Schritte in der Dokumentation.

#### Persönliche Reflexion Elisa
Ich fand das Projekt gut lösbar, da wir die Aufgaben gut untereinander aufteilen konnten und so immer gut vorwärtsgekommen sind. Wie haben gut als Gruppe zusammengearbeitet, und konnten uns gut austauschen. Ich konnte meine Funktion ziemlich schnell erledigen, da es nur ein paar Suchanfragen gebraucht hat, bis ich die Informationen gefunden habe, welche ich gebraucht habe, und ich schon viel mit C# gearbeitet hat. Dannach musste ich ein bisschen warten, bis Anika das Skript fertig geschrieben hat, damit ich testen konnte ob mein Code auch funktioniert.
Ich fand das Projekt spannend, und es hat mir definitiv geholfen, das Thema nochmal etwas besser zu verstehen, da ich mir jetzt alles besser vorstellen chan. Bei meiner Arbeit hatte ich keine grossen Schwierigkeiten, nur der Zeitdruck, den wir wegen den anderen Projekten und Prüfungen hatten.

#### Persönliche Reflexion Anika


#### Persönliche Reflexion Emilija
Ich war zuständig für die ganze Dokumentation des Projekts und habe mit Anika die Buckets erstellt. Für mich war es ab und zu ein wenig schwer die Dokumentation zu schreiben weil ich nicht alles schritt für schritt verfolgt habe. Ich habe ab und zu nachgefragt und Rückmeldung bekommen und so die Dokumentation verbessert. Man soll immer alles miteinander absprechen und nachfragen wenn man nicht weiter kommt. Ansonsten hat mir das ganze Projekt sehr viel spass gemacht und war eine tolle erfahrug und ich konnte mein Wissen erweitern.


### spöter mömmer da no schöner mache
dotnet add package AWSSDK.S3
dotnet add package Amazon.Lambda.Core
dotnet add package Amazon.Lambda.S3Events
dotnet add package Amazon.Lambda.Serialization.SystemTextJson

in datei von Projekt einfügen damit nötige references für code gemacht werden können