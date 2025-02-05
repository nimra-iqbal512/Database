-- TASK 1:
-- Create a new table Student which have the following schema Student( RegNo: String, FirstName: String, LastName: String, GPA: Float, Contact: Integer) 

CREATE TABLE Student(
	RegNo VARCHAR(15),
	FirstName VARCHAR(20),
	LastName VARCHAR(20),
	GPA FLOAT,
	Contact VARCHAR(11)
);

ALTER TABLE student
ADD PRIMARY KEY (RegNO);


-- TASK 2:
-- Add at least 5 records of your own class in which one or two students have GPA undefined. 
INSERT INTO student
VALUES
('1', 'Nimra', 'Iqbal', 3.5, '12345'),
('2', 'Ashmal', 'Zahra', 3.7, '12345'),
('3', 'Ayesha', 'Sharif', 3.9, '12345'),
('4', 'Zain', 'Ali', NULL, '12345'),
('5', 'Hira', 'Amanat', 3.2, '12345');


-- TASK 3:
-- Display all the data from the table Student 
SELECT * FROM student;


-- TASK 4:
-- Display specific columns form the table Student 
SELECT RegNo, GPA 
FROM student;


-- TASK 5:
-- Display all the data of students where GPA > 3.5 
SELECT *
FROM student
WHERE GPA > 3.5;


-- TASK 6:
-- Display all the data of students where GPA <= 3.5 
SELECT *
FROM student
WHERE GPA <= 3.5;


-- TASK 7:
-- Does the above 2 queries covers all the data? 
-- No, students with GPA NULL are not displayed.
SELECT *
FROM student
WHERE GPA IS NULL;

-- TASK 8:
-- Display first and last name of all students as single column using concatenation operator “||”. 

SELECT CONCAT(FirstName, ' ', LastName) as fullName
FROM student;


-- TASK 9:
-- Your task is to write SQL statements corresponding to each operator.

-- Logical Operators
-- AND: Students with GPA > 3.5 and a contact number starting with '1'.
SELECT *
FROM student
WHERE GPA > 3.5 AND Contact LIKE '1%';

-- OR: Students with GPA ≤ 3.5 or no GPA defined (NULL).
SELECT *
FROM student
WHERE GPA <= 3.5 OR GPA IS NULL;

-- NOT: Students who do not have a GPA defined.
SELECT *
FROM student
WHERE NOT GPA IS NOT NULL;

-- Comparison Operators
-- Equal to (=): Students with exactly 3.7 GPA.
SELECT *
FROM student
WHERE GPA BETWEEN 3.69 AND 3.71;
-- WHERE GPA BETWEEN 3.70; (give no results because of the way FLOAT (or DOUBLE) values are handled in SQL databases. These data types often store numbers with more precision than expected, so a value like 3.7 might actually be stored as 3.7000001 or something similar, causing equality comparisons to fail.)

-- Greater than (>): Students with GPA greater than 3.2.
SELECT *
FROM student
WHERE GPA > 3.2;

-- Less than or equal to (<=): Students with GPA ≤ 3.0.

SELECT *
FROM student
WHERE GPA <= 3.7;

-- Arithmetic Operators
-- Adding a constant to GPA
SELECT RegNo, GPA, GPA + 1 AS AdjustedGPA
FROM student;

-- Dividing GPA by a constant
SELECT RegNo, GPA, GPA/2 AS AdjustedGPA
FROM student;

-- Arithmetic Operators
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM student;


-- TASK 10:
-- Identify at least one SQL statement in which precedence can affect the result of query. 

-- Query 1:
SELECT *
FROM student
WHERE GPA > 3.5 OR GPA IS NULL AND Contact LIKE '1%';
-- First (GPA IS NULL AND Contact LIKE '1%') is evaluated, then combined with (GPA > 3.5)

-- Query 2:
SELECT *
FROM student
WHERE (GPA > 3.5 OR GPA IS NULL) AND Contact LIKE '1%';
-- First ((GPA > 3.5 OR GPA IS NULL)) is evaluated due to parenthesis, then combined with (Contact LIKE '1%')

-- TASK 11:
-- Identify how the result of a mathematical expression on null value affect the result of a query. 
-- No effect on NULL value
SELECT GPA + 1 AS Result
FROM student;

-- Use COALESCE to handle NULL
SELECT COALESCE(GPA, 0) + 1 AS Result
FROM student;

-- COALESCE(expression1, expression2, ..., expressionN)
-- It checks the expressions in order.
-- The first non-NULL expression is returned.
-- If all expressions are NULL, the result is NULL.


-- TASK 12
-- Use the distinct operator to eliminate the duplicates in your SQL statement. 
SELECT DISTINCT GPA
FROM student;

SELECT DISTINCT CONCAT(FirstName, ' ', LastName)
FROM student;