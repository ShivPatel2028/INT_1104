/* ================================
   DATABASE SETUP
================================ */
CREATE DATABASE assignment_1;
GO

USE assignment_1;
GO

/* ================================
   LITERAL SELECT PRACTICE
================================ */

-- 1) Return your name
SELECT 'Shiv' AS Name;
GO

-- 2) Product of 7 and 4
SELECT 7 * 4 AS Product;
GO

-- 3) (7 − 4) × 8
SELECT (7 - 4) * 8 AS Result;
GO

-- 4) Return phrase
SELECT 'Brewster''s SQL Training Class' AS Phrase;
GO

-- 5) Phrase + calculation
SELECT 'Day 1 of Training' AS Phrase, 5 * 3 AS Product;
GO

/* ================================
   EMPLOYEE TABLE
================================ */

CREATE TABLE Employee (
    EmployeeID INT,
    Name VARCHAR(20),
    Age INT,
    National_id_no VARCHAR(20)
);
GO

-- 1) National ID only
SELECT National_id_no FROM Employee;
GO

-- Add Job Title
ALTER TABLE Employee ADD Job_Title VARCHAR(20);
GO

-- 2) National ID + Job Title
SELECT National_id_no, Job_Title FROM Employee;
GO

-- Add Birth Date
ALTER TABLE Employee ADD Birth_Date DATE;
GO

-- 3) Top 20 percent
SELECT TOP (20) PERCENT
    National_id_no,
    Job_Title,
    Birth_Date
FROM Employee;
GO

-- 4) Top 500 with aliases
SELECT TOP (500)
    National_id_no AS SSN,
    Job_Title AS [Job Title],
    Birth_Date
FROM Employee;
GO

/* ================================
   SALES ORDER HEADER
================================ */

CREATE TABLE SalesOrderHeader (
    Product_id INT,
    Order_date DATE,
    Product_name VARCHAR(20),
    Description VARCHAR(MAX)
);
GO

-- 5) All rows and columns
SELECT * FROM SalesOrderHeader;
GO

/* ================================
   CUSTOMER TABLE
================================ */

CREATE TABLE Customer (
    Customer_id INT,
    Customer_name VARCHAR(20),
    Email VARCHAR(100),
    Phone_no VARCHAR(15)
);
GO

-- 6) Top 50 percent
SELECT TOP (50) PERCENT * FROM Customer;
GO

/* ================================
   PRODUCT AND DESCRIPTION VIEW (SIMULATED)
================================ */

CREATE TABLE ProductAndDescription (
    Product_id INT,
    Product_name VARCHAR(20),
    Description VARCHAR(MAX)
);
GO

-- 7) Product name with alias
SELECT Product_name AS [Product's Name]
FROM ProductAndDescription;
GO

/* ================================
   DEPARTMENT
================================ */

CREATE TABLE Department (
    Dept_name VARCHAR(20),
    Dept_code INT
);
GO

-- 8) Top 400 rows
SELECT TOP (400) * FROM Department;
GO

/* ================================
   BILL OF MATERIALS
================================ */

CREATE TABLE BillOfMaterials (
    Bill_id INT,
    Bill_date DATE,
    Product VARCHAR(20)
);
GO

-- 9) All rows and columns
SELECT * FROM BillOfMaterials;
GO

/* ================================
   PERSON DEMOGRAPHICS (VIEW SIMULATION)
================================ */

CREATE TABLE vPersonDemographics (
    Id INT,
    purchase_date DATE,
    Gender CHAR(1),
    Edu VARCHAR(20)
);
GO

-- 10) Top 1500 rows
SELECT TOP (1500) * FROM vPersonDemographics;
GO
