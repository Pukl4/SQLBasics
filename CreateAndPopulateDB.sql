-- tell the database engine to run commands against the master database
USE master;
GO

-- create a new Students database
CREATE DATABASE Students;
GO

-- tell the database engine to run commands against the master database
USE Students;
GO

-- create Student table
CREATE TABLE Student (
	Id INT PRIMARY KEY IDENTITY(1,1), -- a primary key that is populated automatically by database engine
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	Email NVARCHAR(20),
	PhoneNumber NVARCHAR(25),
	GradePointAverage float,
	FacultyID INT NULL -- a foreign key to relate Student to Faculty table
);
GO

-- populate Students table
INSERT INTO Student
VALUES 
	('Nick', 'Smith', 'n.f@protonmail.edu', '375-29-222-00-74', 8.5, 1),
	('Sally', 'Cage', 'el@google.couk', '375-44-333-25-23', 5.7, 2),
	('George', 'Jones', 'd.m@yahoo.net', '375-25-252-01-24', 7.5, 2),
	('Rick', 'Davis', 'sit@yahoo.couk', '375-29-412-00-42', 7.8, 3),
	-- the last student does not have a department id so there would be a noticable difference when practicing JOINs
	('Erich', 'Miller', 'u.p.c@aol.net', '375-44-122-20-17', 4.9, NULL);
GO

--create Faculty table
CREATE TABLE Faculty (
	Id INT PRIMARY KEY IDENTITY(1,1), -- a primary key that is populated automatically by the database engine
	Name NVARCHAR(20) NOT NULL,
	Description nvarchar(30) null
);
GO

--populate Faculty table
INSERT INTO Faculty
VALUES
	('Engineering', 'Faculty of Engineering'),
	('Economics', 'Faculty of Economics'),
	('Law', 'Faculty of Law');
GO