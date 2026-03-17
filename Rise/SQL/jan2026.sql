\-- ============================================================
-- COMPLETE SQL SERVER NOTES - FIXED & COMMENTED (SSMS 2022)
-- Covers: DDL, DML, DQL, Operators, Clauses, Constraints,
--         Joins, Subqueries, Views, Indexes, Functions,
--         Stored Procedures, Triggers
-- ============================================================


-- ============================================================
-- SECTION 1: DATABASE BASICS
-- ============================================================

-- Create a new database
CREATE DATABASE JANUARY2026;

-- Switch to / use a specific database
USE JANUARY2026;

-- -----------------------------------------------
-- SQL LANGUAGE TYPES (Theory - for exam)
-- DDL  = Data Definition Language   (CREATE, ALTER, DROP, TRUNCATE)
-- DML  = Data Manipulation Language (INSERT, UPDATE, DELETE)
-- DQL  = Data Query Language        (SELECT)
-- TCL  = Transaction Control Language (COMMIT, ROLLBACK, SAVEPOINT)
-- -----------------------------------------------

-- Basic SELECT examples
SELECT 4 + 4 AS addition;                     -- arithmetic in select
SELECT 'SHIV    ' + 'PATEL' AS fullname;     -- string concat with +
SELECT GETDATE();                              -- current date and time
SELECT SYSTEM_USER;                            -- current logged-in user

-- Rename a database
-- ALTER DATABASE OldName MODIFY NAME = NewName
ALTER DATABASE JANUARY2026 MODIFY NAME = JANUARY2026; -- same name here, just syntax example

-- Drop a database (be careful!)
-- DROP DATABASE JANUARY2026;


-- ============================================================
-- SECTION 2: DDL - CREATE TABLE, ALTER, DROP, TRUNCATE
-- ============================================================

-- Create a basic employee table
-- Syntax: CREATE TABLE tablename (col1 datatype, col2 datatype, ...)
CREATE TABLE employee
(
    EID     INT,
    Ename   VARCHAR(20),
    Eage    INT,
    ESalary MONEY    -- organizations also use DECIMAL(9,2) for salary
);

-- View all data in table (* = all columns)
SELECT * FROM employee;

-- -----------------------------------------------
-- RENAME TABLE
-- sp_rename 'OldTableName', 'NewTableName'
-- -----------------------------------------------
EXEC sp_rename 'employee', 'EMP';           -- rename table employee -> EMP
EXEC sp_rename 'EMP', 'Employee';           -- rename back to Employee

-- -----------------------------------------------
-- RENAME COLUMN
-- sp_rename 'TableName.OldColumnName', 'NewColumnName', 'COLUMN'
-- -----------------------------------------------
EXEC sp_rename 'Employee.EID', 'EMPID', 'COLUMN';   -- rename EID -> EMPID
EXEC sp_rename 'Employee.EMPID', 'EID', 'COLUMN';   -- rename back

-- Show all databases on the server
SELECT name FROM sys.databases;
SELECT name, create_date FROM sys.databases;

-- Show all tables in the current database
SELECT name FROM sys.tables;

-- Drop (delete structure of) a table
DROP TABLE Employee;

-- -----------------------------------------------
-- ALTER TABLE - Add, Remove, Change columns
-- -----------------------------------------------

-- First recreate the table since we dropped it
CREATE TABLE Employee
(
    EID     INT,
    Ename   VARCHAR(20),
    Eage    INT,
    ESalary MONEY
);

-- Add a new column
ALTER TABLE Employee ADD Email VARCHAR(50);

-- Remove a column
ALTER TABLE Employee DROP COLUMN Email;

-- Change datatype of a column
ALTER TABLE Employee ALTER COLUMN EID VARCHAR(10);
ALTER TABLE Employee ALTER COLUMN EID INT;     -- change back to INT

-- Show table structure / schema
EXEC sp_help Employee;

-- Show column names only (top 0 returns no rows but shows column headers)
SELECT TOP 0 * FROM Employee;


-- ============================================================
-- SECTION 3: DML - INSERT, UPDATE, DELETE
-- ============================================================

-- -----------------------------------------------
-- INSERT - 3 METHODS
-- -----------------------------------------------

-- Method 1: Insert without column names (values must match column order exactly)
INSERT INTO Employee VALUES (1, 'venish', 22, 2000000);

-- Method 2: Insert with column names (recommended - order-independent)
INSERT INTO Employee (EID, Ename, Eage, ESalary) VALUES (2, 'vivek', 23, 3000000);

-- Method 3: Insert multiple rows at once
INSERT INTO Employee VALUES
(3, 'ramesh', 25, 1500000),
(4, 'suresh', 30, 1800000);

-- View all data
SELECT * FROM Employee;

-- SELECT TOP N rows
SELECT TOP 2 EID, Ename FROM Employee;

-- SELECT TOP N PERCENT rows
SELECT TOP 50 PERCENT EID, Ename FROM Employee;

-- -----------------------------------------------
-- UPDATE - 3 METHODS
-- -----------------------------------------------

-- Method 1: Update with WHERE condition (update specific row)
UPDATE Employee SET ESalary = 3000 WHERE EID = 1;

-- Method 2: Update NULL values only
UPDATE Employee SET ESalary = 4000 WHERE ESalary IS NULL;

-- Method 3: Update ALL rows (no WHERE = updates entire column - use carefully!)
UPDATE Employee SET ESalary = 500;

SELECT * FROM Employee;

-- -----------------------------------------------
-- DELETE
-- -----------------------------------------------

-- Delete specific row
DELETE FROM Employee WHERE EID = 2;

-- Insert a row with NULL salary to demonstrate NULL delete
INSERT INTO Employee (EID, Ename, Eage) VALUES (2, 'vivek', 32);

-- Delete rows where salary is NULL
DELETE FROM Employee WHERE ESalary IS NULL;

-- Delete ALL rows (keeps table structure, no rollback possible without transaction)
DELETE FROM Employee;

-- TRUNCATE - Also deletes all rows but FASTER, resets identity, no WHERE clause
-- TRUNCATE TABLE Employee;

-- DROP TABLE - Deletes entire table structure + data
-- DROP TABLE Employee;

-- -----------------------------------------------
-- IDENTITY (Auto Increment)
-- -----------------------------------------------
DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee
(
    Eid     INT IDENTITY,   -- starts from 1, increments by 1
    Ename   VARCHAR(20),
    Eage    INT
);

INSERT INTO Employee VALUES ('ramesh', 22);
INSERT INTO Employee VALUES ('suresh', 23);

-- Manually insert a specific identity value (must turn ON first)
SET IDENTITY_INSERT Employee ON;
INSERT INTO Employee (Eid, Ename, Eage) VALUES (4, 'suresh', 23);
SET IDENTITY_INSERT Employee OFF;

INSERT INTO Employee VALUES ('mahesh', 26);  -- will auto-increment from 5

-- Custom identity start and increment: IDENTITY(start, increment)
CREATE TABLE demo
(
    id    INT IDENTITY(100, 2),  -- starts at 100, increments by 2
    dname VARCHAR(10)
);

INSERT INTO demo VALUES ('ram');
INSERT INTO demo VALUES ('shyam');
SELECT * FROM demo;    -- ids will be 100, 102, 104...

DROP TABLE demo;


-- ============================================================
-- SECTION 4: OPERATORS
-- ============================================================

DROP TABLE IF EXISTS Employee;

CREATE TABLE employee
(
    EID        INT,
    Ename      VARCHAR(20),
    Eage       INT,
    Department VARCHAR(20),
    salary     INT
);

INSERT INTO employee VALUES
(1, 'ramesh', 20, 'developer',  60000),
(2, 'Suresh', 30, 'HR',         25000),
(3, 'rakesh', 28, 'QA',         30000),
(4, 'renish', 32, 'Frontend',   35000),
(5, 'jenish', 12, 'Backend',    45000);

SELECT * FROM employee;

-- -----------------------------------------------
-- ARITHMETIC OPERATORS: +, -, *, /
-- -----------------------------------------------
SELECT EID, Ename, salary, (salary + 5000) AS salary_bonus   FROM employee;
SELECT EID, Ename, salary, (salary * 0.05) AS increment_5pct  FROM employee;
SELECT EID, Ename, salary, (salary * 1.05) AS new_salary      FROM employee;

-- -----------------------------------------------
-- LOGICAL OPERATORS: IN, AND, OR, NOT
-- -----------------------------------------------

-- IN: matches any value in the list
SELECT * FROM employee WHERE EID IN (1, 2);
SELECT * FROM employee WHERE Department IN ('HR', 'Frontend');  -- case-insensitive in SQL

-- AND: both conditions must be true
SELECT * FROM employee WHERE Department = 'QA' AND salary = 30000;

-- OR: at least one condition must be true
SELECT * FROM employee WHERE Department = 'QA' OR salary = 20000;

-- Combining AND + OR with brackets
SELECT * FROM employee WHERE (Department = 'QA' AND salary = 30000) OR Department = 'Frontend';
SELECT * FROM employee WHERE Department = 'QA' AND (salary = 30000 OR Eage = 20);

-- -----------------------------------------------
-- COMPARISON OPERATORS: <, <=, >, >=, <> (not equal)
-- -----------------------------------------------
SELECT * FROM employee WHERE Department = 'developer' AND salary > 30000;
SELECT * FROM employee WHERE salary <> 30000;   -- <> means NOT EQUAL

