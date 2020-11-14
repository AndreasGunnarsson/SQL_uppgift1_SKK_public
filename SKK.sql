USE Student11;

DROP TABLE IF EXISTS Veterinary;
DROP TABLE IF EXISTS Dog;
DROP TABLE IF EXISTS Owner;
DROP TABLE IF EXISTS Kull;
DROP TABLE IF EXISTS Uppfödare;
DROP TABLE IF EXISTS Kennel;
DROP TABLE IF EXISTS Race;

-- CREATE TABLE Race (Id int IDENTITY(1,1) PRIMARY KEY, [Name] varchar(100) NOT NULL UNIQUE);
CREATE TABLE Race (Id int IDENTITY(1,1) PRIMARY KEY, [Name] varchar(100) NOT NULL);
-- CREATE TABLE Dog (Id int IDENTITY(1,1) PRIMARY KEY, OwnerId int, KullId int, Lost bit DEFAULT 0, Regnr varchar(50) NOT NULL UNIQUE, [Name] varchar(50), Tattoo varchar(50) UNIQUE, Chipnr varchar(50) UNIQUE, RaceId int, Sex varchar(1), Color varchar(50));
CREATE TABLE Dog (Id int IDENTITY(1,1) PRIMARY KEY, OwnerId int, KullId int, Lost bit DEFAULT 0, Regnr varchar(50) NOT NULL, [Name] varchar(50), Tattoo varchar(50), Chipnr varchar(50), RaceId int, Sex varchar(1), Color varchar(50));
CREATE TABLE Owner (Id int IDENTITY(1,1) PRIMARY KEY, [Name] varchar(50), Address varchar(50), Telephone varchar(50), Mobile varchar(50), TelephoneWork varchar(50));
CREATE TABLE Veterinary (Id int IDENTITY(1,1) PRIMARY KEY, DogId int, [Date] date, [Name] varchar(50), [Result] varchar(50));
CREATE TABLE Kull (Id int IDENTITY(1,1) PRIMARY KEY, UppfödarId int, [Date] date, MotherId int, FatherId int);
CREATE TABLE Uppfödare (Id int IDENTITY(1,1) PRIMARY KEY, KennelId int, [Name] varchar(50), Address varchar(50), Email varchar(50), Mobile varchar(50));
CREATE TABLE Kennel (Id int IDENTITY(1,1) PRIMARY KEY, [Name] varchar(50));

-- CREATE UNIQUE NONCLUSTERED INDEX I2 ON Race([Name]) WHERE [Name] IS NOT NULL; -- UNIQUE: The index must be unique.	-- TODO: Get this to work! We want unique indexes!
-- Note: I earlier used int and bigint for certain numbers but it's better to use varchar since we don't want to perform any math calculations on these numbers and since 0 will be truncated.

ALTER TABLE Dog ADD FOREIGN KEY (OwnerId) REFERENCES Owner(Id);			-- Note: OwnerId must already exist in the table for references/ALTER to work!
ALTER TABLE Dog ADD FOREIGN KEY (KullId) REFERENCES Kull(Id);
ALTER TABLE Dog ADD FOREIGN KEY (RaceId) REFERENCES Race(Id);
ALTER TABLE Veterinary ADD FOREIGN KEY (DogId) REFERENCES Dog(Id);
ALTER TABLE Kull ADD FOREIGN KEY (UppfödarId) REFERENCES Uppfödare(Id);
ALTER TABLE Uppfödare ADD FOREIGN KEY (KennelId) REFERENCES Kennel(Id);

-- Vart kommer mamman och pappan in? Man måste joina kullen för det?

INSERT INTO Owner([Name], Address, Telephone, Mobile, TelephoneWork) VALUES ('Jorvén Pär', 'Ribbingsgatan 14 504 66 Borås', '033412180', '0708697048', '0325669048');	-- Id 1
INSERT INTO Owner([Name], Address, Mobile) VALUES ('Briland Carin', 'Persbergsvägen 5 142 91  Skogås', '073-9015365');			-- Morsans. Id 2
INSERT INTO Owner([Name]) VALUES ('Fake Man');				-- Farsans. Id 3

