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