-- Insert a row with NULL salary
INSERT INTO employee (EID, Ename, Eage) VALUES (6, 'kamlesh', 23);

-- IS NULL / IS NOT NULL (use IS, not = for NULL)
SELECT * FROM employee WHERE salary IS NOT NULL;
SELECT * FROM employee WHERE salary IS NULL;

-- BETWEEN: inclusive on both ends (includes 20000 and 30000)
SELECT * FROM employee WHERE salary BETWEEN 20000 AND 30000;

-- Without BETWEEN (does NOT include 30000)
SELECT * FROM employee WHERE salary > 20000 AND salary < 30000;

-- Update all salaries by 5%
UPDATE employee SET salary = salary * 1.05;

-- -----------------------------------------------
-- LIKE OPERATOR: pattern matching
-- % = any number of characters, _ = single character
-- -----------------------------------------------
SELECT * FROM employee WHERE Ename LIKE '%h';        -- ends with h
-- SELECT * FROM employee WHERE Email LIKE '%@gmail.com';    -- email ends with gmail.com
-- SELECT * FROM employee WHERE Phone LIKE '+91%';           -- phone starts with +91


-- ============================================================
-- SECTION 5: SET OPERATORS
-- Rules: same number of columns, same column order,
--        same datatype (size can differ)
-- ============================================================

CREATE TABLE BANK_VADODARA
(
    BID      INT,
    Bname    VARCHAR(20),
    Location VARCHAR(20)
);

INSERT INTO BANK_VADODARA VALUES
(10, 'SBI',   'Akota'),
(20, 'HDFC',  'Manjalpur'),
(10, 'ICICI', 'Atladra');

CREATE TABLE BANK_SURAT
(
    BID      INT,
    Bname    VARCHAR(20),
    Location VARCHAR(20)
);

INSERT INTO BANK_SURAT VALUES
(10, 'SBI',  'Akota'),
(40, 'Axis', 'Varacha'),
(50, 'BOB',  'Udhna');

-- UNION: combines results, REMOVES duplicates
SELECT * FROM BANK_VADODARA
UNION
SELECT * FROM BANK_SURAT;

-- UNION ALL: combines results, KEEPS duplicates
SELECT * FROM BANK_VADODARA
UNION ALL
SELECT * FROM BANK_SURAT;

-- INTERSECT: returns ONLY rows that exist in BOTH tables
SELECT * FROM BANK_VADODARA
INTERSECT
SELECT * FROM BANK_SURAT;

-- EXCEPT: returns rows in FIRST table that are NOT in the second table
SELECT * FROM BANK_VADODARA
EXCEPT
SELECT * FROM BANK_SURAT;

-- Reverse EXCEPT: rows in SURAT not in VADODARA
SELECT * FROM BANK_SURAT
EXCEPT
SELECT * FROM BANK_VADODARA;


-- ============================================================
-- SECTION 6: AGGREGATE FUNCTIONS & GROUP BY & HAVING
-- ============================================================
-- Aggregate Functions:
-- COUNT(*) - counts all rows including NULL
-- COUNT(col) - counts non-NULL values only
-- SUM(col) - only numeric
-- MAX(col) - works on numeric and non-numeric
-- MIN(col) - works on numeric and non-numeric
-- AVG(col) - works on numeric
-- ============================================================

-- Recreate fresh employee table for this section
DROP TABLE IF EXISTS employee;

CREATE TABLE employee
(
    EID        INT,
    Ename      VARCHAR(20),
    Eage       INT,
    Department VARCHAR(20),
    salary     INT
);

INSERT INTO employee VALUES
(1, 'ramesh', 20, 'developer', 60000),
(2, 'Suresh', 30, 'HR',        25000),
(3, 'rakesh', 28, 'QA',        30000),
(4, 'renish', 32, 'Frontend',  35000),
(5, 'jenish', 12, 'Backend',   45000),
(7, 'jayesh', 24, 'QA',        35000);

SELECT * FROM employee;

-- Basic aggregate functions
SELECT COUNT(*) FROM employee;                           -- count all rows

SELECT MAX(salary)                      FROM employee;
SELECT MIN(salary) AS 'minimum salary'  FROM employee;
SELECT AVG(salary)                      FROM employee;
SELECT SUM(salary) AS 'Total Salary'    FROM employee;

-- Multiple aggregates in one query
SELECT
    MAX(salary) AS Highest,
    MIN(salary) AS Lowest,
    AVG(salary) AS 'Average Salary',
    SUM(salary) AS 'Total Salary'
FROM employee;

-- -----------------------------------------------
-- GROUP BY: group rows with same value and apply aggregate
-- -----------------------------------------------
SELECT Department, MAX(salary) AS Highest    FROM employee GROUP BY Department;
SELECT Department, MIN(salary) AS Lowest     FROM employee GROUP BY Department;
SELECT Department, AVG(salary) AS Average    FROM employee GROUP BY Department;
SELECT Department, SUM(salary) AS TotalSal   FROM employee GROUP BY Department;
SELECT Department, COUNT(*)    AS TotalRows  FROM employee GROUP BY Department; -- counts NULL
SELECT Department, COUNT(Department) AS Total FROM employee GROUP BY Department; -- skips NULL

-- -----------------------------------------------
-- HAVING: filters AFTER group by (like WHERE but for groups)
-- WHERE filters rows BEFORE grouping
-- HAVING filters groups AFTER grouping
-- -----------------------------------------------

-- Find departments with max salary > 21000
SELECT Department, MAX(salary) AS Highest
FROM employee
GROUP BY Department
HAVING MAX(salary) > 21000
ORDER BY Department;

-- ORDER BY column position (1 = first col in SELECT, 2 = second col)
SELECT Department, MAX(salary) AS Highest
FROM employee
GROUP BY Department
HAVING MAX(salary) > 21000
ORDER BY 1;          -- order by Department (1st column)

SELECT Department, MAX(salary) AS Highest
FROM employee
GROUP BY Department
HAVING MAX(salary) > 21000
ORDER BY 2 DESC;     -- order by MAX(salary) descending

-- Find top salary per employee name
SELECT Ename, MAX(salary)
FROM employee
GROUP BY Ename
ORDER BY 2 DESC;

-- Get the single highest salary
SELECT TOP 1 salary FROM employee ORDER BY salary DESC;

-- -----------------------------------------------
-- EXAM PRACTICE QUESTIONS (GROUP BY + HAVING)
-- -----------------------------------------------

-- Q1: Find departments with average salary > 20000
SELECT Department, AVG(salary) AS AvgSalary
FROM employee
GROUP BY Department
HAVING AVG(salary) > 20000;

-- Q2: Find departments with more than 1 employee
SELECT Department, COUNT(Department) AS EmpCount
FROM employee
GROUP BY Department
HAVING COUNT(Department) > 1;

-- Q3: Min and max salary per department
SELECT Department, MIN(salary) AS MinSal, MAX(salary) AS MaxSal
FROM employee
GROUP BY Department;

-- Q4: Departments where average age is between 20 and 25
SELECT Department, AVG(Eage) AS AvgAge
FROM employee
GROUP BY Department
HAVING AVG(Eage) BETWEEN 20 AND 25;

-- DISTINCT: removes duplicate rows from result
SELECT DISTINCT Department FROM employee;


-- ============================================================
-- SECTION 7: SQL EXECUTION ORDER (IMPORTANT FOR EXAM)
-- ============================================================
-- SQL Server internally processes queries in this order:
-- 1. FROM       -- which table
-- 2. WHERE      -- filter rows (BEFORE grouping)
-- 3. GROUP BY   -- group the filtered rows
-- 4. HAVING     -- filter groups (AFTER grouping)
-- 5. SELECT     -- choose columns
-- 6. ORDER BY   -- sort the final result
-- ============================================================


-- ============================================================
-- SECTION 8: CONSTRAINTS
-- ============================================================
-- NOT NULL  - column must have a value (duplicates allowed)
-- UNIQUE    - column must have unique values (NULL allowed)
-- CHECK     - column must satisfy a condition
-- DEFAULT   - assigns a default value if none provided
-- PRIMARY KEY = NOT NULL + UNIQUE
-- FOREIGN KEY - links two tables (referential integrity)
-- ============================================================

-- -----------------------------------------------
-- NOT NULL
-- -----------------------------------------------
DROP TABLE IF EXISTS emp1;

CREATE TABLE emp1
(
    eid   INT,
    ename VARCHAR(20),
    eage  INT NOT NULL    -- eage cannot be NULL
);

INSERT INTO emp1 VALUES (1, 'suresh', 20);                 -- allowed
-- INSERT INTO emp1 (eid, ename) VALUES (2, 'ramesh');     -- ERROR: eage is NOT NULL
INSERT INTO emp1 (eid, ename, eage) VALUES (2, 'ramesh', 20); -- allowed (duplicates OK)
SELECT * FROM emp1;

DROP TABLE emp1;

-- -----------------------------------------------
-- UNIQUE
-- -----------------------------------------------
CREATE TABLE emp1
(
    eid   INT UNIQUE,   -- eid must be unique (NULL is allowed once)
    ename VARCHAR(20),
    eage  INT
);

INSERT INTO emp1 VALUES (1, 'suresh', 20);
INSERT INTO emp1 (eid, ename) VALUES (2, 'ramesh');          -- allowed (eage = NULL)
-- INSERT INTO emp1 (eid, ename, eage) VALUES (2, 'ramesh', 20); -- ERROR: eid=2 already exists
INSERT INTO emp1 (ename, eage) VALUES ('ramesh', 20);         -- allowed (eid = NULL)
SELECT * FROM emp1;

