USE University;
GO

-- create Students table without a primary key
CREATE TABLE Students (
	Id INT IDENTITY(1,1), 
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	Email NVARCHAR(20),
	PhoneNumber NVARCHAR(25),
	AverageGrade FLOAT,
	FacultyId INT NULL
);
GO

-- manually create 2 indexes
CREATE CLUSTERED INDEX PK_Student ON Students (Id ASC);
CREATE NONCLUSTERED INDEX NK_Students on Students (LastName);

SELECT * FROM Students
WITH(INDEX(NK_Students)) -- hint to the database which index to use
WHERE LastName = 'Smith';

-- create a function that returns faculty names by student ids
CREATE FUNCTION fk_GetFacultyName
(
	-- define input arguments with the @ character
	@StudentId INT
)
-- define the output type
RETURNS NVARCHAR(20)
AS
-- BEGIN / END to indicate the function body
BEGIN
	DECLARE @FacultyName NVARCHAR(20);
	DECLARE @FacultyId INT;

	-- get student faculty id
	SELECT @FacultyId = st.FacultyId
	FROM Students st
	WHERE Id = @StudentId;

	-- get faculty name by id
	SELECT @facultyName = fc.Name
	FROM Faculties fc
	WHERE Id = @FacultyId;
	
	-- returns the result
	RETURN @FacultyName;
END;
GO

-- execute the function
DECLARE @Name NVARCHAR(20);
EXEC @Name = fk_GetFacultyName 1; -- returns NULL if FacultyId is NULL or if StudentId is wrong
SELECT @Name AS 'FacultyName';
