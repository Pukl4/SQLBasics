USE University;
GO

-- select every record and every column from Students table
-- use the * (called wildcard) selector pattern
SELECT * FROM Students;

-- select a limited amount (2) of the records and every column from Students table
SELECT TOP(2) * FROM Students;

-- select a limited percentage (25%) of the records and every column from Students table
SELECT TOP 25 PERCENT * FROM Students;

-- select every record but only specific columns from Students table
SELECT AverageGrade, Email FROM Students;
SELECT Description FROM Faculties;

-- select every record that follows a certain condition from Students table
SELECT * FROM Students
WHERE FirstName = 'Nick';

-- we can define comparison patterns for strings by using LIKE command ( commmand is not case sensitive )
-- 'R%' means starts with R
-- '%R' means ends with R
-- '%R%' means has R anywhere
SELECT * FROM Faculties
WHERE Name LIKE '%G%';

-- use multiple conditions
SELECT * FROM Students
WHERE FirstName LIKE '%I%' AND AverageGrade > 6;
-- we can use OR as well
SELECT * FROM Students
WHERE AverageGrade > 8 OR AverageGrade < 5;

-- use a collection of values
SELECT * FROM Students
WHERE Id IN (1, 2, 3);

-- order result records (descending)
SELECT * FROM Students
ORDER BY LastName DESC;

-- order result records (ascending) 
SELECT * FROM Students
ORDER BY LastName ASC;
-- if not specified, it is ascending by default
SELECT * FROM Students
WHERE AverageGrade > 6
ORDER BY LastName;

-- use a subquery in a WHERE statement
SELECT * FROM Students
WHERE FacultyId = (SELECT Id FROM Faculties WHERE Name = 'Law');