DROP TABLE emp1;

-- -----------------------------------------------
-- CHECK
-- -----------------------------------------------
CREATE TABLE emp1
(
    eid    INT,
    ename  VARCHAR(20),
    eage   INT,
    salary MONEY CHECK (salary > 18000)   -- salary must be > 18000
);

INSERT INTO emp1 VALUES (1, 'ramesh', 20, 18001);  -- allowed (18001 > 18000)
-- INSERT INTO emp1 VALUES (2, 'suresh', 22, 17999); -- ERROR: violates CHECK constraint
SELECT * FROM emp1;

DROP TABLE emp1;

-- -----------------------------------------------
-- DEFAULT
-- -----------------------------------------------
CREATE TABLE emp1
(
    eid   INT,
    ename VARCHAR(20),
    eage  INT DEFAULT 18    -- if eage not provided, default is 18
);

INSERT INTO emp1 (eid, ename, eage) VALUES (1, 'ramesh', 20); -- eage = 20
INSERT INTO emp1 (eid, ename) VALUES (2, 'mahesh');            -- eage = 18 (default)
SELECT * FROM emp1;

-- See all tables
SELECT name FROM sys.tables;

-- See table structure
EXEC sp_help 'emp1';

DROP TABLE emp1;

-- -----------------------------------------------
-- ADD CONSTRAINTS WITH ALTER TABLE
-- -----------------------------------------------
CREATE TABLE emp1
(
    eid     INT,
    ename   VARCHAR(20),
    eage    INT
);

INSERT INTO emp1 (eid, ename, eage) VALUES (1, 'ramesh', 20);

ALTER TABLE emp1 ADD Emailid VARCHAR(50);

INSERT INTO emp1 VALUES (2, 'mahesh', 25, 'mahesh@gmail.com');
INSERT INTO emp1 VALUES (3, 'mahesh', 27, 'mahesh@gmail.com'); -- same email currently allowed

-- Add UNIQUE constraint on emailid after table creation
ALTER TABLE emp1 ADD CONSTRAINT UC_email UNIQUE (Emailid);

DELETE FROM emp1 WHERE eid = 3; -- remove duplicate first
INSERT INTO emp1 VALUES (3, 'suresh', 27, 'suresh@gmail.com'); -- now allowed

-- Add CHECK constraint
ALTER TABLE emp1 ADD CONSTRAINT CK_age CHECK (Eage > 18);
-- INSERT INTO emp1 VALUES (4, 'kalesh', 17, 'kalesh@gmail.com'); -- ERROR: age 17 < 18

SELECT * FROM emp1;
DROP TABLE emp1;

-- -----------------------------------------------
-- DEFAULT CONSTRAINT via ALTER
-- -----------------------------------------------
CREATE TABLE product
(
    pid      INT,
    pname    VARCHAR(20),
    quantity INT,
    status   VARCHAR(20)
);

INSERT INTO product VALUES (10, 'laptop', 2, 'delivered'), (11, 'mobile', 23, 'on-the-way');
INSERT INTO product (pid, pname, quantity) VALUES (12, 'charger', 30); -- status = NULL

-- Add default constraint
ALTER TABLE product ADD CONSTRAINT df_status DEFAULT 'Pending' FOR status;

INSERT INTO product (pid, pname, quantity) VALUES (13, 'TV', 30); -- status = 'Pending'
SELECT * FROM product;

-- Drop a constraint
ALTER TABLE product DROP CONSTRAINT df_status;

DROP TABLE product;


-- ============================================================
-- SECTION 9: PRIMARY KEY & FOREIGN KEY
-- ============================================================

-- -----------------------------------------------
-- PRIMARY KEY = UNIQUE + NOT NULL
-- Only ONE primary key per table
-- Auto-sorts data by primary key
-- -----------------------------------------------
DROP TABLE IF EXISTS emp1;

CREATE TABLE emp1
(
    eid   INT PRIMARY KEY,   -- unique + not null + auto-sorted
    ename VARCHAR(20)
);

INSERT INTO emp1 VALUES (2, 'mahesh'), (1, 'suresh'), (3, 'rakesh');
SELECT * FROM emp1;  -- results will be sorted by eid

-- INSERT INTO emp1 VALUES (4, NULL);   -- ERROR: primary key cannot be NULL
-- INSERT INTO emp1 VALUES (1, 'test'); -- ERROR: duplicate primary key

DROP TABLE emp1;

-- -----------------------------------------------
-- FOREIGN KEY - Maintains Referential Integrity
-- Child table column references Parent table PK
-- -----------------------------------------------
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS courses;

CREATE TABLE courses
(
    cid   INT PRIMARY KEY,
    cname VARCHAR(20),
    cfee  MONEY
);

INSERT INTO courses VALUES (10, 'fullstack', 1000), (20, 'cloud', 2000), (30, 'genai', 3000);

CREATE TABLE student
(
    sid   INT,
    sname VARCHAR(20),
    cid   INT FOREIGN KEY REFERENCES courses(cid)  -- FK references courses.cid
);

INSERT INTO student VALUES (101, 'suresh', 10);   -- allowed (cid 10 exists)
INSERT INTO student VALUES (102, 'mahesh', 20);   -- allowed (cid 20 exists)
-- INSERT INTO student VALUES (103, 'ramesh', 40); -- ERROR: cid 40 not in courses

-- Can insert in courses first, then student
INSERT INTO courses VALUES (40, 'QA', 4000);
INSERT INTO student VALUES (103, 'ramesh', 40);  -- now allowed

-- Cannot UPDATE parent if child references it
-- UPDATE courses SET cid = 50 WHERE cname = 'QA'; -- ERROR

-- Can update non-FK columns freely
UPDATE courses SET cname = 'Testing' WHERE cid = 40;

-- Cannot DELETE from parent if child references it
-- DELETE FROM courses WHERE cid = 10; -- ERROR

DELETE FROM student WHERE sid = 101; -- delete child first
DELETE FROM courses WHERE cid = 10;  -- now can delete parent

-- Cannot DROP parent table while child exists
-- DROP TABLE courses; -- ERROR

DROP TABLE student;
DROP TABLE courses;  -- now works

-- -----------------------------------------------
-- CASCADE: Automatically update/delete child when parent changes
-- ON UPDATE CASCADE - child updates automatically
-- ON DELETE CASCADE - child deletes automatically
-- -----------------------------------------------
CREATE TABLE courses
(
    cid   INT PRIMARY KEY,
    cname VARCHAR(20),
    cfee  MONEY
);

INSERT INTO courses VALUES (10, 'fullstack', 1000), (20, 'cloud', 2000), (30, 'genai', 3000);

CREATE TABLE student
(
    sid   INT,
    sname VARCHAR(20),
    cid   INT FOREIGN KEY REFERENCES courses(cid)
              ON UPDATE CASCADE    -- if parent cid changes, child cid auto-updates
              ON DELETE CASCADE    -- if parent row deleted, child row auto-deleted
);

INSERT INTO student VALUES (1, 'suresh', 10), (2, 'mahesh', 20), (3, 'rakesh', 30);

-- Update parent - child updates automatically
UPDATE courses SET cid = 40 WHERE cname = 'genai';
SELECT * FROM student; -- cid for rakesh is now 40

-- Delete parent - child row also deleted
DELETE FROM courses WHERE cid = 40;
SELECT * FROM student; -- rakesh row is gone

DROP TABLE student;
DROP TABLE courses;

-- -----------------------------------------------
-- COMPOSITE PRIMARY KEY (multiple columns as PK)
-- -----------------------------------------------
CREATE TABLE courses1
(
    cid   INT,
    sid   INT,
    cname VARCHAR(20),
    PRIMARY KEY (cid, sid)   -- combination of cid+sid must be unique
);

CREATE TABLE student1
(
    cid   INT,
    sid   INT,
    sname VARCHAR(20),
    FOREIGN KEY (cid, sid) REFERENCES courses1(cid, sid)
);

INSERT INTO courses1 VALUES (1, 1, 'rakesh'), (1, 2, 'jayesh');
SELECT * FROM courses1;

-- INSERT INTO student1 VALUES (1, 3, 'QA'); -- ERROR: (1,3) not in courses1
INSERT INTO student1 VALUES (1, 1, 'QA');    -- allowed
SELECT * FROM student1;

DROP TABLE student1;
DROP TABLE courses1;


-- ============================================================
-- SECTION 10: SUBQUERIES (Nested Queries)
-- ============================================================
-- Subquery = outer query + inner query
-- Inner query runs first, passes result to outer query
-- Non-correlated: inner query runs once, independently
-- Correlated: inner query runs for each row of outer query
-- ============================================================

DROP TABLE IF EXISTS employee;

CREATE TABLE employee
(
    EID        INT,
    Ename      VARCHAR(20),
    Eage       INT,
    Department VARCHAR(20),
    salary     INT
);

INSERT INTO employee VALUES
(1, 'ramesh', 20, 'developer', 60000),
(2, 'Suresh', 30, 'HR',        25000),
(3, 'rakesh', 28, 'QA',        30000),
(4, 'renish', 32, 'Frontend',  35000),
(5, 'jenish', 12, 'Backend',   45000),
(6, 'jayesh', 24, 'QA',        35000);

