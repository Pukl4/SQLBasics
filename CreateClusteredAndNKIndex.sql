USE University;
GO

-- create Students table with a primary key
CREATE TABLE Students (
	Id INT PRIMARY KEY IDENTITY(1,1), -- automatically creates a clusteded index on Id with ASC sorting 
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	Email NVARCHAR(20),
	PhoneNumber NVARCHAR(25),
	AverageGrade FLOAT,
	FacultyId INT NULL
);
GO

-- create Students table without a primary key
CREATE TABLE Students (
	Id INT IDENTITY(1,1), -- just an identity column, not a primary key
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	Email NVARCHAR(20),
	PhoneNumber NVARCHAR(25),
	AverageGrade FLOAT,
	FacultyId INT NULL
);
GO

-- manually create a clustered index on the primary key column
CREATE CLUSTERED INDEX PK_Student ON Students (Id ASC); -- ASC sorting option
GO

-- a better way to manually create a clustered index on the primary key column
ALTER TABLE Students
ADD CONSTRAINT PK_Student PRIMARY KEY CLUSTERED (Id);
GO

-- remove the index
DROP INDEX IF EXISTS PK_Student ON Students;
GO

-- create a non-clustered index on the last name column
CREATE NONCLUSTERED INDEX NK_Student ON Students (LastName);

-- create a non-clustered with ordering
CREATE NONCLUSTERED INDEX NK_Student ON Students (LastName ASC); -- optional sorting argument

-- remove the index
DROP INDEX IF EXISTS NK_Student ON Students;
GO