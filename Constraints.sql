USE University;
GO

-- create a value constraint of Students table
-- we have to use alter since we are changing the table schema
ALTER TABLE Students
--						  constraint name (CHK - convention for constraints that just check values)
WITH CHECK ADD CONSTRAINT CHK_FacultyIdValid
-- check if the FacultyId values being inserted or updated are equal to 1, 2 or 3, if not - statement will be terminated
CHECK (([FacultyId]=1 OR [FacultyId]=2 OR [FacultyId]=3))
GO

-- create a foreign key constraint that will check if the FacultyId values being inserted or updated
-- exist in the Faculties table (will only allow to use existing Faculties)

-- in order for this constraint to work we have to first drop the existing Students table
-- and create a new one where FacultyId column does not accept nulls because the constraint
-- is not going to be able to check NULLs - we cannot compare a NULL (nothing) to a real value
DROP TABLE IF EXISTS Students;

-- create new Students table
CREATE TABLE Students (
	Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	Email NVARCHAR(20),
	PhoneNumber NVARCHAR(25),
	AverageGrade FLOAT,
	FacultyId INT NOT NULL -- does not accept NULLs
);
GO

-- then we can run the following command
ALTER TABLE Students
--						  constraint name (FK - convention for constraints on foreign key checks)
WITH CHECK ADD CONSTRAINT FK_Students_Faculties
-- FacultyId - foreign key from the Students table
-- Id - primary key from the Faculties table
FOREIGN KEY (FacultyId) REFERENCES Faculties (Id)
GO