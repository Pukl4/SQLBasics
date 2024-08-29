USE University;
GO

-- create a stored procedure to add a new student
CREATE PROCEDURE sp_AddStudent  -- stored procedure name  
(
	-- define input arguments with the @ character
	@FirstName NVARCHAR(20),
	@LastName NVARCHAR(20),
	@Email NVARCHAR(20),
	@PhoneNumber NVARCHAR(25),
	@AverageGrade FLOAT,
	@FacultyId INT,
	@Id INT OUTPUT -- outputs the id for the newly created student
)    
AS
-- BEGIN / END to indicate the stored procedure body
BEGIN    
    INSERT INTO Students(FirstName, LastName, Email, PhoneNumber, AverageGrade, FacultyId)    
    VALUES(@FirstName, @LastName, @Email, @PhoneNumber, @AverageGrade, @FacultyId);
	
	SET @Id = SCOPE_IDENTITY() -- returns the last identity value inserted into an identity column in the same scope
    RETURN @Id -- return can be only used to return INT, for others use SELECT
END;

-- execute the stored procedure
DECLARE @NewStudentId INT;
EXEC sp_AddStudent 'NewFirstName', 'NewLastName', 'NewEmail', 'NewPhone', 5.6, 1, @Id = @NewStudentId OUTPUT; 
SELECT @NewStudentId AS 'StudentId';

-- drop a stored procedure
DROP PROCEDURE IF EXISTS sp_AddStudent;
GO

-- select all students: notice no input parameters
CREATE PROCEDURE sp_SelectAllStudents
AS
BEGIN    
    SELECT * FROM Students
END;

-- execute the stored procedure
EXEC sp_SelectAllStudents;
GO

-- delete an student by id 
CREATE PROCEDURE sp_DeleteStudent
(
	@Id INT
)
AS
BEGIN
	DELETE FROM Students
	WHERE Id = @Id
END;

-- execute the stored procedure
EXEC sp_DeleteStudent 1;
GO

-- count students per faculty based on a faculty
-- Note: uses an output parameter
CREATE PROCEDURE sp_GetFacultyStudentCount
(
	@FacultyId INT,
	@Count INT OUTPUT -- indicate @Count as an output parameter
)    
AS
BEGIN    
	-- select student for a given faculty id
    SELECT * FROM Students
	WHERE FacultyId = @FacultyId;

	-- @@ indicates a global database variable
	SELECT @Count = @@ROWCOUNT; -- ROWCOUNT is a system variable that returns the number of rows read by the previous statement
END;

-- execute the stored procedure
DECLARE @StudentCount INT; -- declare a temporary local variable
EXEC sp_GetFacultyStudentCount 2, @Count = @StudentCount OUTPUT; -- set the stored procedure to use @StudentCount as a return variable
SELECT @StudentCount AS 'StudentCount'; -- output @StudentCount with an alias
GO

-- create a procedure that returns faculty names by students ids
-- Note: uses a user-defined function inside
CREATE PROCEDURE sp_GetFacultyName
(
	@StudentId INT,
	@FacultyName NVARCHAR(20) OUTPUT
)    
AS
BEGIN    
	-- executes a function which we implemented earlier
	EXEC @FacultyName = fk_GetFacultyName @StudentId;
	SELECT @FacultyName;
END;

-- execute the stored procedure
DECLARE @Name NVARCHAR(20);
EXEC sp_GetFacultyName 3, @FacultyName = @Name OUTPUT;
SELECT @Name AS 'FacultyName';