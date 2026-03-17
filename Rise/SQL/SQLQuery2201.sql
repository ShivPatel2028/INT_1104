--Day-1 22/01

-- To create database
-- Create Database <Name>
-- Drop databse <DBName>
--Alter database <DBName> - Modify NAME= <NewName>-> Change DBName
CREATE DATABASE JAN2026

--Use <DBName>
Use JANUARY2026

Drop database JANUARY2026

Alter database JAN2026 MODIFY NAME = JANUARY2026

--Types of SQL Language
--DDL=> Structure of DB
--create, alter, drop, truncate
--DML=> Modify table/DB
--insert, update, delete
--DQL=> Query Lang => Data Fetching
--select
--TCL=>Transaction Control Lang => Control Transaction
--Commit, rollback, savepoint

Select 4+4 as Additions
Select 4 + Null As Addi
Select 'Hello ' + ' World' as Col1
Select GETDATE()
Select SYSTEM_USER

--to create a table <Name>
--Create Table <Name>
--(Col1 name <datatype>, col2 name <datatype>)

Create Table EMPL (EID INT, Ename Varchar(20), Eage Int, ESalary Money)

Select * from EMPL

--Rename tablename
EXEC sp_rename 'EMPL', 'EMPLOYEE'
EXEC sp_rename 'EMPLOYEE', 'EMPL'

--Rename Colname=> sp_rename 'tablename.oldcolname', 'newcolname'
EXEC sp_rename 'EMPL.EID', 'EMPID'

--show tables of db
select name from sys.databases

--Shows all the tables created in database, create_date gives the date and time of creation of database
select name, create_date from sys.tables

--To add a column if forgotens
Alter table EMPL Add Email Varchar(20)

--to delete a column 
Alter table EMPL drop column Email

--to update datatype
Alter table EMPL alter column EMPID varchar(10)

--drop table <tablename>
drop table EMPL

--Insert Method-1
Insert into EMPL values (1, 'Suresh', 20, 20000)
Select * from EMPL

Insert into EMPL values (2, 'Mahesh', 23, 26000)
Select * from EMPL

--Insert Method-2
Insert into EMPL(EMPID, Eage) values (3, 27)
Select * from EMPL

--Insert Method-3
Insert into EMPL values (4, 'Sam', 22, 24000),(5, 'Miren', 32, 56000)
Select * from EMPL

Insert into EMPL values (6, 'Shakti', 23, 26000)
Select * from EMPL

Insert into EMPL values (7, 'Shiv', 28, 26000)
Select * from EMPL

Insert into EMPL values (8, 'venish', 25, 26000)
Select * from EMPL

Select Top(2) * from EMPL

Select Top(2)percent * from EMPL

Select Top 0 * from EMPL


--Day-2 23/01
--ALL details like creation,  datatype, entire schema is displayed
sp_help EMPL

--Update tablebname set colname=value where colname=value Method-1
Update EMPL Set ESalary = 17000 where Ename='Suresh' 
Select * from EMPL

--Update Method-2
Update EMPL Set ESalary = 40000 where Esalary is Null
Select * from EMPL

--Update Method-3 All will update
Update EMPL Set ESalary =33000

Update EMPL SET ESalary = 44000 where EMPID in (1, 7)
Select *  from EMPL

--TO Delete a record in the table Method-1
Delete from EMPL where EMPID=7

--Method-2 for Delete
Delete from EMPL where Ename is null
Select * from EMPL

--Method-3 for Delete
Delete from EMPL

Drop table EMPL

Truncate table EMPL

--Delete will only delete all the records/rows/truples of the table, table structure/schema will remains as it is
--Drop will Delete the entire table, we cannot use any filter clause in Drop cmd, delete entire schema.
/*Truncate will only delete the entire records, very much similar to Delete,  much faster than delete, performance is better, table schema is also remains as it is*/

--Identity Function(Auto-increment)

Create table Employees (EID Int Identity, EName Varchar(255), EAge Int)

Insert into Employees VALUES ('Shyam', 23)
Select * from Employees

Insert into Employees VALUES ('Miren', 24), ('Rajesh', 30), ('Mahesh', 27), ('Jayesh', 25)
Select * from Employees

