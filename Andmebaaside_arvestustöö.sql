--11.03.2025 MILAN PETROVSKI TARPV24

CREATE DATABASE AndmebaasMelon3000;
USE AndmebaasMelon3000;

CREATE TABLE students (
    studentID INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(25),
    surname VARCHAR(25),
    birthdate DATE,
    gender VARCHAR(5),
    class VARCHAR(20),
    point INT
);

CREATE TABLE books (
    bookID INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    pagecount INT,
    point INT,
    authorID INT,
    typeID INT,
    FOREIGN KEY (authorID) REFERENCES authors(authorID),
    FOREIGN KEY (typeID) REFERENCES types(typeID)
);

CREATE TABLE authors (
    authorID INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(25),
    surname VARCHAR(25)
);

CREATE TABLE types (
    typeID INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(25)
);

CREATE TABLE borrows (
    borrowID INT PRIMARY KEY IDENTITY(1,1),
    studentID INT,
    bookID INT,
    takenDate DATE,
    broughtDate DATE,
    FOREIGN KEY (studentID) REFERENCES students(studentID),
    FOREIGN KEY (bookID) REFERENCES books(bookID)
);

CREATE TABLE lisaülesannetabel (
    ID INT PRIMARY KEY IDENTITY(1,1),
    õpilane INT,
    tuju VARCHAR(25),
    kellaaeg TIME,
    FOREIGN KEY (õpilane) REFERENCES students(studentID)
);



INSERT INTO authors (name, surname) VALUES 
('J.K.', 'Rowling'),
('George', 'Orwell'),
('Leo', 'Tolstoi');

INSERT INTO types (name) VALUES 
('Fantaasia'),
('Düstoopia'),
('Klassika');

INSERT INTO students (name, surname, birthdate, gender, class, point) VALUES 
('Liis', 'Tamm', '2005-04-12', 'naine', '10A', 85),
('Mati', 'Kask', '2006-07-19', 'mees', '9B', 92),
('Karl', 'Pärn', '2005-11-25', 'mees', '10C', 78);

INSERT INTO books (name, pagecount, point, authorID, typeID) VALUES 
('Harry Potter', 400, 95, 1, 1),
('1984', 328, 90, 2, 2),
('Sõda ja rahu', 1225, 88, 3, 3);
('Sõda tolm', 125, 8, 2, 3);

INSERT INTO borrows (studentID, bookID, takenDate, broughtDate) VALUES 
(1, 1, '2025-03-01', '2025-03-10'),
(2, 2, '2025-03-02', '2025-03-12'),
(3, 3, '2025-03-03', NULL);

INSERT INTO lisaülesannetabel (õpilane, tuju, kellaaeg) VALUES 
(1, 'Rõõmus', '08:30:00'),
(2, 'Väsinud', '10:15:00'),
(3, 'Üllatunud', '13:45:00');


--Näitab ühe autori kõik raamatud
SELECT BOOKS.name as Raamatu_nimi, authors.name as Autori_nimi
FROM BOOKS
INNER JOIN authors ON authors.authorID = BOOKS.authorID
WHERE authors.name = 'George';


--Näitab ühe sugu järgi õpilaste andmed
SELECT name, surname, birthdate, gender, class, point
FROM students
WHERE students.gender = 'mees'


--Näitab nime jargi laenutused
SELECT students.name AS Student_Nimi, students.surname AS Student_Perenimi, books.name AS BookName, borrows.takenDate, borrows.broughtDate
FROM borrows
INNER JOIN students ON borrows.studentID = students.studentID
INNER JOIN books ON borrows.bookID = books.bookID
WHERE students.name = 'Liis';

--Arvutab raamatu keskmine lehekulje arv
SELECT AVG(pagecount) AS Keskmine_Lehekulgede_Arv
FROM books;

--Näitab mitte tagastatud raamatuid
SELECT books.name AS Mitte_tagastatud_raamatu_nimi
FROM books
INNER JOIN borrows ON books.bookID = borrows.bookID
WHERE broughtDate IS NOT NULL

--Näitab õpilsate vanus
SELECT name, surname, 
       DATEDIFF(YEAR, birthdate, GETDATE()) AS Vanus
FROM students;
