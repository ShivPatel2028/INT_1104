--1

CREATE TRIGGER trg_AfterInsert
ON Employees
AFTER INSERT
AS
BEGIN
    INSERT INTO EmployeeLog (EmpID, ActionType)
    SELECT EmpID, 'INSERT'
    FROM inserted;
END;
GO

--2

CREATE TRIGGER trg_PreventLowSalary
ON Employees
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Salary < 10000)
    BEGIN
        RAISERROR('Salary cannot be less than 10000',16,1);
        ROLLBACK TRANSACTION;
    END
END;
GO

--3

CREATE TRIGGER trg_AfterDelete
ON Employees
AFTER DELETE
AS
BEGIN
    INSERT INTO EmployeeLog (EmpID, ActionType)
    SELECT EmpID, 'DELETE'
    FROM deleted;
END;
GO

--4

ALTER TABLE Employees
ENABLE TRIGGER trg_AfterInsert;
GO

--5

ALTER TABLE Employees
ENABLE TRIGGER trg_AfterInsert;
GO

--6

DROP TRIGGER trg_AfterInsert;
GO

--7

CREATE TRIGGER trg_PreventManagerDelete
ON Employees
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM deleted WHERE Role = 'Manager')
    BEGIN
        RAISERROR('Manager cannot be deleted',16,1);
        RETURN;
    END

    DELETE FROM Employees
    WHERE EmpID IN (SELECT EmpID FROM deleted);
END;
GO

--8

CREATE TRIGGER trg_PreventDuplicateEmail
ON Employees
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT i.Email
        FROM inserted i
        JOIN Employees e ON i.Email = e.Email
    )
    BEGIN
        RAISERROR('Duplicate Email Not Allowed',16,1);
        RETURN;
    END

    INSERT INTO Employees (EmpID, EmpName, Email, Salary, Role)
    SELECT EmpID, EmpName, Email, Salary, Role
    FROM inserted;
END;
GO

--9

SELECT name
FROM sys.triggers
WHERE parent_id = OBJECT_ID('Employees');
GO

--10

CREATE TRIGGER trg_PreventPKUpdate
ON Employees
AFTER UPDATE
AS
BEGIN
    IF UPDATE(EmpID)
    BEGIN
        RAISERROR('Primary Key cannot be updated',16,1);
        ROLLBACK TRANSACTION;
    END
END;
GO

--11

CREATE TRIGGER trg_PreventTableDrop
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    RAISERROR('Dropping tables is not allowed',16,1);
    ROLLBACK;
END;
GO

--12

CREATE TRIGGER trg_LogDeletedEmployee
ON Employees
AFTER DELETE
AS
BEGIN
    INSERT INTO EmployeeLog (EmpID, ActionType)
    SELECT EmpID, 'DETAILED DELETE'
    FROM deleted;
END;
GO

--13

CREATE TRIGGER trg_PreventNegativeStock
ON Products
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Stock < 0)
    BEGIN
        RAISERROR('Stock cannot be negative',16,1);
        ROLLBACK TRANSACTION;
    END
END;
GO

--14

CREATE TRIGGER trg_PreventNegativeSalary
ON Employees
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Salary < 0)
    BEGIN
        RAISERROR('Salary cannot be negative',16,1);
        ROLLBACK TRANSACTION;
    END
END;
GO

--15

ALTER TABLE Employees
DISABLE TRIGGER ALL;
GO