--When you want to manually insert the values
Set Identity_Insert Employees ON

Insert into Employees (EID, EName, EAge) VALUES (6, 'Shakti', 26)
Select * from Employees

--Now the system will assign the EID as declared before while creation
Set Identity_Insert Employees OFF

--Set Identity(100, 1),  at the time of table creation only..          Try at home 


--Day-3 27/01

Drop table Employees

--Arithmetic Operators +,-,*,/

Create table employees (Eid Int, Ename Varchar(255), Eage Int, Edepartment Varchar(255), Esalary Money)
Select * from employees

Insert into employees values (1, 'Sahil', 20, 'MERN', 21000), (2, 'Miten', 21, 'ReactJs', 25000),
(3, 'Soham', 24, 'NodeJs', 23000), (4, 'Riten', 23, 'QA', 24000), (5, 'Dhruv', 22, 'QA', 26000)
Select * from employees

Select Eid, Ename, Esalary, (Esalary+5000) AS SALARY_BONUS from employees

Select Eid, Ename, Esalary, (Esalary*1.05) As Increment from employees

--Select PID, PName, (Price*Quantity) AS Total_Sales from Sales

--Logical Operators (in, and, not, or)

Select * from employees where Eid in (1, 5)

Select * from employees where Edepartment in ( 'QA' , 'ReactJs' )

Select * from employees where Edepartment='QA' AND Esalary=24000

Select * from employees where (Edepartment='QA' AND Esalary=24000) OR EDepartment='MERN'


--Comparision Operators =, >, <, <=, >=
Select * from employees where Edepartment='MERN' AND Esalary<50000

Select * from employees where Esalary <> 21000 
--Not Equal to sign <>

--Not Null and Null
Insert employees(Eid, Ename, Edepartment) values (6, 'Adi', 'AI')
Select * from employees

Select * from employees where Esalary is not null

Select * from employees where Esalary between 20000 and 24000

Select * from employees where Esalary >= 20000 and Esalary <24000

Select * from employees where Ename like 'S%'

Select * from employees where Ename like '%@gmail.com'

Select * from employees where Esalary like '+91%'

Select * from employees where Edepartment='MERN' or Esalary=23000

Select * from employees

--And operator need both conditions to be true
--Or operator need only the given one condition to bo true

Delete from employees where Esalary is Null
Select  * from employees


--Day-4 28/01

--Set Operators -Union, Union ALL, Intersect, Except

Create table Bank_Vadodara 
(BID InT, 
Bname Varchar(20), 
location varchar(20))

Insert into Bank_Vadodara values 
(10, 'SBI', 'Akota'),
(20, 'HDFC', 'Manjalpur'),
(30, 'ICICI', 'Atladra')

Select * from Bank_Vadodara

Delete from Bank_Vadodara

Create table Bank_Surat
(BID int,
Bname Varchar(20),
Location Varchar(20))

Insert into Bank_Surat values 
(10, 'SBI', 'Akota'),
(20, 'AXIS', 'Varacha'),
(30, 'BOB', 'Udhna')

Select * from Bank_Surat

Select * from Bank_Vadodara
UNION
Select * from Bank_Surat

Select * from Bank_Vadodara
UNION ALL
Select * from Bank_Surat

Select * from Bank_Vadodara
INTERSECT
Select * from Bank_Surat

Select * from Bank_Vadodara
EXCEPT
Select * from Bank_Surat

Select BID, Bname, location from Bank_Vadodara
UNION
Select BID, Bname, location from Bank_Surat

--Number of columns must be same in both the tables 
--as well as the order of the columns should be same
--Data type should be same
--Number of supplied values must be same

--Clauses            (Group by and having)
--where              (use to apply filters on rows)
--group by           (use to group similiar data on a specific column)
--having             (use to filter the records after group by)

--Aggregate function (count, sum, min, max, avg)
--Count      (Numeric and non numeric datatype),
--Sum        (Numeric)
--Max, Min   (Both)
--Avg        (Numeric)

Select * from employees

Select COUNT(*) as TOTAL_COLUMNS from employees

Select MAX(Esalary) as MAX_SALARY from employees

Select AVG(Esalary) AS AVG_SALARY from employees