INSERT INTO Kennel([Name]) VALUES ('LISSMAS');				-- Id 1
INSERT INTO Kennel([Name]) VALUES ('HONEYFARMS');			-- Farsans. Id 2
INSERT INTO Kennel([Name]) VALUES ('JACKIES TERRIFIC');		-- Morsan. Id 3

INSERT INTO Uppfödare(KennelId, [Name], Address, Email, Mobile) VALUES (1, 'Briland Carin', 'Persbergsvägen 5 142 91 Skogås', 'lakarhjalpen@gmail.com', '0739015365');
INSERT INTO Uppfödare(KennelId, [Name], Address) VALUES (2, 'Lindius Birgitta', 'Grödinge');				-- Farsans uppfödare.
INSERT INTO Uppfödare(KennelId, [Name], Address) VALUES (3, 'Lidholm Henry', 'Sorunda');					-- Morsan.

INSERT INTO Kull(UppfödarId, [Date], MotherId, FatherId) VALUES (1, '2005-06-08', 3, 4);		-- Huvudkaraktären, Syster och Broder.
INSERT INTO Kull(UppfödarId, [Date]) VALUES (2, '1996-05-08');				-- Farsans.
INSERT INTO Kull(UppfödarId, [Date], MotherId, FatherId) VALUES (3, '1997-05-30', 2, 1);		-- Morsan.
INSERT INTO Kull([Date]) VALUES ('1995-03-12');								-- Mammas mamma.
INSERT INTO Kull([Date]) VALUES ('1995-09-02');								-- Mammas pappa.

-- INSERT INTO Race([Name]) VALUES ('Race1'), ('Parson Russell Terrier'), ('Race3'), ('Race4'), ('Race1');			-- TODO: To test UNIQUE. We have to use the CREATE UNIQUE NONCLUSTERED INDEX somehow above..
INSERT INTO Race([Name]) VALUES ('Race1'), ('Parson Russell Terrier'), ('Race3'), ('Race4');

INSERT INTO Dog(OwnerId, KullId, Regnr, [Name], Tattoo, RaceId, Sex, Color) VALUES (2, 5, 'S52275/95', 'Jackpack Sid Vicious', '52275V', 2, 'H', 'vit m svarta tecken');		-- Mammas pappa. Id 1
INSERT INTO Dog(OwnerId, KullId, Regnr, [Name], Tattoo, RaceId, Sex, Color) VALUES (2, 4, 'S20274/95', 'Jackies Terrific Amelia', '20274V', 2, 'T', 'vit & brun');				-- Mammas mamma. Id 2
INSERT INTO Dog(OwnerId, KullId, Regnr, [Name], Tattoo, RaceId, Sex, Color) VALUES (2, 3, 'S35580/97', 'Jackies Terrific Contessa', '35580X', 2, 'T', 'vit');					-- Morsan! Id 3
INSERT INTO Dog(OwnerId, KullId, Regnr, [Name], Tattoo, RaceId, Sex, Color) VALUES (3, 2, 'S35194/96', 'Honeyfarms Yvund Kevin', '35194W', 2, 'H', 'vit & fawn');	-- Farsan! Id 4
INSERT INTO Dog(OwnerId, KullId, [Name], Regnr, Chipnr, RaceId, Sex, Color) VALUES (1, 1, 'Lissmas Fantasia-Li', 'S45925/2005', '977200004100436', 2, 'T', 'vit');	-- Huvudkaraktär. Id 5
INSERT INTO Dog(KullId, [Name], Regnr, RaceId, Sex, Color) VALUES (1, 'Lissmas Fiona-Li', 'S45922/2005', 2, 'T', 'vit & svart');		-- Syster. Id 6
INSERT INTO Dog(KullId, [Name], Regnr, RaceId, Sex, Color) VALUES (1, 'Lissmas Findus', 'S45919/2005', 2, 'H', 'vit svart brun ');		-- Broder. Id 7

