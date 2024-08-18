USE University;
GO

-- view is a saved query with a name, works just as a method
-- create a view that returns only students with the average grade greater than 7
CREATE VIEW ExcellentGradeStudents
AS
	SELECT * FROM Students
	WHERE AverageGrade > 7;
GO

-- now we can reuse this view without having to write it again
SELECT * FROM ExcellentGradeStudents;

-- we can even query it as a table
SELECT FirstName, LastName
FROM ExcellentGradeStudents
WHERE FacultyId = 3;


-- group students by their FacultyIds and counting how many students per faculty
SELECT FacultyId, COUNT(Id) AS 'StudentCount'   -- we can also use other aggregation methods, like SUM(), MAX(), AVG()
	FROM Students
-- the column that is used for grouping (FacultyId) should be always included in the SELECT statement.
-- If not included the query will result in an error
GROUP BY FacultyId;

-- group students by their FacultyIds while connecting two tables
-- and counting how many students per faculty
SELECT fc.Name AS 'FacultyName', COUNT(st.Id) AS 'StudentCount'
	-- the following FROM - WHERE combination works like a JOIN
	-- and establishes a relation between Students and Faculties
	FROM Students st, Faculties fc
	WHERE st.FacultyId = fc.Id
GROUP BY fc.Name;

-- group students by their FacultyId while connecting two tables
-- and counting average grade per faculty
SELECT fc.Name AS 'FacultyName', AVG(st.AverageGrade) AS 'AverageGrade'
	FROM Students st, Faculties fc
	WHERE st.FacultyId = fc.Id
GROUP BY fc.Name;

-- the same as previous but only take the faculties where average grade is greater than 8
SELECT fc.Name AS 'FacultyName', AVG(st.AverageGrade) AS 'AverageGrade'
	FROM Students st, Faculties fc
	WHERE st.FacultyId = fc.Id
GROUP BY fc.Name 
-- HAVING statements is like WHERE but can be used to filter groups (after GROUP BY)
HAVING AVG(st.AverageGrade) > 8;