Select SUM(Esalary) AS TOTAL_SALARY from employees

Select MAX(Esalary) as Highest, MIN(Esalary) as Lowest, AVG(Esalary) as Average from employees


Select Edepartment, SUM(Esalary) from employees GROUP BY Edepartment

Select Edepartment, Count(Edepartment) from employees group by Edepartment

Select * from employees



--Day-5 29/01

Select count(Edepartment)
from employees
group by Edepartment
having count(Edepartment) >= 1

Select Edepartment, Max(Esalary) AS Highest
from employees
Group by Edepartment
Having Max(Esalary) > 22000
Order by Highest DESC

/*Select <col1>, agreegate func.
From <tablename>
Group BY <col1>
Having agreegate func.
Order by <default asc>

agreegate func is used when group by is used
*/

Select TOP (2) Max(Esalary)
From employees


Select * from employees

Select Edepartment, count(Edepartment)
From employees
Group by Edepartment
Having Count(Edepartment) >= 1
Order By 1

Select Edepartment, AVG(Esalary) AS AVG_SALARY
From employees
Group by Edepartment
Having AVG(Esalary) >20000

Select DISTINCT product_name, SUM(Quantity) As Total_Quantity
From Product
Group By product_name

Select region, MAX(product_price) AS MAX_PRICE
From product
Group By region

Select Edepartment, MAX(Esalary) AS MAX, MIN(Esalary) AS MIN
From employees
Group by Edepartment

Select region, SUM(Quantity * Sales) AS Total_Sales
From employees
Group by region
Having SUM(Quantity * Sales) <= 50000
Order By 1 DESC
	
--Group by and Having

--1)find the depar with avg sal > 20000
Select * from employees

Select Edepartment, AVG(Esalary)
From employees
Group by Edepartment
Having AVG(Esalary) > 20000

--2)list cities where avg emp age is > 20

Select Edepartment, AVG(Eage)
From employees
Group by Edepartment
Having AVG(Eage) > 20

--3)find depart with more than 5 emps

Select Edepartment, Count(Ename)
from employees
Group by Edepartment
Having Count(Ename) > 5

--4)list citiees where total sal of all emps exceeds 30000

Select Cities, SUM(Esalary)
From employees
Group BY Cities
Having SUM(Esalary) > 30000

--5)find depart where avg age of emps is between 20 and 25

Select Edepartment, AVG(Eage)
From employees
Group By Edepartment
Having AVG(Eage) BETWEEN 20 AND 25


--Constraints
--NOT NULL (ensures that a column must have a value, but it may allow duplicate values)
--UNIQUE (ensures that a column is having unique values, but it may allow null values)
--CHECK (will check the given condition on a particular column)
--DEFAULT (default will asign a default status/value in a column)


--NOT NULL
--UNIQUE
--CHECK
--DEFAULT


Create table EMP1
(EID INT Identity(101, 1),
Ename Varchar(20),
Eage INT default 18,
Salary Money 
Check (Salary > 18000)
)

Insert into EMP1 values ('Suresh', 20, 20000);

Select * from EMP1

Insert into EMP1(Ename, Salary) values ('Ramesh', 18050);

Drop table EMP1



Create table EMP1 
(EID INT NOT NULL UNIQUE,
Ename varchar(20),
Eage int NOT NULL)

Select * from sys.tables

sp_help EMP1

Create table Production
(Product_Name Varchar(20),
Product_Status Varchar(20) 
Default 'Pending' 
Check(Product_Status IN ('Undelivered', 'Pending', 'Shiping', 'Delivered'))
)

Select * from Production



-- Day-5 30/01 

--Constraints

Create table EMPL1 
(EID INT,
Ename varchar(20),
Eage int,
Email varchar(50))


Insert into EMPL1(EID, Ename, Eage) values (1, 'Suresh', 20)

Insert into EMPL1 values (2, 'Mahesh', 21, 'mahesh@gmail.com')

Insert into EMPL1 values (3, 'Mahesh', 22, 'mahesh@gmail.com')



Select * from EMPL1

--Alter table <tablename>
--Add Constraint <constraintname> Constraint

--Unique constraint is applied on email as now it not allows the existing email
Alter table EMPL1
Add Constraints UC_Cons Unique(Email)