-- Q1: Find employee with the highest salary
SELECT * FROM employee
WHERE salary = (SELECT MAX(salary) FROM employee);  -- non-correlated

-- Alternative using TOP
SELECT TOP 1 EID, Ename, salary FROM employee ORDER BY salary DESC;

-- Q2: Find 2nd highest salary
SELECT * FROM employee
WHERE salary = (
    SELECT MAX(salary) FROM employee
    WHERE salary < (SELECT MAX(salary) FROM employee)
);

-- Q3: Find employees earning more than average salary
SELECT Ename, salary FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee);

-- Q4: Find departments that have at least one employee older than 28
SELECT DISTINCT Department FROM employee
WHERE Department IN
(
    SELECT Department FROM employee WHERE Eage > 28
);

-- Q5: Find employees who earn the max salary in their department
SELECT Ename, Department, salary FROM employee
WHERE salary IN
(
    SELECT MAX(salary) FROM employee GROUP BY Department
);


-- ============================================================
-- SECTION 11: COPY TABLE (SELECT INTO)
-- ============================================================

-- Copy all columns and data to a new table (same database)
SELECT * INTO emp_backup FROM employee;

-- Copy specific columns only
SELECT EID, Ename INTO emp_names FROM employee;

SELECT * FROM emp_names;

DROP TABLE emp_backup;
DROP TABLE emp_names;


-- ============================================================
-- SECTION 12: JOINS
-- ============================================================
-- Join = combining 2+ tables using a common column
-- At least one matching column between tables
-- Datatypes of join columns must match
-- ANSI joins use ON keyword
-- Non-ANSI joins use WHERE keyword
-- ============================================================

DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS Course;

CREATE TABLE Course
(
    CID   INT,
    Cname VARCHAR(255),
    Cfee  MONEY
);

INSERT INTO Course VALUES
(10, 'Full Stack', 1000),
(20, 'QA',        1000),
(30, 'Cloud',     2000),
(40, 'AI',        3000);

CREATE TABLE student
(
    sid   INT,
    sname VARCHAR(20),
    cid   INT
);

INSERT INTO student VALUES
(1, 'Suresh', 10),
(2, 'Mahesh', 20),
(3, 'Jayesh', 50);    -- cid=50 does NOT exist in Course

-- -----------------------------------------------
-- INNER JOIN: returns only MATCHING rows from both tables
-- -----------------------------------------------
SELECT * FROM Course
INNER JOIN student ON Course.CID = student.cid;
-- Result: Only Suresh and Mahesh (Jayesh has cid=50, no match; cid=30,40 no student)

-- -----------------------------------------------
-- LEFT JOIN (LEFT OUTER JOIN):
-- Returns all rows from LEFT table + matching from RIGHT
-- Non-matching right side = NULL
-- -----------------------------------------------
SELECT * FROM Course
LEFT JOIN student ON Course.CID = student.cid;
-- All courses shown; Jayesh row not shown; Cloud & AI show NULL for student

-- -----------------------------------------------
-- RIGHT JOIN (RIGHT OUTER JOIN):
-- Returns all rows from RIGHT table + matching from LEFT
-- -----------------------------------------------
SELECT * FROM Course
RIGHT JOIN student ON Course.CID = student.cid;
-- All students shown; Jayesh(cid=50) shows NULL for Course

-- -----------------------------------------------
-- LEFT EXCLUDING JOIN: Only LEFT rows with NO match in RIGHT
-- -----------------------------------------------
SELECT * FROM Course
LEFT JOIN student ON Course.CID = student.cid
WHERE student.cid IS NULL;

-- -----------------------------------------------
-- RIGHT EXCLUDING JOIN: Only RIGHT rows with NO match in LEFT
-- -----------------------------------------------
SELECT * FROM Course
RIGHT JOIN student ON Course.CID = student.cid
WHERE Course.CID IS NULL;

-- -----------------------------------------------
-- FULL OUTER JOIN: Inner + Left + Right (ALL rows from both)
-- -----------------------------------------------
SELECT * FROM Course
FULL OUTER JOIN student ON Course.CID = student.cid;

-- -----------------------------------------------
-- FULL OUTER EXCLUDING: Only non-matching rows from BOTH sides
-- -----------------------------------------------
SELECT * FROM Course
FULL OUTER JOIN student ON Course.CID = student.cid
WHERE Course.CID IS NULL OR student.cid IS NULL;

-- -----------------------------------------------
-- CROSS JOIN (Cartesian Join):
-- Every row from table A combined with every row from table B
-- Result = rows of A * rows of B
-- -----------------------------------------------
SELECT * FROM Course CROSS JOIN student;
SELECT * FROM Course, student;   -- older non-ANSI syntax (same result)

-- -----------------------------------------------
-- Non-ANSI JOINS (using WHERE)
-- Equi Join: uses = operator
-- Non-Equi Join: uses <, >, <=, >=, <>
-- -----------------------------------------------
SELECT * FROM Course, student WHERE Course.CID  = student.cid;  -- Equi
SELECT * FROM Course, student WHERE Course.CID <> student.cid;  -- Non-Equi

-- -----------------------------------------------
-- SELF JOIN: joining a table with itself
-- Useful to compare rows within same table
-- Aliasing is MANDATORY
-- -----------------------------------------------
-- Example: Find all employees who share the same department
SELECT e1.Ename AS Emp1, e2.Ename AS Emp2, e1.Department
FROM employee e1
JOIN employee e2 ON e1.Department = e2.Department
WHERE e1.EID <> e2.EID;   -- exclude same person comparing with themselves


-- ============================================================
-- SECTION 13: VIEWS (Virtual Tables)
-- ============================================================
-- View = stored SELECT query that acts like a table
-- Does NOT store data physically
-- When you query a view, it runs the underlying SELECT
-- ============================================================

DROP TABLE IF EXISTS emp7;
DROP TABLE IF EXISTS dep7;

CREATE TABLE emp7
(
    eid   INT,
    ename VARCHAR(10),
    did   INT
);

CREATE TABLE dep7
(
    did   INT,
    dname VARCHAR(10)
);

INSERT INTO emp7 VALUES (1, 'suresh', 10), (2, 'jayesh', 10), (3, 'mahesh', 30);
INSERT INTO dep7 VALUES (10, 'IT'), (20, 'Cloud'), (30, 'AI');

-- -----------------------------------------------
-- CREATE VIEW
-- -----------------------------------------------
CREATE VIEW vw_emp7dep7
AS
    SELECT e.eid, e.ename, d.dname
    FROM emp7 e
    JOIN dep7 d ON e.did = d.did;

SELECT * FROM vw_emp7dep7;

-- -----------------------------------------------
-- UPDATE through a View (single-table views only)
-- -----------------------------------------------
-- Views on single table CAN be updated
-- Views using JOINs usually CANNOT update both tables at once
UPDATE emp7 SET ename = 'SURESH_UPDATED' WHERE eid = 1;
SELECT * FROM vw_emp7dep7;  -- view reflects the change

-- -----------------------------------------------
-- ALTER VIEW (modify view definition)
-- -----------------------------------------------
ALTER VIEW vw_emp7dep7
AS
    SELECT e.eid, e.ename, d.dname, d.did
    FROM emp7 e
    JOIN dep7 d ON e.did = d.did;

-- -----------------------------------------------
-- DROP VIEW
-- -----------------------------------------------
DROP VIEW vw_emp7dep7;

-- -----------------------------------------------
-- CREATE VIEW WITH SCHEMABINDING
-- Prevents changes to the underlying base table columns used in view
-- -----------------------------------------------
CREATE TABLE test_table
(
    tid   INT,
    tname VARCHAR(20),
    city  VARCHAR(20)
);

INSERT INTO test_table VALUES (1, 'qa', 'vadodara'), (2, 'cloud', 'anand'), (3, 'ai', 'ahmedabad');

GO
CREATE VIEW vw_testdetails
WITH SCHEMABINDING     -- protects base table structure
AS
    SELECT tid, tname
    FROM dbo.test_table;
GO

-- ALTER TABLE test_table DROP COLUMN tid; -- ERROR: column used in view with schemabinding

-- -----------------------------------------------
-- VIEW WITH ENCRYPTION
-- Hides the view's definition from others
-- -----------------------------------------------
GO
CREATE OR ALTER VIEW vw_testdetails
WITH ENCRYPTION     -- hides SELECT code from sp_helptext
AS
    SELECT tid, tname
    FROM dbo.test_table;
GO

EXEC sp_helptext 'vw_testdetails';  -- will show "text is encrypted"
EXEC sp_help     'vw_testdetails';  -- shows column info (not encrypted)

-- List all views with dates
SELECT name, create_date, modify_date FROM sys.views;

DROP VIEW  IF EXISTS vw_testdetails;
DROP TABLE IF EXISTS test_table;
DROP TABLE IF EXISTS emp7;
DROP TABLE IF EXISTS dep7;


-- ============================================================
-- SECTION 14: INDEXES
-- ============================================================
-- Index = speeds up data search (like a book index)
-- Clustered  Index: Only 1 per table. Physically sorts table data.
--                  Created automatically with PRIMARY KEY.
-- Non-Clustered: Multiple per table. Separate structure with pointers.
-- Unique Index: Ensures uniqueness (faster than UNIQUE constraint)
-- Composite Index: Index on multiple columns
-- Filtered Index: Index with a WHERE condition
-- ============================================================

DROP TABLE IF EXISTS employee;

