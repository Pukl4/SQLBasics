USE University;
GO

-- create Student table
CREATE TABLE Students (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(25) NOT NULL, 
    LastName NVARCHAR(25) NOT NULL, 
	FullName NVARCHAR(50) NULL, -- add an new column for full names
    Email NVARCHAR(25), 
    PhoneNumber NVARCHAR(25), 
    AverageGrade FLOAT,
	FacultyId INT NULL
);
GO

-- create a column automation trigger
-- this trigger combines FirstName and LastName into FullName
CREATE TRIGGER tr_Student_FullName_InsertUpdate
	ON Students -- table name
	AFTER INSERT, UPDATE ---- trigger type and target events
AS
BEGIN
	SET NOCOUNT ON -- disables "1 row affected" messages from being returned for every operation

	--declare input parameters
	DECLARE @FirstName NVARCHAR(25);
	DECLARE @LastName NVARCHAR(25);
	DECLARE @Id INT;

	SELECT
		-- get new inserted or updated names
		@FirstName = inserted.FirstName,
		@LastName = inserted.LastName,
		@Id = inserted.Id -- get the id of the student record that was updated
	FROM inserted; -- inserted system table stores copies of the new or changed rows after an INSERT or UPDATE statement

	UPDATE Students
	SET FullName = CONCAT(@FirstName,' ', @LastName)
	WHERE @Id = Id;
END;

-- remove trigger if exists
DROP TRIGGER IF EXISTS tr_Student_FullName_InsertUpdate;
GO

-- create a trigger that removes accidental whitespaces from column values
-- examples: 'Nick ' => 'Nick', '  Nick' => 'Nick'
CREATE TRIGGER tr_Student_Trim_InsertUpdate
	ON Students
	INSTEAD OF INSERT, UPDATE -- instead overrides the original operation allowing to implement validation and other
AS
BEGIN
	SET NOCOUNT ON -- prevents the “1 row affected” messages from being returned for every operation

	DECLARE @FirstName NVARCHAR(25);
	DECLARE @LastName NVARCHAR(25);
	DECLARE @Id int;
	
	SELECT
		-- get new inserted or updated names
		@FirstName = inserted.FirstName,
		@LastName = inserted.LastName,
		@Id = inserted.Id
	FROM inserted; 

	UPDATE Students
	SET 
		FirstName = TRIM(@FirstName), -- TRIM() removes the space character or other specified characters from the start or end of a string
		LastName = TRIM(@LastName)
	WHERE Id = @Id;
END;

-- create a trigger that does not allow to insert student with faculty ids that does not exist in the Faculty table
CREATE TRIGGER tr_Student_ValidateFaculty_InsertUpdate
	ON Students
	AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @FacultyId INT;
	DECLARE @Id INT;
	
	-- get the faculty id of a newely inserted or updated student
	SELECT
		@FacultyId = inserted.FacultyId
	FROM inserted; 

	-- SELECT TOP 1 1 is an efficient way to check if a record exists while selection minimal information
	-- SELECT TOP 1 1 means if the condition is true and any rows are returned from the select,
	-- only return top 1 row and only return integer 1 for the row
	IF NOT EXISTS(SELECT TOP 1 1 FROM Faculties WHERE Id = @FacultyId)
	BEGIN
		-- if a given faculty does not exist throw an error and revert the INSERT/UPDATE operation
		RAISERROR ('Non-existing FacultyId provided', 16, 1);
		ROLLBACK TRANSACTION; -- erases all data modifications made from the start of the transaction or to a savepoint
	END		
END;