--Checks the given Condition
Alter table EMPL1
Add Constraint CK_Cons Check (Eage>18)
Insert into EMPL1 values (4, 'Rahesh', 18, 'mahesh@gmail.com')


Create table Product 
(PID int,
Pname varchar(20),
Quantity int,
Status varchar(20))


Insert Into Product values (10, 'Laptop', 2, 'Delivered')

Insert Into Product values (11, 'Mobile', 1, 'Transit')

Insert Into Product(PID, Pname, Quantity) values (12, 'Charger', 1)

Select * from Product

Alter table Product
Add constraint DF_default
Default 'Pending' for Status

Insert Into Product(PID, Pname, Quantity) values (13, 'TV', 1)

Alter table Product
Drop Constraint DF_default

Insert Into Product(PID, Pname, Quantity) values (14, 'AC', 1)

--Syntax to add NOT NULL in the columnm, For removing it also use it by removing NOT NULL in the query
Alter table Product
Alter Column Quantity INT NOT NULL

Insert Into Product(PID, Pname, Status) values (14, 'AC', 'Transit')

Select * from Product

Alter table Product
Alter Column Quantity INT 

Insert Into Product(PID, Pname, Status) values (14, 'AC', 'Transit')

EXEC sp_help Product

Select * from Product



--Day-6 02/02
--Primary key and foreign key
--Primary key will automatic sort the table in ascending orders
--Update and Delete is not allowed in Primary Key
--Primary Key (Unique + Not Null)
--Foreign Key builds the relation between two tables
--Foreign Key ()

Create table emp
(empid int,
e_pan Varchar(20) Primary Key,
ename varchar(20))

Drop table emp


Insert into emp values
(2, 'fsrgg3241f', 'Mahesh'),
(1, '23432dsvf2', 'Suresh'),
(3, 'xcxvasdgv2', 'Rajesh')

Select * from emp

Insert into emp values (4, 'Suresh');
Insert into emp values (2, 'Haresh')
Insert into emp(ename) values ('Jayesh')


--Foreign Key builds the relation between two tables
--To maintain referentail data integrity
--Foreign Key ()

Create table Courses
(cid int Primary Key,
cname varchar (20),
cfee Money)

Insert into Courses values (10, 'FullStack', 1000)
Insert into Courses values (20, 'Cloud', 2000)
Insert into Courses values (30, 'AI', 3000)
Insert into Courses values (40, 'QA', 4000)
Update Courses Set cfee = 5000 where cname = 'QA'

Select * from Courses


Create table Student
(sid int,
sname varchar(20),
cid int Foreign Key references Courses (cid))

Insert into Student values (1, 'Suresh', 10), (2, 'Mahesh', 20), (3, 'Rajesh', 30)

Select * from Courses
Select * from Student

Insert into Student values (3, 'Jayesh', 40)

Update Courses 
Set cid = 50 
where Cname = 'QA' 
--will give error conflicted with the REFERENCE constraint "FK__Student__cid__7B264821"

Update Student
Set cid = 50
where sid = 3
--will give error same error as above


Update Student
Set cid = 40
where sid = 3

Delete from Courses where cid = 40
--gives error

Delete from Student where sid = 3

Drop table Courses 
--we cannot drop parent table firstly

Drop table Student


Create table Courses
(cid int Primary Key,
cname varchar (20),
cfee Money)


Create table Student
(sid int,
sname varchar(20),
cid int Foreign Key references Courses (cid) on update cascade on delete cascade)


Select * from Courses
Select * from Student


Update Courses
Set cid = 50 
where cname = 'AI'

Delete from Courses
where cid = 50

--to make a column primary key if not declared at the time of table creation
Alter table Courses
Add Constraint PK_Course Primary Key (CID)

ALter table Courses
Drop constraint PK__Courses__D837D05FB673D5A4

EXEC sp_help Courses

Alter table Student
Add Constraint FK_Student Foreign Key (cid) references Courses (cid)

Alter table Student
Drop Constraint FK__Student__cid__7EF6D905


--Primary key using two columns --- i.e. Composite Keys
Create table Courses1
(cid int,
sid int,
cname varchar(20),
Primary Key (cid, sid))