CREATE TABLE employee
(
    EID        INT PRIMARY KEY,   -- creates clustered index automatically
    Ename      VARCHAR(20),
    Eage       INT,
    Department VARCHAR(20),
    salary     INT
);

INSERT INTO employee VALUES
(1, 'ramesh', 20, 'developer', 60000),
(2, 'Suresh', 30, 'HR',        25000),
(3, 'rakesh', 28, 'QA',        30000),
(4, 'renish', 32, 'Frontend',  35000),
(5, 'jenish', 12, 'Backend',   45000);

-- -----------------------------------------------
-- CREATE NON-CLUSTERED INDEX
-- -----------------------------------------------
CREATE INDEX ix_empName
ON employee(Ename ASC);

SELECT * FROM employee;

-- Drop an index
DROP INDEX employee.ix_empName;

-- -----------------------------------------------
-- COMPOSITE INDEX (index on multiple columns)
-- -----------------------------------------------
CREATE INDEX ix_empNameDept
ON employee(Ename ASC, Department DESC);

DROP INDEX employee.ix_empNameDept;

-- -----------------------------------------------
-- UNIQUE INDEX (ensures no duplicate values)
-- -----------------------------------------------
CREATE UNIQUE INDEX ix_EID
ON employee(EID);

-- INSERT INTO employee VALUES (1, 'test', 10, 'IT', 50000); -- ERROR: duplicate EID=1
DROP INDEX employee.ix_EID;

-- -----------------------------------------------
-- FILTERED INDEX (index only on rows matching condition)
-- Useful for sparse columns (e.g., nullable columns)
-- -----------------------------------------------
ALTER TABLE employee ADD TerminationDate DATE NULL;

CREATE NONCLUSTERED INDEX ix_empTermination
ON employee(TerminationDate)
WHERE TerminationDate IS NOT NULL;  -- only indexes employees who have left

-- View all indexes on a table
EXEC sp_helpindex 'employee';

DROP TABLE employee;


-- ============================================================
-- SECTION 15: BUILT-IN FUNCTIONS
-- ============================================================

DROP TABLE IF EXISTS employee;

CREATE TABLE employee
(
    EID        INT,
    Ename      VARCHAR(20),
    Eage       INT,
    Department VARCHAR(20),
    salary     INT,
    DOJ        DATE             -- Date of Joining
);

INSERT INTO employee VALUES
(1, 'ramesh', 20, 'developer', 60000, '2020-01-15'),
(2, 'Suresh', 30, 'HR',        25000, '2018-06-01'),
(3, 'rakesh', 28, 'QA',        30000, '2022-03-10');

-- -----------------------------------------------
-- CAST: convert datatype
-- -----------------------------------------------
SELECT Ename, '$' + CAST(salary AS VARCHAR(10)) AS FormattedSalary
FROM employee;

-- -----------------------------------------------
-- DATEDIFF: difference between two dates
-- Syntax: DATEDIFF(datepart, startdate, enddate)
-- -----------------------------------------------

-- How many years each employee has worked (from DOJ to today)
SELECT Ename, DOJ,
       DATEDIFF(YEAR,  DOJ, GETDATE()) AS YearsWorked,
       DATEDIFF(MONTH, DOJ, GETDATE()) AS MonthsWorked
FROM employee;

-- Calculate employee age from birthdate (if you had DOB column)
-- SELECT Ename, DATEDIFF(YEAR, DOB, GETDATE()) AS Age FROM employee;

-- -----------------------------------------------
-- REPLACE: replace part of a string
-- Syntax: REPLACE(string, find, replace_with)
-- -----------------------------------------------
SELECT REPLACE('suresh  patel', '  ', ' ');            -- fix double space
-- SELECT REPLACE(phone, '+91', '0') FROM employee;    -- real-life: format phone

-- -----------------------------------------------
-- TRIM / LTRIM / RTRIM: remove spaces
-- -----------------------------------------------
SELECT TRIM('   ram lakhan   ');         -- removes both sides
SELECT LTRIM('   ram lakhan   ');        -- removes left side only
SELECT RTRIM('   ram lakhan   ');        -- removes right side only
SELECT TRIM(Ename) FROM employee;        -- on column

-- -----------------------------------------------
-- LEN: length of string
-- -----------------------------------------------
SELECT Ename, LEN(Ename) AS NameLength FROM employee;

-- -----------------------------------------------
-- UPPER / LOWER
-- -----------------------------------------------
SELECT UPPER(Ename) FROM employee;
SELECT LOWER(Ename) FROM employee;
SELECT LOWER('HELLO WORLD');

-- -----------------------------------------------
-- CONCAT: joins strings, ignores NULL (unlike +)
-- -----------------------------------------------
SELECT 'abc' + ' ' + 'def';                -- using + (NULL makes whole result NULL)
SELECT 'abc' + ' ' + NULL;                 -- result = NULL
SELECT CONCAT('abc', NULL, 'def');         -- result = 'abcdef' (NULL ignored)
SELECT CONCAT(Ename, ' - ', Department) AS EmpInfo FROM employee;

-- -----------------------------------------------
-- COALESCE: returns first non-NULL value in list
-- -----------------------------------------------
-- Example: show first available email or a default message
SELECT EID, Ename,
       COALESCE(NULL, NULL, 'No email found') AS ContactEmail
FROM employee;


-- ============================================================
-- SECTION 16: STORED PROCEDURES
-- ============================================================
-- Stored Procedure = precompiled SQL code saved in the database
-- Benefits: reusable, faster (precompiled), secure
-- Syntax: CREATE PROCEDURE name AS BEGIN ... END
-- Run: EXEC procname  OR  procname  OR  EXECUTE procname
-- ============================================================

DROP TABLE IF EXISTS employee;

CREATE TABLE employee
(
    EID        INT,
    Ename      VARCHAR(30),
    Eage       INT,
    Department VARCHAR(20),
    Esalary    INT
);

INSERT INTO employee VALUES
(101, 'Rahul Sharma',  28, 'IT',         65000),
(102, 'Priya Patel',   32, 'HR',         55000),
(103, 'Amit Singh',    45, 'Finance',    95000),
(104, 'Sneha Iyer',    26, 'Marketing',  48000),
(105, 'Vikram Reddy',  38, 'Sales',      72000),
(106, 'Neha Gupta',    29, 'IT',         68000),
(107, 'Karan Desai',   31, 'Operations', 60000),
(108, 'Anjali Verma',  27, 'Design',     52000),
(109, 'Rohan Das',     41, 'IT',         88000),
(110, 'Meera Nair',    35, 'Finance',    82000);

-- -----------------------------------------------
-- Basic Stored Procedure (no parameters)
-- -----------------------------------------------
CREATE PROCEDURE spGetEmpSalary
AS
BEGIN
    SELECT EID, Department, Esalary FROM employee;
END;

-- 3 ways to execute a stored procedure
EXEC    spGetEmpSalary;
EXECUTE spGetEmpSalary;
spGetEmpSalary;

-- -----------------------------------------------
-- ALTER (modify) Stored Procedure
-- -----------------------------------------------
ALTER PROCEDURE spGetEmpSalary
AS
BEGIN
    SELECT EID, Ename, Department, Esalary FROM employee;
END;

-- View SP definition
EXEC sp_helptext 'spGetEmpSalary';

-- -----------------------------------------------
-- ENCRYPTION (hides SP code from sp_helptext)
-- -----------------------------------------------
ALTER PROCEDURE spGetEmpSalary
WITH ENCRYPTION
AS
BEGIN
    SELECT EID, Ename, Department, Esalary FROM employee;
END;

EXEC sp_helptext 'spGetEmpSalary'; -- shows "text is encrypted"

-- Remove encryption by re-altering without it
ALTER PROCEDURE spGetEmpSalary
AS
BEGIN
    SELECT EID, Ename, Department, Esalary FROM employee;
END;

-- Drop stored procedure
-- DROP PROCEDURE spGetEmpSalary;

-- -----------------------------------------------
-- Stored Procedure WITH INPUT PARAMETER
-- -----------------------------------------------
CREATE OR ALTER PROCEDURE spGetEmpByID
    @ID INT       -- input parameter
AS
BEGIN
    SELECT * FROM employee WHERE EID = @ID;
END;

-- Execute with parameter
EXEC spGetEmpByID @ID = 101;
EXEC spGetEmpByID 103;          -- positional (no name needed)

-- -----------------------------------------------
-- Stored Procedure with MULTIPLE INPUT PARAMETERS
-- -----------------------------------------------
CREATE OR ALTER PROCEDURE spGetEmpByDept
    @Department VARCHAR(50)
AS
BEGIN
    SELECT EID, Ename, Department, Esalary
    FROM employee
    WHERE Department = @Department;
END;

EXEC spGetEmpByDept 'IT';
EXEC spGetEmpByDept 'Finance';

-- -----------------------------------------------
-- Stored Procedure with OUTPUT PARAMETER
-- Returns a value back to caller
-- -----------------------------------------------
CREATE OR ALTER PROCEDURE spGetMaxSalaryByDept
    @Department VARCHAR(50),
    @MaxSal     INT OUTPUT        -- OUTPUT keyword marks this as output param
AS
BEGIN
    SELECT @MaxSal = MAX(Esalary)
    FROM employee
    WHERE Department = @Department;
END;

-- Execute with output parameter
DECLARE @highest INT;
EXECUTE spGetMaxSalaryByDept 'IT', @highest OUTPUT;
PRINT 'Highest IT salary: ' + CAST(@highest AS VARCHAR);

