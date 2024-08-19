USE University;
GO

-- left join: all records from the left(first) table with all the matched records from the right table
SELECT * FROM Students
--                       this is left       this is right
LEFT JOIN Faculties ON Students.FacultyId = Faculties.Id;

-- right join: all records from the right(second) table with all the matched records from the left table
SELECT * FROM Students
--                       this is left        this is right
RIGHT JOIN Faculties ON Students.FacultyId = Faculties.Id;

-- inner join: all records that have matching values in both tables
SELECT * FROM Students
INNER JOIN Faculties ON Students.FacultyId = Faculties.Id;

-- full join: all records when there is a match in either left or right table
SELECT * FROM Students
FULL JOIN Faculties ON Students.FacultyId = Faculties.Id

-- cross join: each row from the 1st table with all the rows of another table
SELECT * FROM Students
CROSS JOIN Faculties;

-- syntax features

-- use short local table names: st - Students, fc - Faculties
SELECT * FROM Students st
INNER JOIN Faculties fc ON st.FacultyId = fc.Id;

-- you can also use short local table names in the select statement
SELECT st.FirstName, fc.Description FROM Students st
INNER JOIN Faculties fc ON st.FacultyId = fc.Id;

-- use table column aliases when you want to make them more informative
SELECT st.Id, st.FirstName, st.LastName, fc.Name AS 'FacultyName', fc.Description AS 'FacultyDescription'
FROM Students st
INNER JOIN Faculties fc ON st.FacultyId = fc.Id;