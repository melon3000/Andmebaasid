create table kasutaja(
kasutaja_id int primary key AUTO_INCREMENT,
eesnimi varchar(50),
perenimi varchar(50) not null,
email varchar(150));      


INSERT INTO kasutaja(eesnimi,perenimi, email)
VALUES('Milan', 'Petrovski', 'MILAN.PETROVSKI8@gmail.com'),
('Milan2', 'Petrovski2', 'MILAN.PETROVSKI8@gmail.com'),('Milan3', 'Petrovski3', 'MILAN.PETROVSKI8@gmail.com'),
('Milan4', 'Petrovski4', 'MILAN.PETROVSKI8@gmail.com'),('Milan5', 'Petrovski5', 'MILAN.PETROVSKI8@gmail.com');
SELECT * FROM kasutaja


CREATE TABLE kategootia(
kategooria_id int primary key AUTO_INCREMENT,
kategooria_nimi varchar(50)
)
INSERT INTO kategootia(kategooria_nimi)
VALUES('Supp'),('Kurk'), ('Salatid'), ('Porg'), ('Makaronnid');
SELECT * FROM kategootia


CREATE TABLE toiduaine(
toiduaine_id int primary key AUTO_INCREMENT,
toiduaine_nimi varchar(100)
)
INSERT INTO toiduaine(toiduaine_nimi)
VALUES('veiseliha'), ('sibul'), ('sibul'), ('porgand'), ('õlu');
SELECT * FROM toiduaine


CREATE TABLE yhik(
yhik_id int primary key AUTO_INCREMENT,
yhik_nimi varchar(100)
)              
INSERT INTO yhik(yhik_nimi)
VALUES('kg'), ('tl'), ('sl'), ('g'), ('ml'); 
SELECT * FROM yhik


CREATE TABLE Retsept(
retsept_id int primary key AUTO_INCREMENT,
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


CREATE TABLE Koostis(
koostis_id int primary key AUTO_INCREMENT,
kogus int,
retsept_retsept_id int,
toiduaine_id int,
yhik_id int,
FOREIGN KEY (retsept_retsept_id) references retsept(retsept_id),
FOREIGN KEY (toiduaine_id) references toiduaine(toiduaine_id),
FOREIGN KEY (yhik_id) references yhik(yhik_id)                             
)
INSERT INTO Koostis(kogus, retsept_retsept_id, toiduaine_id, yhik_id)
VALUES(3, 4, 1, 1),
(2, 5, 2, 2),
(1, 3, 3, 4),
(4, 5, 4, 1);


CREATE TABLE Tehtud(
tehtud_id int primary key AUTO_INCREMENT,
tehtud_kp date,
retsept_id int,
FOREIGN KEY (retsept_id) references retsept(retsept_id)
)
INSERT INTO Tehtud(tehtud_kp, retsept_id)
VALUES('2022-12-03', 1),
('2021-11-14', 2),
('2030-09-01', 3),
('2003-02-14', 4),
('2005-11-08', 5);


#Loo funktsioon "Addrecept"
BEGIN
INSERT INTO retsept(retsept_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id, kategooria_id)
VALUES(retsept_nimi,kirjeldus,juhend,sisetatud_kp,kasutaja_id, kategooria_id);
END;