Create table Student1
(cid int,
sid int, 
sname varchar(20),
Foreign Key (cid, sid)
references Courses1 (cid, sid))

Select * from Courses1
Select * from Student1

Drop table Student1
Drop table Courses1



--Day-7 03/02

/*
Select 
From
Where
Group By
Having
Order By */

--Sub-Query(Nested query) Multiple Queries
--Sub-Query = Outer Query + Inner Query
--Corelated & Non Corelated query (Outer Query is dependent on inner query)
--Corelated Query = Inner query is dependant on outer query

Select * from employees

Select  Max(Esalary) from employees

Select Top (2) Eid, Ename, Eage, Edepartment, Esalary from employees
Order by Esalary DESC

Select * from employees Where Esalary = (Select  Max(Esalary) from employees)

--Find 2nd highesh salary
Select * from employees Where Esalary = (Select Max(Esalary) from employees Where Esalary < (Select Max(Esalary) from employees))

--Find  all product that have price higher than the avg price of all product
Select * from Product where Price > (Select AVG(Price) from Product)
Select Ename, Esalary from employees where Esalary > (Select AVG(Esalary) from employees)

--write a query to list all products that have atleast one sales record in the vadodara region
Select * from Bank_Vadodara

Select Distinct Bname from Bank_Vadodara
Where Bname IN
(Select Bname
from Bank_Vadodara
Where location = 'Akota')

--Find Names of department that have atleast one employee older than 30 yrs
Select * from employees

Select Edepartment from employees
where Edepartment IN
(Select Edepartment from employees where Eage>20)

--Write a query to find ename, dep and sal of emp who earns the maximum salary in their department

Select Ename, Edepartment, Esalary from employees
Where Esalary IN
(Select Max(Esalary) from employees Group by Edepartment)



--Day-8 04/02

--Assignment-5


--Day-9 05/02

--Joins
--Combining two or more tables
--Atleast one common column betwee tables
--Datatype must be same
--Two types of Joins (ANSI & NON-ANSI)
--ANSI  -using ON keyword
--NON-ANSI -Using WHERE keyword

--SELECT * FROM A INNER JOIN B ON A.KEY = B.KEY

--Inner Join (Matching Values)
--Left Join (Inner + Left)
--Right Join (Inner + Right)
--Left Join Excluding Inner Join (Left)
--Right Join Excluding Inner Join (Right)
--Full Outer Join (Inner + Left + Right)
--Full Outer Join Excluding Inner Join (Left + Right)


--Left Join Excluding Inner Join (Left)
--SELECT * FROM A LEFT JOIN B ON A.KEY = B.KEY WHERE B.KEY IS NULL

--Right Join Excluding Inner Join (Right)
--SELECT * FROM A RIGHT JOIN B ON A.KEY=B.KEY WHERE A.KEY IS NULL
--SELECT * FROM B LEFT JOIN A ON A.KEY=B.KEY WHERE A.KEY IS NULL

--Full Outer Join
--SELECT * FROM A FULL OUTER JOIN B ON A.KEY=B.KEY WHERE A.KEY IS NULL

--Full Outer Join Excluding Inner Join
--SELECT * FROM A FULL OUTER JOIN B ON A.KEY=B.KEY WHERE A.KEY=NULL OR B.KEY=NULL


Create table Course
(Cid int,
Cname Varchar(255),
Cfee Money)



Insert into Course Values (10, 'Full Stack', 1000), (20, 'QA', 1000), (30, 'Cloud', 2000), (40, 'AI', 3000)

Select * from Course

Create table Student1
(Sid int,
Sname varchar(20), 
Cid int)

Insert into Student1 values (1, 'Suresh', 10), (2, 'Mahesh', 20), (3, 'Jayesh', 50)

Select * from Course
Select * from Student1

Select * from Course INNER JOIN Student1 ON Course.Cid = Student1.Cid

Select * from Course LEFT JOIN Student1 ON Course.Cid = Student1.Cid

Select * from Course RIGHT JOIN Student1 ON Course.Cid = Student1.Cid

Select * from Course LEFT JOIN Student1 ON Course.Cid = Student1.Cid Where Student1.Cid is NULL

