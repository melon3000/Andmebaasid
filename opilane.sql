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