-- -----------------------------------------------
-- Stored Procedure: Product Price Change (+/- %)
-- -----------------------------------------------
DROP TABLE IF EXISTS product;

CREATE TABLE product
(
    pid         INT,
    productname VARCHAR(30),
    price       DECIMAL(10, 2)
);

INSERT INTO product VALUES (1, 'Mobile', 20000), (2, 'Laptop', 55000), (3, 'Tablet', 30000);

CREATE OR ALTER PROCEDURE spProductPriceChange
    @productname     VARCHAR(30),
    @percentage      DECIMAL(5, 2)    -- e.g. 0.10 = 10% increase, -0.10 = 10% decrease
AS
BEGIN
    UPDATE product
    SET price = price + (price * @percentage)
    WHERE productname = @productname;

    SELECT * FROM product WHERE productname = @productname;  -- show updated result
END;

EXEC spProductPriceChange 'Mobile', 0.10;   -- increase by 10%
EXEC spProductPriceChange 'Laptop', -0.05;  -- decrease by 5%
SELECT * FROM product;


-- ============================================================
-- SECTION 17: TRIGGERS - COMPLETE GUIDE
-- ============================================================
-- WHAT IS A TRIGGER?
--   A trigger is a special stored procedure that automatically
--   runs (fires) when a DML event (INSERT/UPDATE/DELETE) happens
--   on a table. You do NOT manually call a trigger - it fires
--   on its own.
--
-- TYPES OF TRIGGERS:
--   1. AFTER Trigger  (also called FOR Trigger)
--      - Fires AFTER the DML statement completes
--      - Used for: audit logs, validation, cascading changes
--
--   2. INSTEAD OF Trigger
--      - Fires INSTEAD of the DML (replaces the actual DML)
--      - Used for: views that cannot be updated directly
--
-- SPECIAL VIRTUAL TABLES (available ONLY inside triggers):
--   inserted  - holds the NEW rows (used in INSERT and UPDATE)
--   deleted   - holds the OLD rows (used in DELETE and UPDATE)
--
--   For UPDATE: inserted = new values, deleted = old values
--   For INSERT: only inserted is populated
--   For DELETE: only deleted is populated
--
-- SYNTAX:
--   CREATE TRIGGER trigger_name
--   ON table_name
--   AFTER INSERT / AFTER UPDATE / AFTER DELETE / INSTEAD OF INSERT ...
--   AS
--   BEGIN
--       -- your SQL code here
--   END
-- ============================================================


-- ============================================================
-- TRIGGER EXAMPLE 1: BASIC AFTER INSERT TRIGGER
-- Scenario: Log every new employee added to tblEmployee
-- ============================================================

DROP TABLE IF EXISTS tblEmployeeAudit;
DROP TABLE IF EXISTS tblEmployee;

-- Main employee table
CREATE TABLE tblEmployee
(
    Id           INT PRIMARY KEY,
    Name         NVARCHAR(30),
    Salary       INT,
    Gender       NVARCHAR(10),
    DepartmentId INT
);

-- Audit table: stores a message every time something changes
CREATE TABLE tblEmployeeAudit
(
    AuditID   INT IDENTITY(1, 1) PRIMARY KEY,
    Message   NVARCHAR(500),
    AuditDate DATETIME DEFAULT GETDATE()
);

-- -----------------------------------------------
-- AFTER INSERT TRIGGER
-- 'inserted' table contains the newly inserted row(s)
-- -----------------------------------------------
GO
CREATE OR ALTER TRIGGER tr_tblEmployee_AfterInsert
ON tblEmployee
AFTER INSERT           -- fires after INSERT completes
AS
BEGIN
    SET NOCOUNT ON;    -- hides "1 row(s) affected" message

    DECLARE @Id INT;
    SELECT @Id = Id FROM inserted;   -- read the new row's Id

    -- Log the action into the audit table
    INSERT INTO tblEmployeeAudit (Message)
    VALUES (
        'New employee with Id = ' + CAST(@Id AS NVARCHAR(5)) +
        ' was added at ' + CAST(GETDATE() AS NVARCHAR(30))
    );
END;
GO

-- Test the INSERT trigger
INSERT INTO tblEmployee VALUES (1, 'John', 5000,  'Male',   3);
INSERT INTO tblEmployee VALUES (2, 'Mike', 3400,  'Male',   2);
INSERT INTO tblEmployee VALUES (3, 'Pam',  6000,  'Female', 1);

-- Check the audit log - should have 3 entries
SELECT * FROM tblEmployeeAudit;
SELECT * FROM tblEmployee;


-- ============================================================
-- TRIGGER EXAMPLE 2: AFTER UPDATE TRIGGER
-- Scenario: Log which employee was updated, old and new salary
-- ============================================================
GO
CREATE OR ALTER TRIGGER tr_tblEmployee_AfterUpdate
ON tblEmployee
AFTER UPDATE           -- fires after UPDATE completes
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Id        INT;
    DECLARE @OldSalary INT;
    DECLARE @NewSalary INT;

    -- 'deleted' holds the OLD values (before update)
    -- 'inserted' holds the NEW values (after update)
    SELECT @Id        = Id     FROM inserted;
    SELECT @OldSalary = Salary FROM deleted;   -- old salary
    SELECT @NewSalary = Salary FROM inserted;  -- new salary

    INSERT INTO tblEmployeeAudit (Message)
    VALUES (
        'Employee Id = ' + CAST(@Id AS NVARCHAR(5)) +
        ' salary changed from ' + CAST(@OldSalary AS NVARCHAR(10)) +
        ' to ' + CAST(@NewSalary AS NVARCHAR(10)) +
        ' at ' + CAST(GETDATE() AS NVARCHAR(30))
    );
END;
GO

-- Test the UPDATE trigger
UPDATE tblEmployee SET Salary = 7000 WHERE Id = 1;
UPDATE tblEmployee SET Salary = 8000 WHERE Id = 3;

-- Check audit log - should show old vs new salary
SELECT * FROM tblEmployeeAudit;


-- ============================================================
-- TRIGGER EXAMPLE 3: AFTER DELETE TRIGGER
-- Scenario: Log which employee was deleted
-- NOTE: On DELETE - only 'deleted' table is available,
--       'inserted' table is EMPTY
-- ============================================================
GO
CREATE OR ALTER TRIGGER tr_tblEmployee_AfterDelete
ON tblEmployee
AFTER DELETE           -- fires after DELETE completes
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Id   INT;
    DECLARE @Name NVARCHAR(30);

    -- Read from 'deleted' - this holds the removed row(s)
    SELECT @Id = Id, @Name = Name FROM deleted;

    INSERT INTO tblEmployeeAudit (Message)
    VALUES (
        'Employee Id = ' + CAST(@Id AS NVARCHAR(5)) +
        ' Name = ' + @Name +
        ' was DELETED at ' + CAST(GETDATE() AS NVARCHAR(30))
    );
END;
GO

-- Test the DELETE trigger
DELETE FROM tblEmployee WHERE Id = 2;

-- Check audit log
SELECT * FROM tblEmployeeAudit;
SELECT * FROM tblEmployee;


-- ============================================================
-- TRIGGER EXAMPLE 4: PREVENT DELETE (Business Rule Trigger)
-- Scenario: Do NOT allow deleting an employee with salary > 5000
-- If someone tries, ROLLBACK and show an error message
-- ============================================================
GO
CREATE OR ALTER TRIGGER tr_tblEmployee_PreventHighSalaryDelete
ON tblEmployee
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if any deleted employee had salary > 5000
    IF EXISTS (SELECT 1 FROM deleted WHERE Salary > 5000)
    BEGIN
        -- ROLLBACK cancels the DELETE that fired this trigger
        ROLLBACK TRANSACTION;
        PRINT 'ERROR: Cannot delete employee with salary above 5000!';
    END
    ELSE
    BEGIN
        -- Log the deletion if it was allowed
        INSERT INTO tblEmployeeAudit (Message)
        SELECT 'Employee ' + Name + ' (Id=' + CAST(Id AS NVARCHAR(5)) + ') deleted at ' + CAST(GETDATE() AS NVARCHAR(30))
        FROM deleted;
    END
END;
GO

-- Test: Try deleting Pam (salary 8000 after update) - should FAIL
DELETE FROM tblEmployee WHERE Id = 3;   -- BLOCKED (salary 8000 > 5000)

-- Check she is still there
SELECT * FROM tblEmployee;

-- Drop this trigger before continuing so we can clean up properly
DROP TRIGGER tr_tblEmployee_PreventHighSalaryDelete;


-- ============================================================
-- TRIGGER EXAMPLE 5: INSTEAD OF TRIGGER ON A VIEW
-- Scenario: A view joins two tables. Normally you CANNOT
--           INSERT into such a view. INSTEAD OF trigger
--           intercepts the INSERT and redirects it.
-- ============================================================

DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP VIEW  IF EXISTS vw_OrderSummary;

CREATE TABLE Orders
(
    OrderID    INT PRIMARY KEY,
    CustomerID INT,
    OrderDate  DATE DEFAULT GETDATE()
);

CREATE TABLE OrderItems
(
    ItemID    INT IDENTITY(1,1) PRIMARY KEY,
    OrderID   INT FOREIGN KEY REFERENCES Orders(OrderID),
    Product   VARCHAR(50),
    Qty       INT,
    Price     DECIMAL(10,2)
);