Select * from Course RIGHT JOIN Student1 ON Course.Cid = Student1.Cid Where Course.Cid is NULL

Select * from Course FULL JOIN Student1 ON Course.Cid = Student1.Cid

Select * from Course FULL JOIN Student1 ON Course.Cid = Student1.Cid Where Course.Cid is NULL or Student1.Cid is NULL


--Cross Join (Cartesian Product)

Select * from Course Cross Join Student1
Select * from Course, Student1



Create table Customer
(CustomerID Int,
Customername varchar(20),
CustomerCity varchar(30),
CustomerNo Int)

Alter table Customer
Alter column CustomerNo BigINT

Select * from Customer

Insert into Customer values (1, 'Miren', 'Vapi', 1234567891), (2, 'Shivam', 'Surat', 9876543215), (3, 'Dev', 'Bharuch', 4657456727), (4, 'Riki', 'Baroda', 8768555997)



Create table Ord
(OrderID Int, 
Productname varchar(20),
Orderdate date Default Getdate(),
CustomerID Int)

SELECT * FROM Customer
Select * from Ord

Insert into Ord(OrderID, Productname, CustomerID) values (10, 'Laptop', 1), (20, 'Mobile', 2), (30, 'Headphones', 5)

SELECT * FROM Customer LEFT JOIN Ord ON Customer.CustomerID = Ord.CustomerID

SELECT * FROM Customer RIGHT JOIN Ord ON Customer.CustomerID = Ord.CustomerID

SELECT * FROM Customer INNER JOIN Ord ON Customer.CustomerID = Ord.CustomerID

SELECT * FROM Customer LEFT JOIN Ord ON Customer.CustomerID = Ord.CustomerID WHERE Ord.CustomerID IS NULL

SELECT * FROM Customer RIGHT JOIN Ord ON Customer.CustomerID = Ord.CustomerID WHERE Customer.CustomerID IS NULL	

SELECT * FROM Customer FULL JOIN Ord ON Customer.CustomerID = Ord.CustomerID

SELECT * FROM Customer FULL JOIN Ord ON Customer.CustomerID = Ord.CustomerID WHERE Customer.CustomerID IS NULL OR Ord.CustomerID IS NULL

SELECT * FROM Customer CROSS JOIN Ord
SELECT * FROM Customer, Ord


--Non-ANSI joins (WHERE)  --no one uses it. mostly used ANSI joins
--Equi Joins (Only equality operator) =
--Non-Equi Joins (Except equality operator) <, >, <=, >=

Select * from Course, Student1 
WHERE Course.Cid = Student1.Cid

Select * from Course, Student1 
WHERE Course.Cid > Student1.Cid

Select * from Course, Student1 
WHERE Course.Cid <> Student1.Cid

--cid, cusname, bankid, bankname
--bankname, cusid, acc no, bank branch



--Day-10 06/02

Create table Employeeee
(EID VARCHAR(20) Primary key,
ENAME VARCHAR(255),
MID INT,
DID INT)

--Create table Department1
--(DID INT Primary key,
--DNAME VARCHAR(255))

Create table Project1
(PID VARCHAR(20) Primary Key,
PNAME VARCHAR(255),
EID VARCHAR(20) foreign Key references Employeeee (EID))

--Create table Manager
--(MID INT,
--MNAME VARCHAR(255))

INSERT INTO Employeeee VALUES
('E01', 'Rohan', 101, 2),
('E02', 'Sneha', 102, 1),
('E03', 'Arjun', 101, 2),
('E04', 'Kavya', 103, 3),
('E05', 'Manish', 104, 4),
('E06', 'Anita', 105, 5);

--INSERT INTO Department VALUES
--(1, 'HR'),
--(2, 'IT'),
--(3, 'Finance'),
--(4, 'Marketing'),
--(5, 'Operations');

INSERT INTO Project1 VALUES
('P01', 'Payroll System', 'E01'),
('P02', 'Website Revamp', 'E03'),
('P03', 'Recruitment App', 'E02'),
('P04', 'Finance Audit', 'E04'),
('P05', 'Marketing Campaign', 'E05'),
('P06', 'Supply Chain Tool', 'E06');