INSERT INTO Veterinary(DogId, [Date], [Name], [Result]) VALUES (5, '2006-12-15', 'Blå Stjärnans Djursjukhus Borås', 'HD grad A');
INSERT INTO Veterinary(DogId, [Date], [Name], [Result]) VALUES (5, '2006-12-15', 'Af Klinteberg Anna-Carin', 'patella, ua');			-- Borde [Name] vara en egen? Nej, hittar inte det någonstans.
INSERT INTO Veterinary(DogId, [Date], [Name], [Result]) VALUES (3, '1999-05-27', 'Anicura Animalen Djursjukhus', 'HD ua');				-- Morsan.
INSERT INTO Veterinary(DogId, [Date], [Name], [Result]) VALUES (4, '1997-10-07', 'Väsby Djursjukhus', 'HD ua');							-- Farsan.

-------------------------- SELECTs for all the tables created above

SELECT * FROM Dog;
SELECT * FROM Owner;
SELECT * FROM Veterinary;
SELECT * FROM Kull;
SELECT * FROM Uppfödare;
SELECT * FROM Kennel;
SELECT * FROM Race;

------------------------- DROP PROCEDURES and VIEWs
DROP PROC IF EXISTS CountDogs;
DROP PROC IF EXISTS CountVets;
DROP PROC IF EXISTS ProcTest;
DROP VIEW IF EXISTS ViewTest;
DROP VIEW IF EXISTS DogList;
DROP PROCEDURE IF EXISTS SearchProcedure;
DROP PROC IF EXISTS SearchDog;
DROP PROC IF EXISTS SearchDog2;
DROP PROC IF EXISTS DogOwner;
DROP PROC IF EXISTS DogBreeder;
DROP PROC IF EXISTS DogVet;
DROP PROC IF EXISTS DogKull;
DROP PROC IF EXISTS DogAvkomma;
-------------------------- Counts the dogs
CREATE OR ALTER PROCEDURE CountDogs AS 
BEGIN
	SELECT COUNT(Id) AS [Count] FROM Dog
END;

EXEC CountDogs;

-------------------------- Counts the veterinarys
CREATE OR ALTER PROCEDURE CountVets AS
BEGIN
	SELECT COUNT(Veterinary.Id) AS [Count] FROM Dog
	INNER JOIN Veterinary ON Veterinary.DogId = Dog.Id
END;

EXEC CountVets;

--------- Search test (early version)
/* DROP PROC IF EXISTS ListDogs;

CREATE PROCEDURE ListDogs AS
DECLARE @MySearchString varchar(100) = 'Jackies Terrific Contessa'		-- This version of the seraching can only search if everything in a cell matches..
SELECT Regnr, [Name], Tattoo, Chipnr, Sex, Race FROM Dog
WHERE @MySearchString IN (Regnr, [Name], Tattoo, CAST(Chipnr AS varchar(100)), Sex, Race);	-- Was earlier using a bigint instead of varchar for Chipnr so had to convert it.

EXEC ListDogs; */

-- SELECT CONVERT(varchar(100), Chipnr) FROM Dog;				-- DEBUG/TESTING

/*DECLARE @MySearchString varchar(100) = '%Terrific%'		-- TODO: Only searches the whole string!
--PRINT @MySearchString
SELECT Regnr, Dog.[Name], Tattoo, Chipnr, Sex, Race.[Name] AS Race FROM Dog INNER JOIN Race ON Race.Id = Dog.RaceId
WHERE Regnr + ' ' + Dog.[Name] + ' ' + Tattoo + ' ' + Chipnr + ' ' + Sex + ' ' + Race.[Name] LIKE @MySearchString; */	-- Garbage, doesn't work.

