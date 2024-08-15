USE University;
GO

-- update a single record in the Students table
UPDATE Students
SET
	FirstName = 'Rick',
	LastName = 'Miles'
WHERE Id = 1;

-- multiple conditions
UPDATE Students 
SET 
	FirstName = 'Nick',
	LastName = 'Smith'
WHERE Id = 1 AND AverageGrade > 5;

-- update by multiple ids
UPDATE Students
SET 
	AverageGrade = 6
WHERE Id IN (1, 2, 3);

-- update all (if conditions are not specified) 
UPDATE Students
SET
	AverageGrade = 4;

-- delete a single record from Employees table
DELETE FROM Students
WHERE Id = 1;

-- multiple conditions
DELETE FROM Students
WHERE Id = 1 OR Id > 3;

-- delete by multiple ids
DELETE FROM Students
WHERE Id IN (1, 2);

-- delete all (if conditions are not specified) 
DELETE FROM Students;