Create database retseptiRaamatPetrovski;            
use retseptiRaamatPetrovski;                         #создание базы
--------------------------------
create table kasutaja(
kasutaja_id int primary key identity(1,1),
eesnimi varchar(50),
perenimi varchar(50) not null,
email varchar(150));                                 #создание и заполнение таблицы kasutaja

INSERT INTO kasutaja(eesnimi,perenimi, email)
VALUES('Milan', 'Petrovski', 'MILAN.PETROVSKI8@gmail.com'),
('Milan2', 'Petrovski2', 'MILAN.PETROVSKI8@gmail.com'),('Milan3', 'Petrovski3', 'MILAN.PETROVSKI8@gmail.com'),
('Milan4', 'Petrovski4', 'MILAN.PETROVSKI8@gmail.com'),('Milan5', 'Petrovski5', 'MILAN.PETROVSKI8@gmail.com');
SELECT * FROM kasutaja
----------------------------------
CREATE TABLE kategootia(
kategooria_id int primary key identity(1,1),
kategooria_nimi varchar(50)                          #создание и заполнение таблицы kategooria
)
INSERT INTO kategootia(kategooria_nimi)
VALUES('Supp'),('Kurk'), ('Salatid'), ('Porg'), ('Makaronnid');
SELECT * FROM kategootia
-----------------------------------------------------------------
CREATE TABLE toiduaine(
toiduaine_id int primary key identity(1,1),
toiduaine_nimi varchar(100)
)
                                                 #создание и заполнение таблицы toiduaine
INSERT INTO toiduaine(toiduaine_nimi)
VALUES('veiseliha'), ('sibul'), ('sibul'), ('porgand'), ('õlu');
SELECT * FROM toiduaine
-----------------------------------------------------------------------
CREATE TABLE yhik(
yhik_id int primary key identity(1,1),
yhik_nimi varchar(100)
)                                              #создание и заполнение таблицы yhik
INSERT INTO yhik(yhik_nimi)
VALUES('kg'), ('tl'), ('sl'), ('g'), ('ml'); 
SELECT * FROM yhik
------------------------------------------------------------
CREATE TABLE Retsept(
retsept_id int primary key identity(1,1),
retsept_nimi varchar(100),
kirjeldus varchar(200),
juhend varchar(500),
sisestatud_kp date,
kasutaja_id int,
foreign key (kasutaja_id) references kasutaja(kasutaja_id),                 #создание и заполнение таблицы Retsept
kategooria_id int,
foreign key (kategooria_id) references kategootia(kategooria_id)
)

INSERT INTO Retsept(retsept_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id, kategooria_id)
VALUES('Pizza', 'vorst', 'kasuta elekripliit', '1999-12-01', 1, 1),
('omlett', 'munad', 'kasuta elekripliit', '1700-07-13', 2, 2),
('õlu', 'hmel', 'kasuta pivovarnja', '2003-10-10', 3, 3),
('Borši', 'köögiviljad', 'kasuta elekripliit', '1995-8-19', 4, 4),
('stake', 'liha', 'grill', '2012-11-11', 5, 5);

SELECT * FROM Retsept
-------------------------------------------------------------
CREATE TABLE Koostis(
koostis_id int primary key identity,
kogus int,
retsept_retsept_id int,
toiduaine_id int,
yhik_id int,
FOREIGN KEY (retsept_retsept_id) references retsept(retsept_id),
FOREIGN KEY (toiduaine_id) references toiduaine(toiduaine_id),
FOREIGN KEY (yhik_id) references yhik(yhik_id)                               #создание и заполнение таблицы Koostis
)

INSERT INTO Koostis(kogus, retsept_retsept_id, toiduaine_id, yhik_id)
VALUES(3, 4, 1, 1),
(2, 5, 2, 2),
(1, 3, 3, 4),
(4, 5, 4, 1);
SELECT * FROM Koostis
------------------------------------------------------
CREATE TABLE Tehtud(
tehtud_id int primary key identity(1,1),
tehtud_kp date,
retsept_id int,
FOREIGN KEY (retsept_id) references retsept(retsept_id)
)

INSERT INTO Tehtud(tehtud_kp, retsept_id)                       #создание и заполнение таблицы Tehtud
VALUES('2022-12-03', 1),
('2021-11-14', 2),
('2030-09-01', 3),
('2003-02-14', 4),
('2005-11-08', 5);

SELECT * FROM Tehtud
-------------------------------------------------------
create procedure Addrecept
@retsept_nimi varchar(100),
@kirjeldus varchar(200),
@juhend varchar(500),
@sisetatud_kp date,
@kasutaja_id int,
@kategooria_id int                  #Создание и заполнение процедуры Addrecept
as
begin

INSERT INTO Retsept(retsept_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id, kategooria_id)
values(@retsept_nimi,@kirjeldus,@juhend,@sisetatud_kp,@kasutaja_id, @kategooria_id);
end;
-----------------------------------------------------
create procedure Addkoostis
@kogus int,
@retsept_retsept_id int,
@toiduaine_id int,
@yhik_id int
as                                                  #Создание и заполнение процедуры Addkoostis
begin

INSERT INTO Koostis(kogus, retsept_retsept_id, toiduaine_id, yhik_id)
values(@kogus, @retsept_retsept_id, @toiduaine_id, @yhik_id);
end;
------------------------------------------------------
create procedure Addtehtud
@tehtud_id int,
@tehtud_kp date,
@retsept_id int
as
begin

INSERT INTO Tehtud(tehtud_id, tehtud_kp, retsept_id)           #Создание и заполнение процедуры Addtehtud
values(@tehtud_id, @tehtud_kp, @retsept_id);
end;
--------------------------------------------------------
CREATE TABLE Kokad(
tehtud_id int primary key identity(1,1),
kokk_nimi varchar(30),
kokk_perenimi varchar(30),                          #Создание и связывание таблицы Kokad
retsept_id int,
foreign key (retsept_id) references Retsept(retsept_id))
drop table Kokad
--------------------------------------------------
create procedure Addkokad
@tehtud_id int,
@kokk_nimi varchar(30),
@kokk_perenimi varchar(30)                #Создание процедуры Addkokad
as
begin
INSERT INTO Addkokad(tehtud_id, kokk_nimi , kokk_perenimi)
values(@tehtud_id, @kokk_nimi, @kokk_perenimi);
end;