/* DECLARE @MySearchString varchar(100) = '%Terrific%'		-- TODO: Only searches the whole string!
SELECT Regnr + ' ' + [Name] FROM Dog
WHERE Regnr + ' ' + [Name] LIKE @MySearchString; */			-- Bad output (only one column).
--------- Search test (early version)
/* DECLARE @MySearchString varchar(100) = '%Lissmas%'		-- Garbage.
SELECT Regnr, [Name], Tattoo, Chipnr, Sex, Race FROM Dog
WHERE Regnr + [Name] + Tattoo + Chipnr + Sex + Race LIKE @MySearchString; */				-- TODO: This line doesn't work if one or more of the cells are NULL. In this case we have to remove "Tattoo".

--------- Search test (early version)
/* DECLARE @MySearchString varchar(100) = '%T%'
DECLARE @SelectedColumn varchar(100) = 'Sex'
DECLARE @SelectedColumnMerge = N'WHERE ' + @SelectedColumn + ' LIKE ' + @MySearchString;
SELECT Regnr, [Name], Tattoo, Chipnr, Sex, Race FROM Dog
EXEC(@SelectedColumnMerge) */
--WHERE @SelectedColumn LIKE @MySearchString;		-- TODO: This line doesn't work if one or more of the cells are NULL.
-- https://www.mssqltips.com/sqlservertip/1160/execute-dynamic-sql-commands-in-sql-server/
-- https://www.mssqltips.com/sqlservertutorial/162/sql-server-stored-procedure-with-parameters/
--------- Search test (early version)
/* DECLARE @MySearchString varchar(100) = '''%H%'''			-- TODO: Varför behövs de extra '? Svar: They're there because we need to string to be '%h%'. The first and last single quote is becuase @MySearchString is a varchar (string) and the second ' is used as escape characters around %h% else there would be an error.
DECLARE @SelectedColumn varchar(100) = 'Sex'
DECLARE @SelectedColumnMerge varchar(1000) = 'SELECT Regnr, [Name], Tattoo, Chipnr, Sex, Race FROM Dog WHERE ' + @SelectedColumn + ' LIKE ' + @MySearchString
EXEC (@SelectedColumnMerge); */
--------- Search test (early version)
/* DROP PROC IF EXISTS MONSTERPROC;

CREATE PROCEDURE MONSTERPROC @MySearchString varchar(100) = '''%T%''', @SelectedColumn varchar(100) = 'Sex' AS		-- Stored procedure with parameters. These parameters are not different from a DECLARE. TODO: Why the extra ''?
DECLARE @SelectedColumnMerge varchar(500) = 'SELECT Regnr, [Name], Tattoo, Chipnr, Sex, Race FROM Dog WHERE ' + @SelectedColumn + ' LIKE ' + @MySearchString
EXEC (@SelectedColumnMerge);			-- Will execute the "dynamic SQL statement".

EXEC MONSTERPROC; */

----------------------- Test with Proc and View
CREATE OR ALTER PROCEDURE ProcTest AS
SELECT Regnr, [Name] FROM Dog;

EXEC ProcTest;

CREATE OR ALTER VIEW ViewTest AS
SELECT Regnr, [Name] FROM Dog;

SELECT * FROM ViewTest;

-- En PROCEDURE kan man se som en metod.
-- Allt som man kan göra i en VIEW kan man göra i en PROCEDURE (samt lite till).
-- VIEW:s kan endast användas för SELECT.
-- Man kan ha parametrar i en PROCEDURE, detta går inte i en VIEW.
-- I en PROCEDURE kan man ha flera statements, detta går inte i en VIEW.
-- Om man ska göra INSERT (eller något annat än en SELECT) så är det PROCEDURE som gäller.