INSERT INTO Orders VALUES (101, 1, '2026-01-01'), (102, 2, '2026-01-05');
INSERT INTO OrderItems (OrderID, Product, Qty, Price) VALUES
(101, 'Laptop',  1, 55000.00),
(101, 'Mouse',   2,   500.00),
(102, 'Monitor', 1, 12000.00);

-- Create a view that joins Orders + OrderItems
GO
CREATE OR ALTER VIEW vw_OrderSummary
AS
    SELECT
        o.OrderID,
        o.CustomerID,
        oi.Product,
        oi.Qty,
        oi.Price
    FROM Orders o
    JOIN OrderItems oi ON o.OrderID = oi.OrderID;
GO

SELECT * FROM vw_OrderSummary;

-- Without INSTEAD OF trigger, INSERT into view would FAIL
-- INSERT INTO vw_OrderSummary VALUES (103, 3, 'Keyboard', 1, 1500); -- ERROR

-- Create INSTEAD OF INSERT trigger on the view
GO
CREATE OR ALTER TRIGGER trg_vw_OrderSummary_InsteadOfInsert
ON vw_OrderSummary
INSTEAD OF INSERT       -- intercepts INSERT before it happens
AS
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Insert the new order into Orders table first
    INSERT INTO Orders (OrderID, CustomerID)
    SELECT OrderID, CustomerID FROM inserted
    WHERE NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = inserted.OrderID);

    -- Step 2: Insert the item into OrderItems table
    INSERT INTO OrderItems (OrderID, Product, Qty, Price)
    SELECT OrderID, Product, Qty, Price FROM inserted;

    PRINT 'Order inserted successfully via INSTEAD OF trigger!';
END;
GO

-- Now INSERT into the view works!
INSERT INTO vw_OrderSummary VALUES (103, 3, 'Keyboard', 1, 1500.00);

-- Verify data was correctly inserted in both tables
SELECT * FROM Orders;
SELECT * FROM OrderItems;
SELECT * FROM vw_OrderSummary;


-- ============================================================
-- TRIGGER EXAMPLE 6: CUSTOMERS TABLE - FULL AUDIT TRIGGERS
-- Scenario: Real-world example with validation + logging
-- ============================================================

DROP TABLE IF EXISTS customer_audit;
DROP TABLE IF EXISTS customers;

-- Main customers table
CREATE TABLE customers
(
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email         VARCHAR(100),
    phone         VARCHAR(20),
    customer_type VARCHAR(10)   -- 'VIP' or 'Regular'
);

-- Audit table: records WHO did WHAT and WHEN
CREATE TABLE customer_audit
(
    audit_id    INT IDENTITY(1, 1) PRIMARY KEY,
    customer_id INT,
    [action]    VARCHAR(10),        -- 'INSERT', 'UPDATE', 'DELETE'
    action_date DATETIME DEFAULT GETDATE()
);

-- -----------------------------------------------
-- AFTER INSERT TRIGGER on customers
-- Validates: email cannot be empty
-- Logs: every successful insert
-- -----------------------------------------------
GO
CREATE OR ALTER TRIGGER trg_customers_AfterInsert
ON dbo.customers
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validation: email must not be NULL or blank
    IF EXISTS (
        SELECT 1 FROM inserted
        WHERE email IS NULL OR LTRIM(RTRIM(email)) = ''
    )
    BEGIN
        ROLLBACK TRANSACTION;   -- undo the insert
        THROW 50001, 'Email cannot be empty!', 1;
        RETURN;
    END

    -- Log the successful insert
    INSERT INTO dbo.customer_audit (customer_id, [action])
    SELECT customer_id, 'INSERT' FROM inserted;
END;
GO

-- -----------------------------------------------
-- AFTER UPDATE TRIGGER on customers
-- Validates: phone cannot be empty
-- Logs: every successful update
-- -----------------------------------------------
GO
CREATE OR ALTER TRIGGER trg_customers_AfterUpdate
ON dbo.customers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Validation: phone must not be NULL or blank
    IF EXISTS (
        SELECT 1 FROM inserted
        WHERE phone IS NULL OR LTRIM(RTRIM(phone)) = ''
    )
    BEGIN
        ROLLBACK TRANSACTION;   -- undo the update
        THROW 50002, 'Phone cannot be empty!', 1;
        RETURN;
    END

    -- Log the successful update
    INSERT INTO dbo.customer_audit (customer_id, [action])
    SELECT customer_id, 'UPDATE' FROM inserted;
END;
GO

-- -----------------------------------------------
-- AFTER DELETE TRIGGER on customers
-- Business Rule: VIP customers CANNOT be deleted
-- Logs: every allowed delete
-- -----------------------------------------------
GO
CREATE OR ALTER TRIGGER trg_customers_AfterDelete
ON dbo.customers
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Block deletion of VIP customers
    IF EXISTS (SELECT 1 FROM deleted WHERE customer_type = 'VIP')
    BEGIN
        ROLLBACK TRANSACTION;  -- undo the delete
        THROW 50003, 'Cannot delete a VIP customer!', 1;
        RETURN;
    END

    -- Log the allowed deletion
    INSERT INTO dbo.customer_audit (customer_id, [action])
    SELECT customer_id, 'DELETE' FROM deleted;
END;
GO

-- -----------------------------------------------
-- TESTING CUSTOMER TRIGGERS
-- -----------------------------------------------

-- Test 1: Valid INSERT (should succeed + log)
INSERT INTO customers VALUES (1, 'Ram',   'ram@gmail.com',   '9876543210', 'Regular');
INSERT INTO customers VALUES (2, 'Shyam', 'shyam@gmail.com', '9123456789', 'VIP');
INSERT INTO customers VALUES (3, 'Geeta', 'geeta@gmail.com', '9001234567', 'Regular');

-- Test 2: Invalid INSERT - empty email (should FAIL with error)
-- INSERT INTO customers VALUES (4, 'Jay', '', '9001111111', 'Regular');  -- ERROR

-- Test 3: Valid UPDATE (should succeed + log)
UPDATE customers SET phone = '9000000001' WHERE customer_id = 1;

-- Test 4: Invalid UPDATE - empty phone (should FAIL)
-- UPDATE customers SET phone = '' WHERE customer_id = 1;  -- ERROR

-- Test 5: Valid DELETE - Regular customer (should succeed + log)
DELETE FROM customers WHERE customer_id = 1;

-- Test 6: Invalid DELETE - VIP customer (should FAIL)
-- DELETE FROM customers WHERE customer_id = 2;  -- ERROR: VIP cannot be deleted

-- Check audit log
SELECT * FROM customer_audit;
SELECT * FROM customers;


-- ============================================================
-- TRIGGER EXAMPLE 7: SALARY CHANGE HISTORY TRACKER
-- Scenario: Track every salary change with old and new values
-- and who made the change
-- ============================================================

DROP TABLE IF EXISTS SalaryChangeLog;

CREATE TABLE SalaryChangeLog
(
    LogID       INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeId  INT,
    OldSalary   INT,
    NewSalary   INT,
    ChangedBy   VARCHAR(100),      -- who made the change
    ChangedAt   DATETIME DEFAULT GETDATE()
);

GO
CREATE OR ALTER TRIGGER tr_employee_SalaryAudit
ON tblEmployee
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Only fire if Salary column was actually changed
    -- UPDATE() function returns TRUE if that column was modified
    IF UPDATE(Salary)
    BEGIN
        INSERT INTO SalaryChangeLog (EmployeeId, OldSalary, NewSalary, ChangedBy)
        SELECT
            i.Id,
            d.Salary,        -- 'deleted' = old value
            i.Salary,        -- 'inserted' = new value
            SYSTEM_USER      -- currently logged-in SQL user
        FROM inserted i
        JOIN deleted d ON i.Id = d.Id;
    END
END;
GO

-- Test salary tracker
UPDATE tblEmployee SET Salary = 9000 WHERE Id = 1;
UPDATE tblEmployee SET Salary = 6500 WHERE Id = 3;
UPDATE tblEmployee SET Name   = 'Johnny' WHERE Id = 1;  -- name change: trigger fires but UPDATE(Salary) = FALSE so no log

-- Check salary change history
SELECT * FROM SalaryChangeLog;


-- ============================================================
-- TRIGGER EXAMPLE 8: MULTI-ROW TRIGGER (handles bulk operations)
-- Scenario: A trigger that correctly handles INSERT/UPDATE/DELETE
--           of MULTIPLE rows at once (not just 1 row)
-- NOTE: 'inserted' and 'deleted' can hold MULTIPLE rows.
--       Using a scalar variable (DECLARE @Id INT; SELECT @Id = Id FROM inserted)
--       only gets ONE value if multiple rows. Use a JOIN instead!
-- ============================================================

DROP TABLE IF EXISTS BulkAuditLog;

CREATE TABLE BulkAuditLog
(
    LogID      INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeId INT,
    Action     VARCHAR(10),
    LogDate    DATETIME DEFAULT GETDATE()
);

