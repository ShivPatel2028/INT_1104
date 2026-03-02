
-- Create Database
CREATE DATABASE ShivBhaveshPatel_INT_1104;
GO

USE ShivBhaveshPatel_INT_1104;
GO
/* =========================
   1. Specializations Table
   ========================= */
CREATE TABLE Specializations (
    SpecializationID INT IDENTITY(1,1) PRIMARY KEY,
    SpecializationName VARCHAR(100) NOT NULL UNIQUE
);


/* =========================
   2. Students Table
   ========================= */
CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INT NOT NULL CHECK (Age BETWEEN 17 AND 30),
    SpecializationID INT NOT NULL,
    
    CONSTRAINT FK_Students_Specializations
        FOREIGN KEY (SpecializationID)
        REFERENCES Specializations(SpecializationID)
        ON DELETE CASCADE
);


/* =========================
   3. Courses Table
   ========================= */
CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL UNIQUE,
    Credits INT NOT NULL CHECK (Credits BETWEEN 1 AND 3)
);


/* =========================
   4. Enrollments Table
   ========================= */
CREATE TABLE Enrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    Grade CHAR(1) CHECK (Grade IN ('A','B','C')),
    
    CONSTRAINT FK_Enrollments_Students
        FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID)
        ON DELETE CASCADE,
        
    CONSTRAINT FK_Enrollments_Courses
        FOREIGN KEY (CourseID)
        REFERENCES Courses(CourseID)
        ON DELETE CASCADE,

    CONSTRAINT UQ_Student_Course UNIQUE (StudentID, CourseID)
);


/* =========================
   Insert Specializations
   ========================= */
INSERT INTO Specializations (SpecializationName)
VALUES 
('Full Stack Development'),
('Data Analytics'),
('Cyber Security'),
('Cloud Computing');


/* =========================
   Insert Courses
   ========================= */
INSERT INTO Courses (CourseName, Credits)
VALUES
('Full Stack', 3),
('Data Analytics', 3),
('Cyber Security Fundamentals', 2),
('Cloud Architecture', 2),
('Database Management', 3);


/* =========================
   Insert Students
   ========================= */
INSERT INTO Students (FirstName, LastName, Age, SpecializationID)
VALUES
('Suresh', 'Patel', 21, 1),
('Ananya', 'Sharma', 20, 2),
('Rahul', 'Verma', 22, 1),
('Priya', 'Reddy', 19, 3),
('Arjun', 'Mehta', 23, 4),
('Sneha', 'Iyer', 20, 2),
('Vikram', 'Singh', 24, 3),
('Neha', 'Gupta', 18, 1),
('Rohit', 'Nair', 22, 4);

-- Your Record
('Shiv Bhavesh', 'Patel', 22, 1);


/* =========================
   Insert Enrollments
   ========================= */
INSERT INTO Enrollments (StudentID, CourseID, Grade)
VALUES
(1, 1, 'A'),
(1, 5, 'B'),
(2, 2, 'A'),
(3, 1, 'B'),
(3, 5, 'A'),
(4, 3, 'C'),
(5, 4, 'B'),
(6, 2, 'A'),
(7, 3, 'B'),
(8, 1, 'A'),
(9, 4, 'C'),
(10, 2, 'B'),
(11, 1, 'A'),
(11, 5, 'A');


/* =========================
   Verification Queries
   ========================= */

SELECT * FROM Specializations;
SELECT * FROM Courses;
SELECT * FROM Students;
SELECT * FROM Enrollments;