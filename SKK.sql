DROP TABLE IF EXISTS Veterinary;
DROP TABLE IF EXISTS Dog;
DROP TABLE IF EXISTS Owner;
DROP TABLE IF EXISTS Kull;
DROP TABLE IF EXISTS Uppfödare;
DROP TABLE IF EXISTS Kennel;
DROP TABLE IF EXISTS Race;

CREATE TABLE Race (Id int IDENTITY(1,1) PRIMARY KEY, Name varchar(100));
CREATE TABLE Dog (Id int IDENTITY(1,1) PRIMARY KEY, OwnerId int, KullId int, Lost bit DEFAULT 0, Regnr varchar(50), Name varchar(50), Tattoo varchar(50), Chipnr varchar(50), RaceId int, Sex varchar(1), Color varchar(50));
CREATE TABLE Owner (Id int IDENTITY(1,1) PRIMARY KEY, Name varchar(50), Address varchar(50), Telephone varchar(50), Mobile varchar(50), TelephoneWork varchar(50));
CREATE TABLE Veterinary (Id int IDENTITY(1,1) PRIMARY KEY, DogId int, [Date] date, Name varchar(50), [Result] varchar(50));
CREATE TABLE Kull (Id int IDENTITY(1,1) PRIMARY KEY, UppfödarId int, [Date] date, MotherId int, FatherId int);
CREATE TABLE Uppfödare (Id int IDENTITY(1,1) PRIMARY KEY, KennelId int, Name varchar(50), Address varchar(50), Email varchar(50), Mobile varchar(50));
CREATE TABLE Kennel (Id int IDENTITY(1,1) PRIMARY KEY, Name varchar(50));

-- Note: I earlier used int and bigint for certain numbers but it's better to use varchar since we don't want to perform any math calculations on these numbers and since 0 will be truncated.

ALTER TABLE Dog ADD FOREIGN KEY (OwnerId) REFERENCES Owner(Id);			-- These must already be in the tables for references to work!
ALTER TABLE Dog ADD FOREIGN KEY (KullId) REFERENCES Kull(Id);
ALTER TABLE Dog ADD FOREIGN KEY (RaceId) REFERENCES Race(Id);
ALTER TABLE Veterinary ADD FOREIGN KEY (DogId) REFERENCES Dog(Id);
ALTER TABLE Kull ADD FOREIGN KEY (UppfödarId) REFERENCES Uppfödare(Id);
ALTER TABLE Uppfödare ADD FOREIGN KEY (KennelId) REFERENCES Kennel(Id);

-- Vilken ordning ska man lägga till allt i?
-- Vart kommer mamman och pappan in? Man måste joina kullen för det?

INSERT INTO Owner(Name, Address, Telephone, Mobile, TelephoneWork) VALUES ('Jorvén Pär', 'Ribbingsgatan 14 504 66 Borås', '033412180', '0708697048', '0325669048');
INSERT INTO Kennel(Name) VALUES ('LISSMAS');
INSERT INTO Uppfödare(KennelId, Name, Address, Email, Mobile) VALUES (1, 'Briland Carin', 'Persbergsvägen 5 142 91 Skogås', 'lakarhjalpen@gmail.com', '0739015365');
INSERT INTO Kull(UppfödarId, [Date], MotherId, FatherId) VALUES (1, '2005-06-08', 1, 2);
INSERT INTO Race(Name) VALUES ('bobbo'), ('Parson Russell Terrier'), ('fidos');
INSERT INTO Dog(Regnr, Name, Tattoo, RaceId, Sex, Color) VALUES ('S35580/97', 'Jackies Terrific Contessa', '35580X', 2, 'T', 'vit');				-- Morsan!
INSERT INTO Dog(Regnr, Name, Tattoo, RaceId, Sex, Color) VALUES ('S35194/96', 'Honeyfarms Yvund Kevin', '35194W', 2, 'H', 'vit & fawn');			-- Farsan!
INSERT INTO Dog(OwnerId, KullId, Name, Regnr, Chipnr, RaceId, Sex, Color) VALUES (1, 1, 'Lissmas Fantasia-Li', 'S45925/2005', '977200004100436', 2, 'T', 'vit');
INSERT INTO Veterinary(DogId, [Date], Name, [Result]) VALUES (3, '2006-12-15', 'Blå Stjärnans Djursjukhus Borås', 'HD grad A');
INSERT INTO Veterinary(DogId, [Date], Name, [Result]) VALUES (3, '2006-12-15', 'Af Klinteberg Anna-Carin', 'patella, ua');			-- Borde Name vara en egen? Nej, hittar inte det någonstans.
INSERT INTO Veterinary(DogId, [Date], Name, [Result]) VALUES (1, '1999-05-27', 'Anicura Animalen Djursjukhus', 'HD ua');
INSERT INTO Veterinary(DogId, [Date], Name, [Result]) VALUES (2, '1997-10-07', 'Väsby Djursjukhus', 'HD ua');

SELECT * FROM Dog;
SELECT * FROM Owner;
SELECT * FROM Veterinary;
SELECT * FROM Kull;
SELECT * FROM Uppfödare;
SELECT * FROM Kennel;
SELECT * FROM Race;

--------------------------
DROP PROC IF EXISTS CountDogs;

CREATE PROCEDURE CountDogs AS 
SELECT COUNT(Id) AS [Count] FROM Dog;

