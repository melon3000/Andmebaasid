CREATE DATABASE epoodPetrovski;

use epoodPetrovski;

--LOO TABEL CATEGORY
CREATE TABLE Category(
CategoryID int primary key identity(1,1),
CategoryName varchar(25) UNIQUE,
)


insert into Category (CategoryName)
values('auto'), ('garaaz');

--TABELI STRUKTUURI MUUTMINE --> uue veergu lisamine
ALTER TABLE Category ADD test int;

--TABELI STRUKTUURI MUUTMINE --> veergu kustutamine
ALTER TABLE Category DROP COLUMN test;


--LOO TABEL PRODUCT
CREATE TABLE Product(
ProductID INT PRIMARY KEY IDENTITY(1,1),
ProductName VARCHAR(25) UNIQUE,
CategoryID INT,
FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
Price decimal(10,2)
);

insert into Product(ProductName, CategoryID, Price)
values
('BMW M3',1, 90000),
('SKODA OKTAVIA',1, 12000),
('30m2 Garaaz',2, 52000),
('Universal 2', 2, 12000),
('Audi RS5',1, 12000)
;

select * from Category
select * from Product
select * from sale

--LOO TABEL SALE
CREATE TABLE Sale (
SaleID INT PRIMARY KEY IDENTITY(1,1),
ProductID INT,
FOREIGN KEY(ProductID) REFERENCES Product(ProductID),
CustomerID INT,
Count_ INT,
DateOfSale date
);

CREATE TABLE Customer (
CustomerID int primary key identity(1,1),
Name_ varchar(25),
contact text
);

insert into Customer(Name_, contact)
values 
('Robert', 'robikpro25@gmail.com'),
('Edgar', 'redga2@gmail.com'),
('Gabb', 'gabb4444@gmail.com'),
('Ceen', 'ceenpo5@gmail.com'),
('Roman', 'romanzai@gmail.com')



--TABELI MUUTMINE LOO FOREIGN KEY
alter table sale add foreign key(CustomerID) references Customer(CustomerID)


insert into Sale(ProductID, CustomerID, Count_, DateOfSale)
values
(1, 5, 2, '2023-1-13'),
(1, 1, 2, '2025-1-13'),
(3, 3, 5, '2025-1-13'),
(3, 4, 1, '2025-1-13'),
(4, 5, 2, '2025-1-13')


--CUSTOMER > SALE


select * from Category
select * from Product
select * from Customer
select * from Sale