--------------- View used inside the searching procedure below.
CREATE OR ALTER VIEW DogList AS
SELECT Dog.Regnr, Dog.[Name], Dog.Tattoo, Dog.Chipnr, Dog.Sex, Race.[Name] AS Race FROM Dog INNER JOIN Race ON Dog.RaceId = Race.Id;

SELECT * FROM DogList;

--------------- Procedure used for searching (uses the view DogList above)
CREATE OR ALTER PROCEDURE SearchProcedure
@Regnr varchar(50) = NULL,			-- Parameters for PROCEDURES
@Name varchar(50) = NULL,
@Tattoo varchar(50) = NULL,
@Chipnr varchar(50) = NULL,
@Sex varchar(50) = NULL,
@Race varchar(50) = NULL AS
BEGIN
	SELECT * FROM DogList
	WHERE (@Regnr IS NULL OR Regnr LIKE '%' + @Regnr + '%')
	AND (@Name IS NULL OR [Name] LIKE '%' + @Name + '%')
	AND (@Tattoo IS NULL OR Tattoo LIKE '%' + @Tattoo + '%')
	AND (@Chipnr IS NULL OR Chipnr LIKE '%' + @Chipnr + '%')	-- '%' will make it possible to use wildcards in the search.
	AND (@Sex IS NULL OR Sex = @Sex)							-- Compared to the searches above (Regnr, Name, Tattoo and Chipnr) this one requires the whole exact word.
	AND (@Race IS NULL OR Race = @Race)
END

EXEC SearchProcedure;					-- Search everything/List all
EXEC SearchProcedure @Regnr = '35';		-- Just search Regnr that contains '35'.
EXEC SearchProcedure @Regnr = '35', @Name = 'Terrific';		-- Searches Regner '35' and Name 'Terrific'.

-------------------------- Search version 1
DECLARE @SearchString varchar(100) = '%T%'		-- Works. The limitiation is that we cant search a specific field withouth changin the WHERE. In version 2 we have a specific variable.
SELECT Regnr, Dog.[Name], Tattoo, Chipnr, Sex, Race.[Name] AS Race FROM Dog INNER JOIN Race ON Race.Id = Dog.RaceId
WHERE Sex LIKE @SearchString;

--------------------- Search version 2 - Adds a variable for choosing a column.

CREATE OR ALTER PROCEDURE SearchDog @MySearchString varchar(100) = 'T', @SelectedColumn varchar(100) = 'Sex' AS		-- Stored procedure with parameters. These parameters are not different from a DECLARE.
BEGIN
	DECLARE @SelectedColumnMerge varchar(500) = 'SELECT Regnr, Dog.[Name], Tattoo, Chipnr, Sex, Race.[Name] FROM Dog INNER JOIN Race ON Race.Id=Dog.RaceId WHERE ' + @SelectedColumn + ' LIKE ''%' + @MySearchString + '%'''	-- We've added the % signs into the dynamic SQL statement so that the parameters and arguments will be easier for the user. Two single quote (') works as a delimiter.
	EXEC (@SelectedColumnMerge)			-- Will execute the "dynamic SQL statement". TODO: explain this exec; what differs it from the one below?
END;

EXEC SearchDog;
--------------------- Search version 3 - Combination of "Search version 2", the view DogList and 
CREATE OR ALTER PROCEDURE SearchDog2
@SearchString varchar(100) = NULL,
@SelectedColumn varchar(100) = NULL AS
BEGIN
	DECLARE @SelectedColumnMerge varchar(500) = 'SELECT * FROM DogList WHERE ' + @SelectedColumn + ' LIKE ''%' + @SearchString + '%'''	-- Detta är dumt ur ett SQL-injection-perspektiv ifall vi inte kollar (göra till parametrar?) @SelectedColumn och @SearchString i backend innan.
	EXEC (@SelectedColumnMerge);			-- Will execute the "dynamic SQL statement". TODO: explain this exec; what differs it from the one below?
