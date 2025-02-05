-- Note: SQL is not case sensitive. 'CREATE' is same as 'create'.
-- 'SELECT' is same as 'select'.


CREATE database StudentMgmt;
SHOW DATABASES;
USE studentmgmt;

CREATE TABLE Student(
	id INT AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR(255),
	Reg_No VARCHAR(255),
	Courses VARCHAR(255),
	Course_Code INT,
	Offered_by VARCHAR(255)
);

SHOW TABLES;

SELECT * FROM Student;

-- INSERTING DATA (One way, specifying column names)
INSERT INTO Student(Name, Reg_No, Courses, Course_Code, Offered_by)
VALUES('Nimra', '2345', 'Science', 1234, 'Govt.');

-- INSERTING DATA (Second way, not specifying column names)
-- Assigning DEFAULT to id, when columns not explicitly defined in query
INSERT INTO Student
VALUES(DEFAULT, 'Kaneez', '2345', 'Science', 1234, 'Govt.');

-- If value for id is provided explicitly, then it will not be AUTO_INCREMENTED
INSERT INTO Student
VALUES(15, 'Kaneez', '2345', 'Science', 1234, 'Govt.');

-- Now AUTO_INCREMENTED value would be 16(15 + 1), Not 3
INSERT INTO Student
VALUES(DEFAULT, 'Zainab', '2345', 'Science', 1234, 'Govt.');

-- Assigning NULL to id, when columns not explicitly defined in query
-- But it will again be AUTO_INCREMENTED (16 + 1)
INSERT INTO Student
VALUES(NULL, 'Ali', '2345', 'Science', 1234, 'Govt.');

-- INSERT Data in specified Columns
INSERT INTO Student(Name, Reg_No)
VALUES('jknk', '8906');


-- UPDATE
UPDATE Student
SET Name = 'Aliya', Reg_No = '11'
WHERE Name = 'Ali' AND Courses = 'Science'; 

-- ERROR
-- The error you're encountering occurs because MySQL's safe update mode is enabled. 
-- Safe update mode is a feature in MySQL Workbench designed to prevent potentially 
-- dangerous updates or deletions without specifying a condition involving a key column 
-- (e.g., PRIMARY KEY or UNIQUE column). In your case, the WHERE clause does not include a key column, and this triggers the error.

SELECT * FROM Student;

-- Solution 1(Enabling the safe update mode):
-- disable safe update mode for your current session
SET SQL_SAFE_UPDATES = 0;	
-- Make Updations
UPDATE Student
SET Name = 'Aliya', Reg_No = '11'
WHERE Name = 'Ali' AND Courses = 'Science'; 
-- re-enable safe update mode (optional)
SET SQL_SAFE_UPDATES = 0;

-- Solution 2(Modify the Query to Include a Key Column):
-- If the table has a PRIMARY KEY or UNIQUE column, 
-- you can include it in the WHERE clause.
UPDATE Student
SET Name = 'Aliya', Reg_No = '11'
WHERE id = 1;


-- SQL UPDATE Warning
--  If we had omitted the WHERE clause, whole table will be updated
UPDATE Student
SET Courses = 'GK';

-- Trying to update Primary key
-- Successfully updated
UPDATE Student
SET id = 5
WHERE id = 1 AND Name = 'Aliya';

-- Two records can't have the same primary key(also updated primary key)
UPDATE Student
SET id = 5
WHERE id = 15 AND Name = 'Kaneez';


-- DELETE Statement
DELETE FROM Student
WHERE id = 15 AND Name = 'Kaneez';

-- DELETE Statement Warning
-- If you omit the WHERE clause, all records will be deleted!
-- e.g. DELETE FROM Student

-- Delete all rows without deleting the table (following 2 ways):
-- DELETE FROM Student
-- DELETE * FROM Student


-- SELECT Statement
-- The SELECT statement is used to select data from a database.The result is stored in a result
-- table, called the result-set.
-- The syntax used for SELECT query is:
	-- SELECT column_name(s)
	-- FROM table_name
-- and
	-- SELECT * FROM table_name

-- Without WHERE Clause
-- specific columns
SELECT id, Name, Courses
FROM Student;
-- all columns
SELECT * FROM Student;


-- SELECT DISTINCT Statement
-- In a table, some of the columns may contain duplicate values. This is not a problem,
-- however, sometimes you will want to list only the different (distinct) values in a table.
-- The DISTINCT keyword can be used to return only distinct (different) values.
-- Its Syntax is:
-- SELECT DISTINCT column_name(s)  FROM table_name

SELECT DISTINCT Reg_No 
FROM Student;

-- Distinct record based on Name and Reg_No
SELECT DISTINCT Name, Reg_No
FROM Student;

SELECT Name, Reg_No
FROM Student;

SELECT DISTINCT Name, Reg_No, id
FROM Student;


-- WHERE clause
-- The WHERE clause is used to extract only those records that fulfill a specified criterion. The
-- syntax of the command is:
-- SELECT column_name(s)
-- FROM table_name
-- WHERE column_name operator value

SELECT * FROM Student
WHERE Name = 'Aliya';

-- There are many different operators allowred in WHERE clause

-- Quotes around Text Fields
-- SQL uses single quotes around text values
-- Although, numeric values should not be enclosed in quotes

-- For text values:
-- This is correct:
-- SELECT * FROM Persons WHERE FirstName='Tove'
-- This is wrong:
-- SELECT * FROM Persons WHERE FirstName=Tove

-- For numeric values:
-- This is correct:
-- SELECT * FROM Persons WHERE Year=1965
-- This is wrong:
-- SELECT * FROM Persons WHERE Year='1965'


