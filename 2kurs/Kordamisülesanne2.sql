  -- 1. lOOMe baas
CREATE DATABASE triger3tabelid;
USE triger3tabelid;

-- 2. loome Tabel toodekategooria
CREATE TABLE toodekategooria (
    toodekategooriaID INT NOT NULL identity(1,1) PRIMARY KEY,
    toodekategooria VARCHAR(100) UNIQUE,
    kirjeldus TEXT
);

-- 3. loome tabel toode
CREATE TABLE toode (
    toodeID INT NOT NULL identity(1,1) PRIMARY KEY,
    toodeNimetus VARCHAR(100) UNIQUE,
    hind DECIMAL(5,2),
    toodekategooriaID INT,
    FOREIGN KEY (toodekategooriaID)
        REFERENCES toodekategooria(toodekategooriaID)
);

INSERT INTO toodekategooria (toodekategooria, kirjeldus)
VALUES
('Electronics', 'Devices like phones, laptops, and accessories'),
('Furniture', 'Various types of furniture for home and office'),
('Clothing', 'Apparel for men, women, and children'),
('Toys', 'Toys and games for children of all ages'),
('Food', 'Groceries and other consumables');

INSERT INTO toode (toodeNimetus, hind, toodekategooriaID)
VALUES
('Smartphone', 499.99, 1),  -- Electronics
('Office Chair', 129.99, 2),  -- Furniture
('T-Shirt', 19.99, 3),  -- Clothing
('Lego Set', 59.99, 4),  -- Toys
('Apple', 1.50, 5);  -- Food

--2 views
-- Loo vaade, mis kuvab ainult toodete nime ja hinna

select * from toode
select * from toodekategooria

create view toode_nime_hind as
	select toodeNimetus, hind from toode

select * from toode_nime_hind


--Loo vaade, mis näitab kõiki tooteid koos kategooria nimega.
Create view kat_tooded as
select t.toodeID, tk.toodekategooria
from toode t
inner join toodekategooria tk on t.toodekategooriaID=tk.toodekategooriaID 

select * from kat_tooded

-- tabeli struktuuri muutumine, uue veergu lisamine 
alter table toode
add aktiivne BIT 

UPDATE toode set aktiivne = 1
update toode set aktiivne = 0 where toodeID = 3

--Loo vaade, mis kuvab ainult aktiivseid (nt saadaval olevaid) tooteid.

Create view saadav_toode as
select * from toode
where aktiivne = 1
select * from saadav_toode



	--Loo vaade, mis koondab info: kategooria nimi, toodete arv, minimaalne ja maksimaalne hind.
CREATE VIEW KategooriadInfo AS
    SELECT toodekategooria.toodekategooria, 
           COUNT(*) AS 'Toodete_Arv', 
           CAST(MIN(t.hind) AS DECIMAL(5,1)) AS 'Min_Hind', 
           CAST(MAX(t.hind) AS DECIMAL(5,1)) AS 'Max_Hind'
    FROM toodekategooria
    INNER JOIN toode t ON t.toodekategooriaID = toodekategooria.toodekategooriaID
    GROUP BY toodekategooria.toodekategooria;

select * from KategooriadInfo



-- Loo vaade, mis arvutab toode käibemaksu (24%) ja iga toode hind käibemaksuga.
create view toode_kaibemaksuga as
	select toodenimetus, hind, 
	CAST((hind * 0.24) as decimal(5,2)) as 'Käibemaks',
	CAST((hind * 1.24) as decimal(5,2)) as 'Hind_käibemaksuga'
from toode
		
select * from toode_kaibemaksuga

--protseduurid

--Loo protseduur, mis lisab uue toote (sisendparameetrid: tootenimi, hind, kategooriaID).
create procedure toodesse_panna
@toodenimetus varchar(200),
@hind int,
@toodeKategooriaID int
as 
begin
select * from toode
insert into toode(toodeNimetus, hind, toodekategooriaID)
VALUES(@toodenimetus, @hind, @toodeKategooriaID)
end
select * from toode

exec toodesse_panna 'pepsi',1 ,2



