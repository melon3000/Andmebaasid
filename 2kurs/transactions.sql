create database melon3000
use melon3000

Create table linnad(
linnID int identity(1,1) PRIMARY KEY,
linnanimi varchar(15),
rahvaarv int);

--tabeli logi näitab adminile kuidas tabel linnad kasutatakse, tabel logi taidab triger

Create table logi(
id int identity (1,1)PRIMARY KEY,
aeg DATETIME,
toiming  varchar(100),
andmed varchar(200),
kasutaja varchar(100)
)

-- insert Triger, mis jälgib tabeli linnad täitmine
create trigger linnalisamine
on linnad
for insert
as
insert into logi(aeg, kasutaja, toiming, andmed)
select
getdate(),
system_user,
'linn on lisatud',
inserted.linnanimi
from inserted;

--trigeri  tegevuse kontroll
insert into linnad(linnanimi, rahvaarv)
values('tallinn', 65000);
select * from linnad;
select * from logi;



--tabelite kustutamine
DELETE FROM logi
DELETE FROM linnad


--triger mis jälgib linnade kustutamine
create trigger linnakustutamine
on linnad
for delete
as
insert into logi(aeg, kasutaja, toiming, andmed)
select
getdate(),
system_user,
'linn on kustatud',
deleted.linnanimi
from deleted;

--kontroll
delete from linnad where linnID=8;
SELECT * FROM linnad
SELECT * FROM LOGI


--triger mis jälgib linnade UPDATE
create trigger linnaupdate
on linnad
for update
as
insert into logi(aeg, kasutaja, toiming, andmed)
select
getdate(),
system_user,
'linn on updated',
concat('vanadandmed:', deleted.linnanimi,'/', deleted.rahvaarv, 'uued andmed: ', inserted.linnanimi, '/', inserted.rahvaarv)
FROM deleted INNER JOIN inserted ON deleted.linnID = inserted.linnID

--kontroll
update linnad set rahvaarv=8
where linnID = 9;
SELECT * FROM linnad
SELECT * FROM LOGI

DISABLE TRIGGER linnalisamine ON linnad
ENABLE TRIGGER linnalisamine ON linnad
--KASUTAJA NIMEGA SEKRETARNIMI PAROOLIGA KALA JA SEKRETARNIMI EI NÄE TABELI LOGI JA EI SAA TRIGERID MUUTA

DENY SELECT ON dbo.logi TO sekretarmelon;
DENY ALTER ON dbo.linnad TO sekretarmelon;
