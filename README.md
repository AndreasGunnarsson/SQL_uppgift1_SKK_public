Processen:
Skriva ner snabba funderingar och sedan direkt g� p� ER-modelleringen.
Utgick fr�n de s�kresultat man fick och det som efterfr�gades i uppgiftsbeskrivningen f�r att hitta entiteterna.
T�nkte att det mesta borde utg� fr�n hunden och den blev d� en central del i modellen.

---------------
Saker som inte blev f�rdiga:

INDEX och s�kning/optimering:
Skulle vilja ha anv�nt INDEX d�r det hade varit vettigt att ha. T�nker att det borde anv�nda det p� vissa kolumner som det inte skrivs s� mycket till men som det samtidigt l�ses mycket ifr�n. Men man b�r ocks� ha i �tanke att flera INDEX kommer att ta fysisk plats p� SQL-databasens servrar (vet inte alls hur mycket plats en medelstor databas tar dock).
Regnr och andra nummer k�nns generellt r�tt s� specifika och inget som man generellt s�ker p� s� hade kanske lagt det p� Dog.[Name] eller liknande.

CONSTRAINTS:
Kunde lagt mer tid p� att anv�nda r�tt constraints. T.ex. borde "Dog.Tattoo" och "Dog.Chipnr" vara UNIQU men d� �r problemet att de ocks� f�r vara NULL (d� det inte �r ett m�ste att en hund har en tatuering eller ett chipnr).
G�r att anv�nda INDEX p� n�got s�tt f�r att l�sa detta!

DogAvkomma PROCEDURE:
Denna procedure ger inte exakt det s�kresultat man �nskar. Det som saknas �r att ifall det �r en tik (en morsa) man s�ker efter s� borde det st� "Father regnr" och "Father name", och ifall ldet �r en hane (en farsa) s� borde kolumnerna visa "Mother regnr" samt "Mother name".. Just nu visar den bara ett Id f�r morsan/farsan samt att dessa kolumner (b�de morsa och farsa) alltid visas.
Tror att detta hade g�tt att l�sa med en subquery och n�got mer "IF" eller alternativt ett "CASE".

Datum f�r missing/Lost dog:
Hade varit coolt med ett datum som antecknades d� hunden f�rsvann. Kanske att det datumet f�rsvinner (NULL) d� hunden �r upphittad igen.

Sex/k�n i egen tabell:
Inte det mest meningsfulla men k�nns logiskt, borde vara en f�rutbest�md lista av n�got slag n�r man ska l�gga till en hund precis som med Race-tabellen.

Ras-tabellen:
Hade varit en grym bonus ifall man l�ste in alla olika raser som finns i denna tabell. En detalj som inte har s� mycket med sj�lva SQL:en att g�ra men hade varit mer komplett.

Veterinary-tabellen:
Borde antagligen ocks� ha n�gra f�rutbest�md v�rden/tabeller f�r Name och Result men vet inte hur detta funkar exakt i verkliga livet.