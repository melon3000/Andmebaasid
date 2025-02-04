--AB loomine 
Create database melonBaas;

use melonBaas;
CREATE TABLE opilane
(
opilaneId int primary key identity(1,1),
eesnimi varchar(25) not null,
perenimi varchar(25) not null,
synniaeg date,
stip bit,
aadress text,
keskmine_hind decimal(2,1),
)

select * from opilane;
--andmete lisamine tabelisse
INSERT INTO opilane(
eesnimi,
perenimi,
synniaeg,
stip,
keskmine_hind)
VALUES(
'Edgar',
'Gerrasimov',
'2007-9-19',
1,
4.5),
(
'Robert',
'Lettens',
'2007-8-14',
0,
2),
(
'Artur',
'Petrovski',
'2007-4-25',
0,
4),
(
'Doritos',
'Pekin',
'2007-9-19',
1,
3.5),
(
'Mek',
'Stander',
'2007-9-19',
1,
3.5)

--drop table / tabeli kustutus
drop table opilane;

--Kustuta rida kus opilaneId = 2
DELETE FROM opilane WHERE opilaneId=2;
select * from opilane;

--andmete uuendamine kus opilaneId = 1
UPDATE opilane SET aadress='Astangu' WHERE opilaneId=1;
select * from opilane;


CREATE TABLE Language
(
ID int NOT NULL PRIMARY KEY,
Code char(3) NOT NULL,
Language varchar(50) NOT NULL,
IsOfficial bit,
Percentage smallint
);
select * from Language;	

INSERT INTO Language(ID, Code, Language)
Values(2, 'ENG', 'GER'), (3, 'RUS', 'BEL'), (4, 'ARG', 'ARG')


CREATE TABLE keeleValik
(
keeleValikID int primary key identity(1,1),
valikuNimetus varchar(10) not null, 
opilaneId int,
Foreign key(opilaneId) references opilane(opilaneId),
Language int,
Foreign key(Language) references Language(ID)
)

SELECT * FROM keeleValik;
SELECT * FROM Language;
SELECT * FROM opilane;	

INSERT INTO keeleValik(valikuNimetus, opilaneId, Language)
Values('Valik D', 4, 4 )


SELECT opilane.eesnimi, Language.Language
from opilane, Language, keeleValik
WHERE opilane.opilaneId=keeleValik.opilaneID
AND  Language.ID=keeleValik.Language

SELECT *
from opilane, Language, keeleValik
WHERE opilane.opilaneId=keeleValik.opilaneID
AND  Language.ID=keeleValik.Language

INSERT INTO keeleValik(valikuNimetus, opilaneId, Language)
Values('Valik D', 4, 4 )

CREATE TABLE oppimine
(
oppimineId int primary key identity(1,1),
aine text not null, 
aasta char(4),
opetaja varchar(25),
opilaneID int not null,
FOREIGN KEY (opilaneID) REFERENCES opilane(opilaneID),
hinne int check (hinne BETWEEN 1 AND 5)
)

SELECT * FROM keeleValik;
SELECT * FROM Language;
SELECT * FROM opilane;	
SELECT * FROM oppimine;	

INSERT INTO oppimine(aine, aasta, opetaja, opilaneID, hinne)
Values('Inglise keel', 2025, 'Irina Merkulova', 1, 5)

---------------------------------------------------------------------------------------------------------------------------------
--4.02.2025/tunnitöö funktsioonid sql opilane tabeliga

--LISAB OPILANE TABELISSE
CREATE PROCEDURE LisaOpilane
@nimi varchar(25),
@pnimi varchar(25),
@synniaeg date,
@stip bit,
@aadress text,
@k_hind decimal(2,1)
AS
BEGIN
SELECT * FROM opilane
INSERT INTO opilane(eesnimi, perenimi, synniaeg,stip,aadress,keskmine_hind)
VALUES(@nimi, @pnimi, @synniaeg, @stip, @aadress, @k_hind);
SELECT * FROM opilane
END;

EXEC LisaOpilane 'Milan', 'Petrovski', '2025-05-22', 1, 'TALLINN', 4.2 


--KUSTUTAB OPILANE TABELIST
CREATE PROCEDURE OpilaneKustuta
@opID int
AS 
BEGIN
SELECT * FROM opilane
DELETE FROM opilane 
WHERE opilaneId = @opID
SELECT * FROM opilane
END;

EXEC OpilaneKustuta '2'


--OTSIB OPILANE ESIMESE TÄHTE JARGI
CREATE PROCEDURE OpilaneOtsing
@taht CHAR(1)
AS 
BEGIN
SELECT * FROM opilane
WHERE eesnimi LIKE @taht + '%';
SELECT * FROM opilane
END;

EXEC OpilaneOtsing 'M'


--MUUDAB OPILANE STIP
CREATE PROCEDURE MuudaOpilaseStip
@MopID INT,
@Mstip BIT
AS 
BEGIN
SELECT * FROM opilane
UPDATE opilane SET stip = @Mstip
WHERE opilaneId = @MopID
SELECT * FROM opilane
END;

EXEC MuudaOpilaseStip 1, 0