--INSERT INTO Manager VALUES
--(101, 'Amit Shah'),
--(102, 'Neha Patel'),
--(103, 'Rahul Mehta'),
--(104, 'Priya Nair'),
--(105, 'Suresh Kumar');

Select * from Employeeee
Select * from Project1
--Select * from Department
--Select * from Manager

--Drop table Employee
--Drop table Department
--Drop table Project
--Drop table Manager 

--Day-10 09/02

--Trains Assignment


--Day-11 10/02

--View(VIRTUAL TABLE)
--To give restricted table, not the base table
--do not give all the access to persons

Select * from Employeeee

CREATE VIEW vw_Employeedetails
AS
SELECT Eid, Ename
FROM Employeeee;

Select * from vw_Employeedetails

Alter View vw_Employeedetails
AS
Select Eid, Ename, MID
From Employeeee

Select * from vw_Employeedetails

--Drop View vw_Employeedetails

Select * from vw_Employeedetails

Create View vw_EmployeeProjectdetails
AS
Select E.Eid, E.Ename
From Employeeee E
Join Project1 P
on E.Eid = P.Eid

Select * from vw_EmployeeProjectdetails

Alter View vw_EmployeeProjectdetails
AS
Select E.Eid, E.Ename, P.PNAME
From Employeeee E
Join Project1 P
on E.Eid = P.Eid

Select * from vw_EmployeeProjectdetails
Select * from vw_Employeedetails

Update vw_Employeedetails
Set Ename = 'MIREN'
Where Eid = 'E06'

Select * from vw_Employeedetails
Select * from Employeeee

Update Employeeee
Set Ename = 'VENISH'
Where Eid = 'E05'

Update vw_Employeedetails
Set EID = 'E107',
Pname= 'Payroll System'

ALter View vw_Employeedetails
With encryption
as
Select Eid, Ename, MID
From Employeeee

sp_helptext 'vw_Employeedetails'
sp_help vw_Employeedetails

Select * from Employeeee

Create View vw_employeeupdate
As 
Select EID, ENAME
From Employeeee

Select * from vw_employeeupdate

Update vw_employeeupdate
Set ENAME = 'Shakti'
Where EID = 'E04'

Delete from vw_employeeupdate
Where EID = 'E06'

--

Create Table EmployeeV
(EID int, 
Name varchar(20),
DID Int) 

Create Table DepartmentV
(DID Int,
DName VARchar(20))

Insert into EmployeeV Values
(1, 'Suresh', 10), (2, 'Jayesh', 10), (3, 'Mahesh', 30)

Insert into DepartmentV VAlues
(10, 'IT'), (20, 'Cloud'), (30, 'AI')

Select * from EmployeeV
Select * from DepartmentV

Create View vw_EMPDEPDETAILS
AS
Select E.EID, E.Name, D.DName
From EmployeeV E
Join
DepartmentV D
ON E.DID = D.DID

Update vw_EMPDEPDETAILS 
Set DName= 'QA'
Where Name = 'Jayesh'

Select * from vw_EMPDEPDETAILS

update vw_EMPDEPDETAILS
Set DName = 'Data'
Where EID = 1

Select * from vw_EMPDEPDETAILS

Alter View vw_EMPDEPDETAILS
With Encryption
AS
Select E.EID, E.Name
From EmployeeV E


sp_helptext vw_EMPDEPDETAILS

--Schema

Create table Test 
(TID int,
Tname Varchar(20),
City varchar(20))


Insert into Test values
(1, 'QA', 'Vadodara'),
(2, 'Cloud', 'Anand'),
(3, 'AI', 'Ahmedabad')

Select * from Test

Create View vw_TestDetails
With Schemabinding
As
Select TID, Tname
From dbo.Test

Select * from vw_TestDetails

Alter table Test
Drop column TID

Alter table vw_TestDetails
Drop column TID 

Select name, create_date from sys.tables
Select name from sys.views



--Day-12 11/02

--Index
--Two Types (Clustered & Non-Clustered) : Used for faster retrival
--Clustered can be one per table, it refers to physical order of the table
--Non-Clustered can be multiple per table

--Create index <IX_Name>
--On <Tablename> <ColName>

Select * from employees

Create index IX_EmpSalary
on employees (Esalary ASC)

Select Esalary from employees

