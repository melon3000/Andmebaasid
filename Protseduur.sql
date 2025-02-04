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
@taht char(1)
AS 
BEGIN
SELECT * FROM Linn
WHERE linnNIMI LIKE @taht + '%';
--% - kõik teised tähted
END;
--kutse
EXEC LinnaOtsing '%'


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

CREATE PROCEDURE `lisaLinn`(IN `lnimi` VARCHAR(30), IN `rarv` INT) NOT DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER BEGIN --#PNG1
INSERT INTO Linn(linnNIMI, rahvaARV)
VALUES (lnimi, rarv);
SELECT * FROM Linn;
END;

CALL lisaLinn ('NARVA', 255555);

CREATE PROCEDURE `KustutaLinn`(IN `lID` INT) NOT DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER BEGIN --#PNG1
DELETE FROM Linn WHERE LinnID = lID;
END;
