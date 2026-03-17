/* ============================================================
   COMPLETE SQL SERVER TRAINING SCRIPT (ERROR FREE)
   Database: JAN2026
   ============================================================ */

---------------------------------------------------------------
-- 1️⃣ CREATE DATABASE
---------------------------------------------------------------
IF DB_ID('JAN2026') IS NOT NULL
    DROP DATABASE JAN2026;
GO

CREATE DATABASE JAN2026;
GO

USE JAN2026;
GO

---------------------------------------------------------------
-- 2️⃣ BASIC TABLE (EMPL)
---------------------------------------------------------------
IF OBJECT_ID('EMPL') IS NOT NULL
    DROP TABLE EMPL;

CREATE TABLE EMPL (
    EMPID INT PRIMARY KEY,       -- Primary Key (Unique + Not Null)
    Ename VARCHAR(20),
    Eage INT,
    ESalary MONEY
);

-- Insert Records
INSERT INTO EMPL VALUES 
(1, 'Suresh', 20, 20000),
(2, 'Mahesh', 23, 26000),
(3, 'Sam', 22, 24000),
(4, 'Miren', 32, 56000),
(5, 'Shiv', 28, 26000);

-- Update Example
UPDATE EMPL 
SET ESalary = 17000 
WHERE Ename = 'Suresh';

-- Delete Example
DELETE FROM EMPL WHERE EMPID = 5;

---------------------------------------------------------------
-- 3️⃣ IDENTITY (AUTO INCREMENT)
---------------------------------------------------------------
IF OBJECT_ID('Employees') IS NOT NULL
    DROP TABLE Employees;

CREATE TABLE Employees (
    EID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto Increment
    EName VARCHAR(255),
    EAge INT
);

INSERT INTO Employees (EName, EAge)
VALUES ('Shyam', 23), ('Miren', 24);

---------------------------------------------------------------
-- 4️⃣ MAIN EMPLOYEES TABLE (FOR OPERATIONS)
---------------------------------------------------------------
IF OBJECT_ID('employees') IS NOT NULL
    DROP TABLE employees;

CREATE TABLE employees (
    Eid INT PRIMARY KEY,
    Ename VARCHAR(255),
    Eage INT,
    Edepartment VARCHAR(255),
    Esalary MONEY,
    DOB DATE,
    officialemail VARCHAR(50),
    personalemail VARCHAR(50)
);

INSERT INTO employees VALUES
(1, 'Sahil', 20, 'MERN', 21000, '2004-03-12', 'sahilmern@gmail.com', NULL),
(2, 'Miten', 21, 'ReactJs', 25000, '2001-08-21', NULL, 'miten@gmail.com'),
(3, 'Soham', 24, 'NodeJs', 23000, '2003-10-07', NULL, NULL),
(4, 'Riten', 23, 'QA', 24000, '2002-10-17', 'riten@gmail.com', NULL),
(5, 'Dhruv', 22, 'QA', 26000, '2003-01-15', NULL, NULL);

---------------------------------------------------------------
-- 5️⃣ GROUP BY + HAVING
---------------------------------------------------------------
SELECT Edepartment, AVG(Esalary) AS AvgSalary
FROM employees
GROUP BY Edepartment
HAVING AVG(Esalary) > 20000;

---------------------------------------------------------------
-- 6️⃣ CONSTRAINTS (DEFAULT + CHECK)
---------------------------------------------------------------
IF OBJECT_ID('EMP1') IS NOT NULL
    DROP TABLE EMP1;

CREATE TABLE EMP1 (
    EID INT IDENTITY(101,1) PRIMARY KEY,
    Ename VARCHAR(20),
    Eage INT DEFAULT 18,                 -- Default Constraint
    Salary MONEY CHECK (Salary > 18000)  -- Check Constraint
);

INSERT INTO EMP1 (Ename, Salary)
VALUES ('Suresh', 20000);

---------------------------------------------------------------
-- 7️⃣ PRODUCT TABLE (DEFAULT + NOT NULL)
---------------------------------------------------------------
IF OBJECT_ID('Product') IS NOT NULL
    DROP TABLE Product;

CREATE TABLE Product (
    PID INT PRIMARY KEY,
    Pname VARCHAR(20),
    Quantity INT NOT NULL,
    Status VARCHAR(20) DEFAULT 'Pending'
);

INSERT INTO Product VALUES
(10, 'Laptop', 2, 'Delivered'),
(11, 'Mobile', 1, DEFAULT);

---------------------------------------------------------------
-- 8️⃣ PRIMARY KEY + FOREIGN KEY (CASCADE)
---------------------------------------------------------------
IF OBJECT_ID('Student') IS NOT NULL
    DROP TABLE Student;

IF OBJECT_ID('Courses') IS NOT NULL
    DROP TABLE Courses;

CREATE TABLE Courses (
    cid INT PRIMARY KEY,
    cname VARCHAR(20),
    cfee MONEY
);

CREATE TABLE Student (
    sid INT PRIMARY KEY,
    sname VARCHAR(20),
    cid INT,
    FOREIGN KEY (cid) REFERENCES Courses(cid)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

INSERT INTO Courses VALUES
(10, 'FullStack', 1000),
(20, 'Cloud', 2000),
(30, 'AI', 3000);

INSERT INTO Student VALUES
(1, 'Suresh', 10),
(2, 'Mahesh', 20);

---------------------------------------------------------------
-- 9️⃣ JOINS
---------------------------------------------------------------
SELECT *
FROM Courses C
INNER JOIN Student S
ON C.cid = S.cid;

---------------------------------------------------------------
-- 🔟 VIEW
---------------------------------------------------------------
IF OBJECT_ID('vw_Employeedetails') IS NOT NULL
    DROP VIEW vw_Employeedetails;
GO

CREATE VIEW vw_Employeedetails
AS
SELECT Eid, Ename, Edepartment
FROM employees;
GO

SELECT * FROM vw_Employeedetails;

---------------------------------------------------------------
-- 1️⃣1️⃣ INDEX
---------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_EmpSalary')
    DROP INDEX IX_EmpSalary ON employees;

CREATE NONCLUSTERED INDEX IX_EmpSalary
ON employees (Esalary);

---------------------------------------------------------------
-- 1️⃣2️⃣ FUNCTIONS
---------------------------------------------------------------

-- CAST (Convert datatype)
SELECT Ename, '$' + CAST(Esalary AS VARCHAR) AS SalaryFormatted
FROM employees;

-- COALESCE (First non-null value)
SELECT Eid, COALESCE(officialemail, personalemail, 'No Email') AS Email
FROM employees;

-- DATEDIFF (Age Calculation)
SELECT Ename, DATEDIFF(YEAR, DOB, GETDATE()) AS Age
FROM employees;

-- STRING FUNCTIONS
SELECT 
    UPPER(Ename) AS UpperName,
    LOWER(Ename) AS LowerName,
    LEN(Ename) AS NameLength
FROM employees;

---------------------------------------------------------------
-- SCRIPT END
---------------------------------------------------------------