(localdb)/mssqllocaldb
--SQL SALVESTATUD PROTSEDUUR funktsioon, mille saate salvestada, nii et koodi saab ikka ja jälle kasutada. / funktsioon mis käivitav serveris mitu SQL tegevust järjest.

--Kasutame SQL server
--############################################
--###############/////SQL/////################
--############################################

CREATE DATABASE ProtseduurMelon3000

USE ProtseduurMelon3000

CREATE TABLE Linn
(
linnID INT PRIMARY KEY identity(1,1),
linnNIMI VARCHAR(30), 
rahvaARV INT
);


SELECT * FROM Linn
INSERT INTO Linn(linnNIMI, rahvaARV)
VALUES
('TALLINN', 437980),
('MOSCOW', 11630060),
('PRAGUE',1980231);


--FUNC LOOMINE
--FUNC, MIS LISAB UUS LINN JA KOHE NÄITAB TAVELIS

CREATE PROCEDURE lisaLinn
@lnimi varchar(30),
@rarv int
AS
BEGIN
INSERT INTO Linn(linnNIMI, rahvaARV)
VALUES (@lnimi, @rarv);
SELECT * FROM Linn
END;


--FUNC KUTSE
EXEC lisaLinn @lnimi='TESTLINN',@rarv=000000
--LIHTSAM FUNC KUTSE
EXEC lisaLinn 'TEST5',5


--FUNC MIS KUSTUTAB LINN ID JARGI
CREATE PROCEDURE KustutaLinn
@lID int
AS
BEGIN
SELECT * FROM Linn
DELETE FROM Linn WHERE LinnID = @lID;
SELECT * FROM Linn
END;

EXEC KustutaLinn 6;


--KUSTUTA PROTSEDUUR
DROP PROCEDURE KustutaLinn;


--FUNC MIS OTSIB LINN ESIMESE TÄHTE JARGI
CREATE PROCEDURE LinnaOtsing
@taht CHAR(1)
AS 
BEGIN
SELECT * FROM Linn
WHERE linnNIMI LIKE @taht + '%';
--% - kõik teised tähted
END;
--kutse
EXEC LinnaOtsing '%'


--TABELI UUENDAMINE 10% võrra
UPDATE Linn SET rahvaARV *= 1.1
SELECT * FROM Linn
UPDATE Linn SET rahvaARV *= 1.1
WHERE linnID = 1
SELECT * FROM Linn


CREATE PROCEDURE rahvaArvuUuendus
@linnaID INT,
@koef DECIMAL(2,1)
AS
BEGIN
SELECT * FROM Linn;
UPDATE Linn SET rahvaARV *= @koef
WHERE linnID = @linnaID
SELECT * FROM Linn;
END;

EXEC rahvaArvuUuendus 2,2


--KASUTAME XAMPP
--############################################
--##############/////XAMPP/////###############
--############################################

CREATE TABLE Linn
(
linnID INT PRIMARY KEY AUTO_INCREMENT,
linnNIMI VARCHAR(30), 
rahvaARV INT
);

INSERT INTO Linn(linnNIMI, rahvaARV)
VALUES
('TALLINN', 437980),
('MOSCOW', 11630060),
('PRAGUE',1980231);

BEGIN --#PNG1
INSERT INTO Linn(linnNIMI, rahvaARV)
VALUES (lnimi, rarv);
SELECT * FROM Linn;
END;

CALL lisaLinn ('NARVA', 255555);

BEGIN --#PNG1
DELETE FROM Linn WHERE LinnID = lID;
END;

CALL KustutaLinn (1);

BEGIN --PNG1
SELECT * FROM Linn
WHERE linnNIMI LIKE CONCAT(taht, '%'); 
END;

BEGIN --#PNG1
SELECT * FROM Linn;
UPDATE Linn SET rahvaARV=rahvaARV*koef 
WHERE linnID = linnaID;
SELECT * FROM Linn;
END;
-------------------------------------------------------------------07.02.2025
--PROTSEDUURID ###

select * from Linn

CREATE PROCEDURE lisaLinn
@lnimi varchar(30),
@rarv int
AS
BEGIN
INSERT INTO Linn(linnNIMI, rahvaARV)
VALUES (@lnimi, @rarv);
SELECT * FROM Linn
END;

delete from linn where linnID = 5

--UUE VEERU LISAMINE
ALTER TABLE linn ADD test int;

--VEERU KUSTUTAMINE 
ALTER TABLE linn DROP COLUMN test;



CREATE PROCEDURE veeruLisaKustuta
@valik varchar(20),
@veerunimi varchar(20),
@tyyp varchar(20) = NULL
AS
BEGIN
DECLARE @sqltegevus as varchar(max)
set @sqltegevus=case
when @valik='add' then concat('ALTER TABLE linn ADD ', @veerunimi, ' ', @tyyp)
when @valik='drop' then concat('ALTER TABLE linn DROP COLUMN ', @veerunimi)
END;
print @sqltegevus;
BEGIN
EXEC (@sqltegevus);
END
END;

EXEC veeruLisaKustuta @valik='add', @veerunimi='test3', @tyyp='int';

EXEC veeruLisaKustuta @valik='DROP', @veerunimi='test';

SELECT * FROM linn



--PROCEDURE VEERULISAKUSTUTA TABELIS
CREATE PROCEDURE veeruLisaKustutaTabelis
@valik varchar(20),
@tabelinimi varchar(20),
@veerunimi varchar(20),
@tyyp varchar(20) = NULL
AS
BEGIN
DECLARE @sqltegevus as varchar(max)
set @sqltegevus=case
when @valik='add' then concat('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi, ' ', @tyyp)
when @valik='drop' then concat('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)
END;
print @sqltegevus;
BEGIN
EXEC (@sqltegevus);
END
END;

exec veeruLisaKustutaTabelis


EXEC veeruLisaKustutaTabelis @valik='add', @tabelinimi='linn', @veerunimi='test3', @tyyp='int';

EXEC veeruLisaKustutaTabelis @valik='DROP', @tabelinimi='linn', @veerunimi='test3';

SELECT * FROM linn


--protseduur tingimused

CREATE PROCEDURE rahvaHinnang
@piir int
AS
BEGIN
SELECT linnNIMI, IIF(rahvaARV < @piir, 'vaike linn', 'suur linn') as Hinnang
FROM linn;
END;

EXEC rahvaHinnang 555555;

DROP PROCEDURE rahvaHinnang;

--AGREGAAT FUNKTSIOONID; SUM() AVG() MIN() MAX() COUNT()

CREATE PROCEDURE kokkuRahvaARV

AS
BEGIN
SELECT SUM(rahvaARV) AS 'KokkuRahvaARV', AVG(rahvaARV) AS 'Keskine rahvaarv', COUNT(*) AS 'Linnade arv'
FROM linn;
END;

DROP PROCEDURE kokkuRahvaARV
