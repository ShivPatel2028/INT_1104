/* =========================================
   DATABASE SETUP
========================================= */
CREATE DATABASE JAN2026;
GO

USE JAN2026;
GO

/* =========================================
   BASIC QUERIES
========================================= */
SELECT 4 + 4 AS Addition;
SELECT 'Shiv ' + 'Patel' AS FullName;
SELECT GETDATE() AS CurrentDate;
SELECT SYSTEM_USER AS SystemUser;
GO

/* =========================================
   RENAME DATABASE
========================================= */
ALTER DATABASE JAN2026 MODIFY NAME = January2026;
GO

USE January2026;
GO

/* =========================================
   EMPLOYEE TABLE
========================================= */
CREATE TABLE Employe(
    Eid INT,
    Ename VARCHAR(20),
    Eage INT,
    ESalary MONEY
);
GO

/* --- ADD REQUIRED COLUMNS (FIX FOR ERRORS) --- */
ALTER TABLE Employee ADD Job_Title VARCHAR(20);
ALTER TABLE Employee ADD Birth_Date DATE;
GO

/* =========================================
   VIEW DATA
========================================= */
SELECT * FROM Employee;
GO

/* =========================================
   RENAME TABLE (DEMO)
========================================= */
EXEC sp_rename 'Employee', 'EMP';
EXEC sp_rename 'EMP', 'Employee';
GO

/* =========================================
   RENAME COLUMN
========================================= */
EXEC sp_rename 'Employee.ESalary', 'Esalary', 'COLUMN';
GO

/* =========================================
   SYSTEM CATALOG QUERIES
========================================= */
SELECT name FROM sys.databases;
GO

SELECT name FROM sys.tables;
GO

/* =========================================
   ALTER TABLE OPERATIONS
========================================= */
ALTER TABLE Employee ADD Email VARCHAR(50);
GO

ALTER TABLE Employee DROP COLUMN Email;
GO

ALTER TABLE Employee ALTER COLUMN Eid VARCHAR(10);
GO

ALTER TABLE Employee ALTER COLUMN Eid INT;
GO

/* =========================================
   INSERT DATA
========================================= */
INSERT INTO Employee VALUES
(1, 'Shiv', 20, 20000, 'Developer', '2004-01-10'),
(2, 'Raj', 22, 25000, 'Tester', '2002-06-15'),
(3, 'Jayesh', 23, 40000, 'Manager', '2001-09-25'),
(4, 'Shubham', 45, 23000, 'HR', '1979-03-05');
GO

/* =========================================
   SELECT PRACTICE
========================================= */
SELECT TOP (20) PERCENT * FROM Employee;
GO

SELECT * FROM Employee;
GO

SELECT TOP 0 * FROM Employee;
GO

EXEC sp_help Employee;
GO

/* =========================================
   UPDATE STATEMENTS
========================================= */

-- Method 1
UPDATE Employee
SET Esalary = 30000
WHERE Eid = 1;
GO

-- Method 2
UPDATE Employee
SET Esalary = 40000
WHERE Esalary IS NULL;
GO

-- Method 3 (ALL ROWS – DEMO ONLY)
UPDATE Employee
SET Esalary = 50000;
GO


--Delete Method 1
Delete from Ename
Where Eid = '2'

--Delete Method 2


select * from Employee
delete from Employee 
where ESalary is NULL

-- Delete Method 3
Delete from Employee
drop table employee


truncate table employee
--create a database
--Identity is used only in INT datatype
Create Table Employee
(EID INT,
Ename Varchar (255),
Eage INT)
Insert into Employee values
('suresh',20)
select * from Employee
