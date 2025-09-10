  -- 1. lOOMe baas
CREATE DATABASE triger2tabelid;
USE triger2tabelid;

-- 2. loome Tabel toodekategooria
CREATE TABLE toodekategooria (
    toodekategooriaID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    toodekategooria VARCHAR(100) UNIQUE,
    kirjeldus TEXT
);

-- 3. loome tabel toode
CREATE TABLE toode (
    toodeID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    toodeNimetus VARCHAR(100) UNIQUE,
    hind DECIMAL(5,2),
    toodekategooriaID INT,
    FOREIGN KEY (toodekategooriaID)
        REFERENCES toodekategooria(toodekategooriaID)
);

-- 4. lisan kategooria ja kontrollime
INSERT INTO toodekategooria(toodekategooria)
VALUES ('meelelahutus');

SELECT * FROM toodekategooria;

-- 5. lisame toodet ja kontrollme
INSERT INTO toode(toodeNimetus, hind, toodekategooriaID)
VALUES ('kino', 10, 1);

SELECT * 
FROM toode 
INNER JOIN toodekategooria 
  ON toode.toodekategooriaID = toodekategooria.toodekategooriaID;

-- 6.loome tabel logi
CREATE TABLE logi (
    LogiID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    kuupaev DATETIME,
    kasutaja VARCHAR(100),
    andmed TEXT
);

-- ##################################
-- ##        LOOME TRIGERID        ##
-- ##################################
--1.TRIGGER
--NIMI: ToodeKustutamine
--TABEL: TOODE
--AEG: AFTER
--SÜNDMUS: DELETE
--KOOD:
INSERT INTO logi (aeg, toiming, andmed)
SELECT 
    NOW(),
    'toode kustutatud',
    CONCAT('kustutatud toode ', OLD.toodeNimetus, ', hind: ', OLD.hind, ', kategooria: ', k.toodekategooria)
FROM toode t
INNER JOIN toodekategooria k ON OLD.toodekategooriaID = k.toodekategooriaID
WHERE t.toodeID = OLD.toodeID;

  
--2.TRIGGER
--NIMI: ToodeLisamine
--TABEL: TOODE
--AEG: AFTER
--SÜNDMUS: INSERT
--KOOD:
INSERT INTO logi (aeg, toiming, andmed)
SELECT 
    NOW(),
    'toode lisatud',
    CONCAT('lisatud toode ', NEW.toodeNimetus, ', hind: ', NEW.hind, ', kategooria: ', k.toodekategooria)
FROM toode t
INNER JOIN toodekategooria k ON NEW.toodekategooriaID = k.toodekategooriaID
WHERE t.toodeID = NEW.toodeID;

--2.TRIGGER
--NIMI: ToodeMuutumine
--TABEL: TOODE
--AEG: AFTER
--SÜNDMUS: UPDATE
--KOOD:
INSERT INTO logi (aeg, toiming, andmed)
SELECT 
    NOW(),
    'toode muudetud',
    CONCAT(
        'vana: ', OLD.toodeNimetus, ', ', OLD.hind, ', ', k1.toodekategooria,
        ' | uus: ', NEW.toodeNimetus, ', ', NEW.hind, ', ', k2.toodekategooria
    )
FROM toode t
INNER JOIN toodekategooria k1 ON OLD.toodekategooriaID = k1.toodekategooriaID
INNER JOIN toodekategooria k2 ON NEW.toodekategooriaID = k2.toodekategooriaID
WHERE t.toodeID = NEW.toodeID;




-- 10.  trigerid kontroll
INSERT INTO toodekategooria(toodekategooria) VALUES ('toit');
INSERT INTO toode(toodeNimetus, hind, toodekategooriaID) VALUES ('kook', 5.50, 2);

UPDATE toode SET hind = 6.00 WHERE toodeNimetus = 'kook';

DELETE FROM toode WHERE toodeNimetus = 'kook';

-- 11. vaatan loog
SELECT * FROM logi ORDER BY kuupaev DESC;
