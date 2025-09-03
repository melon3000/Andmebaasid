
--    Andmebaasinimi - Autod
--    Loo tabel Auto (aasta,nimetus,värv, mark).
--    Loo tabel trigerite töö salvestamiseks. Näiteks tabel logi (logiID, kuupaev, andmed, kasutaja).
--    Trigger lisamiseks ja kustutamiseks
--    Kasutajanimi, kes saab töötada ainult varem loodud tabeliga (mitte logi tabel) - managerNimi

CREATE DATABASE AUTOD
USE AUTOD

----------

CREATE TABLE Auto(
aasta INT,
nimetus VARCHAR(100),
värv VARCHAR (35),
mark VARCHAR(10),
);

CREATE TABLE Logi(
logiId INT PRIMARY KEY IDENTITY(1,1),
kuupaev DATE,
andmed VARCHAR(100),
kasutaja VARCHAR(20)
);

----------
--lisamine triger
CREATE TRIGGER AutoLisamine
ON Auto
FOR INSERT
AS
INSERT INTO Logi (kuupaev, kasutaja, andmed)
SELECT
    GETDATE(),
    SYSTEM_USER,
    CONCAT('Auto on lisatud: ', aasta, ' ', värv, ' ', mark, ' ', nimetus)
FROM inserted;


insert INTO Auto
VALUES(2021, 'Land Cruiser 200', 'must', 'toyota' )

select * from logi

--kustutamise triger
CREATE TRIGGER AutoKustutamine
ON Auto
FOR DELETE
AS
INSERT INTO Logi (kuupaev, kasutaja, andmed)
SELECT
    GETDATE(),
    SYSTEM_USER,
    CONCAT('Auto on kustatud ', aasta, ' ', värv, ' ', mark, ' ', nimetus)
FROM deleted;

DELETE FROM Auto WHERE mark = 'toyota' AND nimetus = 'Land Cruiser 200'

select * from logi

-- kasutaja loomine
CREATE LOGIN managerMilan WITH PASSWORD = 'TARpv24!kontoParool';

CREATE USER managerMilan FOR LOGIN managerMilan;

GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Auto TO managerMilan;

DENY SELECT, INSERT, UPDATE, DELETE ON dbo.Logi TO managerMilan;