END;

EXEC SearchDog2 @SearchString = 'T', @SelectedColumn = 'Sex';
--------------- Ägare till specifik hund
CREATE OR ALTER PROCEDURE DogOwner
@DogId int = NULL AS
BEGIN
	SELECT Owner.[Name], Owner.Address, Owner.Telephone, Owner.Mobile, Owner.TelephoneWork FROM Dog INNER JOIN Owner ON Owner.Id = Dog.OwnerId WHERE Dog.Id = @DogId
END;

EXEC DogOwner @DogId = 3;

--------------- Uppfödare till specifik hund
CREATE OR ALTER PROCEDURE DogBreeder
@DogId int = NULL AS
BEGIN
	SELECT Uppfödare.[Name], Uppfödare.Address, Uppfödare.Email, Uppfödare.Mobile FROM Dog
	INNER JOIN Kull ON Kull.Id = Dog.KullId
	INNER JOIN Uppfödare ON Uppfödare.Id = Kull.UppfödarId
	WHERE Dog.Id = @DogId
END;

EXEC DogBreeder @DogId = 3;
--------------- Veterinär-besök till specifik hund
CREATE OR ALTER PROCEDURE DogVet
@DogId int = NULL AS
BEGIN
	SELECT Veterinary.[Date], Veterinary.[Name], Veterinary.Result FROM Veterinary
	INNER JOIN Dog ON Dog.Id = Veterinary.DogId
	WHERE Dog.Id = @DogId
END;

EXEC DogVet @DogId = 5;
--------------- Kullsyskon till specifik hund
CREATE OR ALTER PROCEDURE DogKull
@DogId int = NULL AS					-- Parameter for procedure. Default is NULL if no argument is given.
BEGIN									-- Begins the "code block"; where are the statments are in the PROCEDURE.
	DECLARE @KullIdentity int			-- DECLARE a new variable.
	SELECT @KullIdentity = Dog.KullId FROM Dog WHERE Id = @DogId		-- Will assign the KullId to the newcly created variable.

	SELECT Dog.Regnr, Dog.[Name], Dog.Sex FROM Kull
	INNER JOIN Dog ON Dog.KullId = Kull.Id
	WHERE Dog.KullId = @KullIdentity
END;

EXEC DogKull @DogId = 5;			-- We call the PROCEDURE DogKull and use the argument "@DogId = 5".
--------------- Avkommor till specifik hund version 1 (WIP)
CREATE OR ALTER PROCEDURE DogAvkomma
@DogId int = NULL AS
BEGIN
	DECLARE @KullIdentity int = NULL
	SELECT @KullIdentity = Kull.Id FROM Kull WHERE Kull.MotherId = @DogId OR Kull.FatherId = @DogId

	SELECT * FROM Kull INNER JOIN Dog ON Dog.KullId = Kull.Id WHERE Dog.KullId = @KullIdentity
	-- SELECT @KullIdentity AS KullIdentity			-- Debug.
END;
-- TODO: Utskriften blir fel då vi måste ha olika utskrifter beroende på ifall hunden vi kollade var en "T" eller "H" (Dog.Sex).

EXEC DogAvkomma @DogId = 3;

-- Debug below:
/*
SELECT * FROM Kull;
SELECT * FROM Dog;
SELECT * FROM Kull INNER JOIN Dog ON Dog.KullId = Kull.Id WHERE Kull.MotherId = 2;		-- 2 = Mammas mamma. Visar morsan.
SELECT * FROM Kull INNER JOIN Dog ON Dog.KullId = Kull.Id WHERE Kull.FatherId = 4;		-- 4 = Pappan. Visar alla avkommor (huvudkaraktär, bror och syster).
SELECT * FROM Kull INNER JOIN Dog ON Dog.KullId = Kull.Id WHERE Kull.FatherId = 1;		-- 1 = Mammas pappa. Visar morsan.
SELECT * FROM Kull INNER JOIN Dog ON Dog.KullId = Kull.Id WHERE Kull.MotherId = 3;		-- 3 = Mamman. Visar alla avkommor (huvudkaraktär, bror och syster).
*/
-- Kolla ett Dog.Id
	-- Om det är en morsa (får man reda på ifall Kull.MotherId inte är NULL)
		-- Skriv ut: Regnr, Namn, Kön, Födelsedatum, Faderns regnr, Faderns namn
			-- Faderns regnr och namn får man ut genom att kolla raden med samma Kull.Id som MotherId.
