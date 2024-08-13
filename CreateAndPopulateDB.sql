-- tell the database engine to run commands against the master database
USE master;
GO

-- create a new University database
CREATE DATABASE University;
GO

-- tell the database engine to run commands against the master database
USE University;
GO

-- create Students table
CREATE TABLE Students (
	Id INT PRIMARY KEY IDENTITY(1,1), -- a primary key that is populated automatically by database engine
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	Email NVARCHAR(20),
	PhoneNumber NVARCHAR(25),
	AverageGrade FLOAT,
	FacultyId INT -- a foreign key to relate Student to Faculty table
);
GO

-- populate Students table
INSERT INTO Students
VALUES 
	('Nick', 'Smith', 'n.f@protonmail.edu', ' 123-45-111-22-33', 8.5, 1),
	('Sally', 'Cage', 'el@google.couk', '222-11-333-23-23', 5.7, 2),
	('George', 'Jones', 'd.m@yahoo.net', '111-22-123-22-11', 7.5, 2),
	('Rick', 'Davis', 'sit@yahoo.couk', '333-33-222-11-00', 7.8, 3),
	-- the last student does not have a faculty id so there would be a noticable difference when practicing JOINs
	('Erich', 'Miller', 'u.p.c@aol.net', '321-12-122-33-22', 4.9, NULL);
GO

--create Faculties table
CREATE TABLE Faculties (
	Id INT PRIMARY KEY IDENTITY(1,1), -- a primary key that is populated automatically by the database engine
	Name NVARCHAR(20) NOT NULL,
	Description NVARCHAR(30)
);
GO

--populate Faculties table
INSERT INTO Faculties
VALUES
	('Engineering', 'Faculty of Engineering'),
	('Economics', 'Faculty of Economics'),
	('Law', 'Faculty of Law');
GO