EXEC CountDogs;
--------------------------
DROP PROC IF EXISTS CountVets;

CREATE PROCEDURE CountVets AS 
SELECT COUNT(Veterinary.Id) AS [Count] FROM Dog
INNER JOIN Veterinary ON Veterinary.DogId = Dog.Id;

EXEC CountVets;
--------------------------
DROP PROC IF EXISTS ListDogs;

/* CREATE PROCEDURE ListDogs AS
DECLARE @MySearchString varchar(100) = 'Jackies Terrific Contessa'		-- This version of the seraching can only search if everything in a cell matches..
SELECT Regnr, Name, Tattoo, Chipnr, Sex, Race FROM Dog
WHERE @MySearchString IN (Regnr, Name, Tattoo, CAST(Chipnr AS varchar(100)), Sex, Race);	-- Was earlier using a bigint instead of varchar for Chipnr so had to convert it.

EXEC ListDogs; */

-- SELECT CONVERT(varchar(100), Chipnr) FROM Dog;				-- DEBUG/TESTING

DECLARE @MySearchString varchar(100) = '%Terrific%'		-- TODO: Only searches the whole string!
SELECT Regnr, Name, Tattoo, Chipnr, Sex, Race FROM Dog
WHERE Regnr + ' ' + Name + ' ' + Tattoo + ' ' + Chipnr + ' ' + Sex + ' ' + Race LIKE @MySearchString;

DECLARE @MySearchString varchar(100) = '%Terrific%'		-- TODO: Only searches the whole string!
SELECT Regnr + ' ' + Name FROM Dog
WHERE Regnr + ' ' + Name LIKE @MySearchString;

SELECT * FROM Dog
--------
DECLARE @MySearchString varchar(100) = '%Lissmas%'
SELECT Regnr, Name, Tattoo, Chipnr, Sex, Race FROM Dog
WHERE Regnr + Name + Tattoo + Chipnr + Sex + Race LIKE @MySearchString;				-- TODO: This line doesn't work if one or more of the cells are NULL. In this case we have to remove "Tattoo".

--------------
DECLARE @MySearchString varchar(100) = '%T%'
SELECT Regnr, Name, Tattoo, Chipnr, Sex, Race FROM Dog
WHERE Sex LIKE @MySearchString;		-- TODO: This line doesn't work if one or more of the cells are NULL.
----------
DECLARE @MySearchString varchar(100) = '%T%'
DECLARE @SelectedColumn varchar(100) = 'Sex'
DECLARE @SelectedColumnMerge = N'WHERE ' + @SelectedColumn + ' LIKE ' + @MySearchString;
SELECT Regnr, Name, Tattoo, Chipnr, Sex, Race FROM Dog
EXEC(@SelectedColumnMerge)
--WHERE @SelectedColumn LIKE @MySearchString;		-- TODO: This line doesn't work if one or more of the cells are NULL.
-- https://www.mssqltips.com/sqlservertip/1160/execute-dynamic-sql-commands-in-sql-server/
-- https://www.mssqltips.com/sqlservertutorial/162/sql-server-stored-procedure-with-parameters/
---------
DECLARE @MySearchString varchar(100) = '''%H%'''			-- TODO: Varför behövs de extra '? Svar: They're there because we need to string to be '%h%'. The first and last single quote is becuase @MySearchString is a varchar (string) and the second ' is used as escape characters around %h% else there would be an error.
DECLARE @SelectedColumn varchar(100) = 'Sex'
DECLARE @SelectedColumnMerge varchar(1000) = 'SELECT Regnr, Name, Tattoo, Chipnr, Sex, Race FROM Dog WHERE ' + @SelectedColumn + ' LIKE ' + @MySearchString
EXEC (@SelectedColumnMerge);
---------
DROP PROC IF EXISTS MONSTERPROC;

CREATE PROCEDURE MONSTERPROC @MySearchString varchar(100) = '''%T%''', @SelectedColumn varchar(100) = 'Sex' AS		-- Stored procedure with parameters. These parameters are not different from a DECLARE. TODO: Why the extra ''?
DECLARE @SelectedColumnMerge varchar(500) = 'SELECT Regnr, Name, Tattoo, Chipnr, Sex, Race FROM Dog WHERE ' + @SelectedColumn + ' LIKE ' + @MySearchString
EXEC (@SelectedColumnMerge);			-- Will execute the "dynamic SQL statement".

EXEC MONSTERPROC;

----
DROP PROC IF EXISTS MONSTERPROC;

CREATE PROCEDURE MONSTERPROC @MySearchString varchar(100) = 'T', @SelectedColumn varchar(100) = 'Sex' AS		-- Stored procedure with parameters. These parameters are not different from a DECLARE.
DECLARE @SelectedColumnMerge varchar(500) = 'SELECT Regnr, Name, Tattoo, Chipnr, Sex, Race FROM Dog WHERE ' + @SelectedColumn + ' LIKE ''%' + @MySearchString + '%'''
EXEC (@SelectedColumnMerge);			-- Will execute the "dynamic SQL statement". TODO: explain this exec; what differs it from the one below?

EXEC MONSTERPROC;

----
/*
Behöver använda LIKE.
Men vill kolla både SearchString i SearchCategory
Måste därmed kolla EN specifik kolumn efter EN specifik string.

*/