-- Exempel: Vi kollar Dog.Id 3 (en mamma).
	-- WHERE Kull.MotherId = 3 > @FatherIdentity = Kull.FatherId > @KullIdentity = Kull.Id
	-- Skriv ut 

-- Om man kollar en morsa:
	-- Regnr, Namn, Kön, Födelsedatum, Faderns regnr, Faderns namn
		-- Regnr, Namn, Kön: Från Dog.
			-- Födelsedatum, Faderns regnr, faderns namn: Från Kull.
-- Om man kollar på en farsa:
	-- Regnr, Namn, Kön, Födelsedatum, Moderns regnr, moderns namn

-- Är bara Dog.Id 1,2,3 och 4 som har avkommor.
----------------------- Registrera hund
CREATE OR ALTER PROCEDURE NewDog
@OwnerId int = NULL,
@KullId int = NULL,
@Regnr varchar(50) = NULL,		-- Cannot be NULL
@Name varchar(50) = NULL,
@Tattoo varchar(50) = NULL,
@Chipnr varchar(50) = NULL,
@RaceId int = NULL,
@Sex varchar(1) = NULL,
@Color varchar(50) = NULL AS
BEGIN
	INSERT INTO Dog(OwnerId, KullId, Regnr, [Name], Tattoo, Chipnr, RaceId, Sex, Color) VALUES (@OwnerId, @KullId, @Regnr, @Name, @Tattoo, @Chipnr, @RaceId, @Sex, @Color)
END;

EXEC NewDog @Regnr = 'S666/99', @Name = 'Fido', @Sex = 'X', @Color = 'matte black';
----------------------- Registrera ägare
CREATE OR ALTER PROCEDURE NewOwner
@Name varchar(50) = NULL,
@Address varchar(50) = NULL,
@Telephone varchar(50) = NULL,
@Mobile varchar(50) = NULL,
@TelephoneWork varchar(50) = NULL AS
BEGIN
	INSERT INTO Owner([Name], [Address], Telephone, Mobile, TelephoneWork) VALUES (@Name, @Address, @Telephone, @Mobile, @TelephoneWork)
END;

EXEC NewOwner @Name = 'Bobbby', @Address = 'Korsvägen', @Telephone = '000-000 00 00';
----------------------- Hund byter ägare

--------------------------
/*
TODO
- Detaljer om hund:
	- Använd views för en specifik hund.
		- Info/Data om hund.

- Övriga funktioner:
	- Byta ägare.
	- Anmäla hund som saknad.
	- Anmäla hund som upphittad.

- Lägg till extra funktionalitet i "Avkommor till specifik hund version 1 (WIP)" (se TODO).
- Kan man ha if-statements i NewDog och NewOwner så att man inte kan lägga till OwnerId och RaceId som är utanför de värden som redan existerar?
- Lägg till en tabell för Sex, blir bättre ifall man ska lägga till förbestämda värden? Man kanske kan använda den med if-statments (se ovan).
- Fix "CREATE UNIQUE NONCLUSTERED INDEX" - We want UNIQUE at the same time as we allow NULL.
- Lägg in alla Race (kopiera från hemsidan).
- Beskriv search-funktionen (mest OR och AND som är frågetecken).
- Clean up unused code.
- Fundera på index..
- Kolla performance.
*/