--Loo protseduur, mis uuendab toote hinda vastavalt tooteID-le.
create procedure update_hind
@toode_ID  INT,
@hind decimal (5,2)
as 
begin 
select * from toode;
update toode set hind = @hind
where toodeid=@toode_ID
select * from toode;
end
exec update_hind 3.5, 3

--Loo protseduur, mis kustutab toote ID järgi.
create procedure kustuta_toode
@toodeID int
as
begin
select * from toode
delete from toode 
where toodeID=@ToodeId
select * from toode
end;

exec kustuta_toode 7

--Loo protseduur, mis tagastab kõik tooted valitud kategooriaID järgi.
create procedure LeiaToodeKategooriaIdJargi
@kategooria varchar(30)
as
begin
select toodekategooria, toodeNimetus, hind
from toode t
inner join toodekategooria tk on tk.toodekategooriaID=t.toodekategooriaID 
where tk.toodekategooria = @kategooria
end;

drop procedure LeiaToodeKategooriaIdJargi

exec LeiaToode	KategooriaIdJargi food

--Loo protseduur, mis tõstab kõigi toodete hindu kindlas kategoorias kindla protsendi võrra.
create procedure Protsenti
@kategooriaid int
as
begin
select * from toode
update toode set hind = hind * 1.15	
where toodekategooriaID=@kategooriaid
select * from toode
end;


exec protsenti 3


--Loo protseduur, mis kuvab kõige kallima toote kogu andmebaasis.
create procedure kallim_hind
as
begin
select top 1 * from toode
order by hind desc
end

drop procedure kallim_hind

exec kallim_hind

--------------------------ÜLESANNE

-- 1. Loome andmebaasi
CREATE DATABASE trigerstabelid;
USE trigerstabelid;


-- 2. Loome tabelid
CREATE TABLE toodekategooria (
    toodekategooriaID INT IDENTITY(1,1) PRIMARY KEY,
    toodekategooria NVARCHAR(100) UNIQUE,
    kirjeldus NVARCHAR(MAX)
);

CREATE TABLE toode (
    toodeID INT IDENTITY(1,1) PRIMARY KEY,
    toodeNimetus NVARCHAR(100) UNIQUE,
    hind DECIMAL(10,2),
    toodekategooriaID INT,
    FOREIGN KEY (toodekategooriaID)
        REFERENCES toodekategooria(toodekategooriaID)
);

-- 3. Andmete sisestamine
INSERT INTO toodekategooria (toodekategooria, kirjeldus)
VALUES
(N'Electronics', N'Devices like phones, laptops, and accessories'),
(N'Furniture', N'Various types of furniture for home and office'),
(N'Clothing', N'Apparel for men, women, and children'),
(N'Toys', N'Toys and games for children of all ages'),
(N'Food', N'Groceries and other consumables');

INSERT INTO toode (toodeNimetus, hind, toodekategooriaID)
VALUES
(N'Smartphone', 499.99, 1),
(N'Office Chair', 129.99, 2),
(N'T-Shirt', 19.99, 3),
(N'Lego Set', 59.99, 4),
(N'Apple', 1.50, 5);

CREATE LOGIN toodehaldur WITH PASSWORD = 'ParoolSUPER123!';
CREATE LOGIN kataloogihaldur WITH PASSWORD = 'ParoolSUPER223!';
CREATE LOGIN vaataja WITH PASSWORD = 'ParoolSUPER323!';

CREATE USER toodehaldur FOR LOGIN toodehaldur;
CREATE USER kataloogihaldur FOR LOGIN kataloogihaldur;
CREATE USER vaataja FOR LOGIN vaataja;

GRANT CONNECT TO toodehaldur;
GRANT CONNECT TO kataloogihaldur;
GRANT CONNECT TO vaataja;

GRANT INSERT, UPDATE, DELETE ON OBJECT::dbo.toode TO toodehaldur;
GRANT INSERT, UPDATE, SELECT ON OBJECT::dbo.toodekategooria TO kataloogihaldur;
GRANT SELECT ON OBJECT::dbo.toode TO vaataja;
GRANT SELECT ON OBJECT::dbo.toodekategooria TO vaataja;

SELECT 
	CONCAT(table_schema, '.', table_name) AS scope,
	grantee,
	privilege_type
FROM INFORMATION_SCHEMA.TABLE_PRIVILEGES
