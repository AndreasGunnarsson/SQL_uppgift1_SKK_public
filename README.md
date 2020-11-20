# Processen
Skriva ner snabba funderingar och sedan direkt gå på ER-modelleringen.
Utgick från de sökresultat man fick och det som efterfrågades i uppgiftsbeskrivningen för att hitta entiteterna.
Tänkte att det mesta borde utgå från hunden och den blev då en central del i modellen.

---
# Saker som inte blev färdiga

## INDEX och sökning/optimering
Skulle vilja ha använt INDEX där det hade varit vettigt att ha. Tänker att det borde använda det på vissa kolumner som det inte skrivs så mycket till men som det samtidigt läses mycket ifrån. Men man bör också ha i åtanke att flera INDEX kommer att ta fysisk plats på SQL-databasens servrar (vet inte alls hur mycket plats en medelstor databas tar dock).
Regnr och andra nummer känns generellt rätt så specifika och inget som man generellt söker på så hade kanske lagt det på Dog.[Name] eller liknande.

## CONSTRAINTS
Kunde lagt mer tid på att använda rätt constraints. T.ex. borde "Dog.Tattoo" och "Dog.Chipnr" vara UNIQU men då är problemet att de också får vara NULL (då det inte är ett måste att en hund har en tatuering eller ett chipnr).
Går att använda INDEX på något sätt för att lösa detta!

## DogAvkomma PROCEDURE
Denna procedure ger inte exakt det sökresultat man önskar. Det som saknas är att ifall det är en tik (en morsa) man söker efter så borde det stå "Father regnr" och "Father name", och ifall ldet är en hane (en farsa) så borde kolumnerna visa "Mother regnr" samt "Mother name".. Just nu visar den bara ett Id för morsan/farsan samt att dessa kolumner (både morsa och farsa) alltid visas.
Tror att detta hade gått att lösa med en subquery och något mer "IF" eller alternativt ett "CASE".

## Datum för missing/Lost dog
Hade varit coolt med ett datum som antecknades då hunden försvann. Kanske att det datumet försvinner (NULL) då hunden är upphittad igen.

## Sex/kön i egen tabell
Inte det mest meningsfulla men känns logiskt, borde vara en förutbestämd lista av något slag när man ska lägga till en hund precis som med Race-tabellen.

## Ras-tabellen
Hade varit en grym bonus ifall man läste in alla olika raser som finns i denna tabell. En detalj som inte har så mycket med själva SQL:en att göra men hade varit mer komplett.

## Veterinary-tabellen
Borde antagligen också ha några förutbestämd värden/tabeller för Name och Result men vet inte hur detta funkar exakt i verkliga livet.