GO
CREATE OR ALTER TRIGGER tr_tblEmployee_BulkAudit
ON tblEmployee
AFTER INSERT, UPDATE, DELETE   -- one trigger for all 3 events
AS
BEGIN
    SET NOCOUNT ON;

    -- Handle INSERT: log all inserted rows using INSERT...SELECT
    IF EXISTS (SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
    BEGIN
        -- Only inserted rows (pure INSERT, not UPDATE)
        INSERT INTO BulkAuditLog (EmployeeId, Action)
        SELECT Id, 'INSERT' FROM inserted;
    END

    -- Handle DELETE: log all deleted rows
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        -- Only deleted rows (pure DELETE, not UPDATE)
        INSERT INTO BulkAuditLog (EmployeeId, Action)
        SELECT Id, 'DELETE' FROM deleted;
    END

    -- Handle UPDATE: both inserted and deleted are populated
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO BulkAuditLog (EmployeeId, Action)
        SELECT Id, 'UPDATE' FROM inserted;
    END
END;
GO

-- Test with multiple rows
INSERT INTO tblEmployee VALUES (10, 'Ravi',  4500, 'Male',   1);
INSERT INTO tblEmployee VALUES (11, 'Priya', 5500, 'Female', 2);

UPDATE tblEmployee SET Salary = Salary + 500 WHERE DepartmentId = 1;

DELETE FROM tblEmployee WHERE Id = 10;

-- Check the bulk audit log
SELECT * FROM BulkAuditLog;


-- ============================================================
-- TRIGGER MANAGEMENT COMMANDS
-- ============================================================

-- View all triggers in the current database
SELECT
    t.name                    AS TriggerName,
    OBJECT_NAME(t.parent_id)  AS TableName,
    t.type_desc               AS TriggerType,
    t.create_date,
    t.modify_date,
    t.is_disabled             AS IsDisabled
FROM sys.triggers t
ORDER BY OBJECT_NAME(t.parent_id), t.name;

-- View trigger definition (code)
EXEC sp_helptext 'tr_tblEmployee_AfterInsert';

-- Disable a trigger (stops it from firing, does NOT delete it)
DISABLE TRIGGER tr_tblEmployee_AfterInsert ON tblEmployee;

-- Enable a trigger again
ENABLE TRIGGER tr_tblEmployee_AfterInsert ON tblEmployee;

-- Disable ALL triggers on a table
DISABLE TRIGGER ALL ON tblEmployee;

-- Enable ALL triggers on a table
ENABLE TRIGGER ALL ON tblEmployee;

-- Drop (delete) a trigger
DROP TRIGGER IF EXISTS tr_tblEmployee_BulkAudit;

-- ============================================================
-- TRIGGER KEY CONCEPTS SUMMARY (for exam)
-- ============================================================
-- AFTER Trigger:
--   AFTER INSERT  -> inserted table has new rows, deleted is EMPTY
--   AFTER DELETE  -> deleted table has old rows,  inserted is EMPTY
--   AFTER UPDATE  -> inserted has NEW values, deleted has OLD values
--
-- INSTEAD OF Trigger:
--   Replaces the DML action entirely
--   Mostly used on VIEWS that span multiple tables
--
-- UPDATE() function inside trigger:
--   IF UPDATE(ColumnName) -> returns TRUE if that column was changed
--
-- ROLLBACK inside trigger:
--   Cancels the DML that caused the trigger to fire
--   Use with THROW or RAISERROR to show an error message
--
-- Multi-row triggers:
--   Always use INSERT...SELECT from inserted/deleted
--   Never assume only 1 row was affected!
--
-- SET NOCOUNT ON:
--   Best practice inside triggers and stored procedures
--   Suppresses the "n row(s) affected" messages
-- ============================================================


-- ============================================================
-- QUICK REFERENCE SUMMARY (for exam)
-- ============================================================
-- DDL:    CREATE, ALTER, DROP, TRUNCATE
-- DML:    INSERT, UPDATE, DELETE
-- DQL:    SELECT
-- TCL:    COMMIT, ROLLBACK, SAVEPOINT
--
-- JOINS:  INNER | LEFT | RIGHT | FULL OUTER | CROSS | SELF
-- SET:    UNION | UNION ALL | INTERSECT | EXCEPT
-- AGG:    COUNT | SUM | MAX | MIN | AVG
-- CONST:  NOT NULL | UNIQUE | CHECK | DEFAULT | PK | FK
--
-- SQL Execution Order:
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
--
-- TRIGGER inserted/deleted table rules:
--   INSERT  -> inserted = new rows  | deleted = EMPTY
--   DELETE  -> inserted = EMPTY     | deleted = old rows
--   UPDATE  -> inserted = new vals  | deleted = old vals
-- ============================================================


/* =============================================
   COMPLETE TRIGGER EXAMPLE
   Database + Tables + Data + View + Trigger
============================================= */

-- =============================================
-- STEP 1: CREATE DATABASE
-- =============================================
CREATE DATABASE EmployeeDB;
GO

USE EmployeeDB;
GO


-- =============================================
-- STEP 2: CREATE DEPARTMENT TABLE
-- =============================================
CREATE TABLE tblDepartment
(
    Id INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);
GO


-- =============================================
-- STEP 3: INSERT DEPARTMENT DATA
-- =============================================
INSERT INTO tblDepartment (Id, DepartmentName) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Payroll'),
(4, 'Admin');
GO


-- =============================================
-- STEP 4: CREATE EMPLOYEE TABLE
-- =============================================
CREATE TABLE tblEmployee
(
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Gender VARCHAR(10),
    DepartmentId INT,
    CONSTRAINT FK_tblEmployee_Department
    FOREIGN KEY (DepartmentId) REFERENCES tblDepartment(Id)
);
GO


-- =============================================
-- STEP 5: INSERT EMPLOYEE DATA
-- =============================================
INSERT INTO tblEmployee (Id, Name, Gender, DepartmentId) VALUES
(1,'John', 'Male', 3),
(2,'Mike', 'Male', 2),
(3,'Pam', 'Female', 1),
(4,'Todd', 'Male', 4),
(5,'Sara', 'Female', 1),
(6,'Ben', 'Male', 3);
GO


-- =============================================
-- STEP 6: CREATE VIEW
-- =============================================
CREATE VIEW vWEmployeeDetails
AS
SELECT 
    e.Id,
    e.Name,
    e.Gender,
    d.DepartmentName AS DeptName
FROM tblEmployee e
JOIN tblDepartment d
ON e.DepartmentId = d.Id;
GO


-- =============================================
-- STEP 7: CREATE INSTEAD OF UPDATE TRIGGER
-- =============================================
CREATE TRIGGER tr_vWEmployeeDetails_InsteadOfUpdate
ON vWEmployeeDetails
INSTEAD OF UPDATE
AS
BEGIN

    -- If Id is updated (Not Allowed)
    IF (UPDATE(Id))
    BEGIN
        RAISERROR('Id cannot be changed', 16, 1)
        RETURN
    END

    -- If Department Name is updated
    IF (UPDATE(DeptName))
    BEGIN
        DECLARE @DeptId INT

        SELECT @DeptId = d.Id
        FROM tblDepartment d
        JOIN inserted i
        ON i.DeptName = d.DepartmentName

        IF (@DeptId IS NULL)
        BEGIN
            RAISERROR('Invalid Department Name', 16, 1)
            RETURN
        END

        UPDATE e
        SET DepartmentId = @DeptId
        FROM tblEmployee e
        JOIN inserted i
        ON e.Id = i.Id
    END

    -- If Gender is updated
    IF (UPDATE(Gender))
    BEGIN
        UPDATE e
        SET Gender = i.Gender
        FROM tblEmployee e
        JOIN inserted i
        ON e.Id = i.Id
    END

    -- If Name is updated
    IF (UPDATE(Name))
    BEGIN
        UPDATE e
        SET Name = i.Name
        FROM tblEmployee e
        JOIN inserted i
        ON e.Id = i.Id
    END

END
GO


-- =============================================
-- STEP 8: TESTING THE TRIGGER
-- =============================================

-- 1. Update Name
UPDATE vWEmployeeDetails
SET Name = 'Johnny'
WHERE Id = 1;

-- 2. Update Gender
UPDATE vWEmployeeDetails
SET Gender = 'Female'
WHERE Id = 2;

-- 3. Update Department
UPDATE vWEmployeeDetails
SET DeptName = 'IT'
WHERE Id = 3;

-- 4. Try Updating Id (Should Give Error)
UPDATE vWEmployeeDetails
SET Id = 10
WHERE Id = 1;


-- =============================================
-- STEP 9: CHECK FINAL RESULT
-- =============================================
SELECT * FROM vWEmployeeDetails;
 
 --- If DeptName is updated
IF (UPDATE(DeptName)) 
BEGIN
    DECLARE @DeptId INT

    SELECT @DeptId = d.Id
    FROM tblDepartment d
    JOIN inserted i
        ON i.DeptName = d.DepartmentName

    IF (@DeptId IS NULL)
    BEGIN
        RAISERROR('Invalid Department Name', 16, 1)
        RETURN
    END

    UPDATE e
    SET DepartmentId = @DeptId
    FROM tblEmployee e
    JOIN inserted i
        ON e.Id = i.Id
END


-- If Gender is updated
IF (UPDATE(Gender))
BEGIN
    UPDATE e
    SET Gender = i.Gender
    FROM tblEmployee e
    JOIN inserted i
        ON e.Id = i.Id
END


-- If Name is updated
IF (UPDATE(Name))
BEGIN
    UPDATE e
    SET Name = i.Name
    FROM tblEmployee e
    JOIN inserted i
        ON e.Id = i.Id
END

(
select eid,ename,esalary,department,row_number() over(partition by department order by 
from employess
)
SELECT* FROM highestempsalary where rownumb =3

--example of recursive