--Drop Index <tablename>.<indexname>
drop index employees.IX_EmpSalary

--Composite index(more than one columns is assigned)

Create Index IX_EmpSalaryWithDepartment
On employees (Edepartment DESC, Esalary ASC)

Select Edepartment, Esalary from employees



--Clustered Index
--Order the column physically ASC
Select * from employees


Create Clustered Index IX_EmpID
On employees (Eid)

Select * from employees

Insert into employees values 
(7, 'MIREN', 31, 'GENAI', 30000),
(6, 'SHAKTI', 29, '.NET', 20000)

--Create Clustered Index IX_EMPAGE
--ON employees (Eage)
EXEC sp_helpindex employees

--Unique Index
Create Unique index IX_Eid
ON employees (Eid)

Select Eid from employees

--Create Non-Clustered index

--Create NonClustered Index IX_TerminationDate
--on employees (TerminationDate)
--where TerminationDate is NOT NULL

Create table emp2
(Eid int primary key,
Ename varchar(20),
Eage int, 
department varchar(30),
esalary money)

Insert into emp2 values
(1, 'Suresh', 20, 'AI', 20000),
(2, 'Mahesh', 23, 'CS', 19000),
(3, 'Kamlesh', 21, 'CE', 21000),
(4, 'Jayesh', 19, 'EC', 25000)

Create Clustered Index IX_Eid
on emp2 (Eid)



--Day-13 12/02

--Functions
--CAST = convert datatype (of one column) like INT to VARCHAR(20)
--caolesce = to find first not null value
--datadiff = for how long the employee is working in the organization
--replace = String, string to string, newstring

Select * from employees

Select Ename, '$' + CAST(Esalary as varchar)
from employees


--caolesce = to find first not null value

Select Eid, Ename, COALESCE(officialemail, personalemail, 'No email found') from employees

--datadiff = for how long the employee is working in the organization
--find out employee age

--datediff(interval, start_date, end_date)

Select Ename, DOJ, datediff(Year, DOJ, Getdate()) from employees

Select Ename, DOB, datediff(Year, DOB, Getdate()) AS YearsOfExpirence from employees

--replace = String, string to string, newstring

Select Replace('Suresh  Patel', ' ', ' ')

--trim

Select Ename, trim(Ename) AS trim_name from employees

--len

Select len(Ename) from employees

--Upper

Select Upper(Ename) from employees

--Lower

Select LOWER(Ename) from employees

--getdate

Select Getdate() from employees

--Concat()

Select Concat('Suresh', NULL)
Select Concat('Edepartment', 'DOB')



ALter table employees
Add DOB Date

ALter table employees
Add officialemail varchar(30)

ALter table employees
Add personalemail varchar(30)

--Insert into employees(DOB, officialemail, personalemail) values
--('12-03-2004', 'sahilmern@gmail.com', 'sahilpatel@gmail.com'),
--('08-21-2001', 'mitenreact@gmail.com', 'mitenpatel23@gmail.com'),
--('04-25-2003', 'sohamnodejs@gmail.com', 'sohamptl18@gmail.com'),
--('11-17-2002', 'ritenmlai@gmail.com', 'ri10@gmail.com'),

UPDATE employees
SET DOB = '2004-03-12',
    officialemail = 'sahilmern@gmail.com',
    personalemail = 'sahilpatel@gmail.com'
WHERE EID = '1';


UPDATE employees
SET DOB = '2001-08-21',
    officialemail = 'mitenreact@gmail.com',
    personalemail = 'mitenpatel23@gmail.com'
WHERE EID = '2';


UPDATE employees
SET DOB = '2003-10-07',
    officialemail = 'sohamnodejs@gmail.com',
    personalemail = 'sohamptl18@gmail.com'
WHERE EID = '3';


UPDATE employees
SET DOB = '2002-10-17',
    officialemail = 'ritenmlai@gmail.com',
    personalemail = 'ritenpatel@gmail.com'
WHERE EID = '4';



Select * from employees

--drop index employees.IX_Eid
--Delete from employees where DOB IS NOT NULL


select e1.eid, e1.ename, e1.department from employees e1
join employees e2
on e1.department = e2.department
where e1.eid <> e2.eid
