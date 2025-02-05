-- Active: 1733556663515@@127.0.0.1@3306@studentmgmt
SHOW DATABASES;
USE studentmgmt;
SHOW TABLES;


-- TASK 1:
-- Create the following table using SQL and using the INSERT INTO command, insert the
-- following values in the table created
CREATE TABLE StudentCourse(
	Name VARCHAR(255),
	Reg_No INT AUTO_INCREMENT UNIQUE,
	Courses VARCHAR(255),
	Course_Code INT,
	Offered_by VARCHAR(255)
);

INSERT INTO studentcourse
VALUES
('Ali', NULL, 'DIP', 1001, 'Mr.A'),
('Basit', NULL, 'DBMS', 1002, 'Mr.X'),
('Akram', NULL, 'OS', 1003, 'Mr.Y'),
('Asad', NULL, 'DBMS', 1002, 'Mr.X'),
('Zeeshgam', NULL, 'DIP', 1001, 'Mr.A'),
('Muneer', NULL, 'OS', 1003, 'Mr.Y'),
('Shafqat', NULL, 'NM', 1004, 'Mr.H'),
('Ahsan', NULL, 'OS', 1003, 'Mr.Y'),
('Ikram', NULL, 'DIP', NULL, NULL),
('Hassan', NULL, NULL, NULL, NULL);

SELECT * FROM studentcourse;


-- TASK 2:
-- Using the UPDATE statement, update the above table for the following values
UPDATE studentcourse
SET `Course_Code` = 1001, `Offered_by` = 'Mr.A'
WHERE `Reg_No` = 9 AND `Name` = 'Ikram';

UPDATE studentcourse
SET `Courses`='DIP', `Course_Code` = 1005, `Offered_by` = 'Mr.Z'
WHERE `Reg_No` = 10 AND `Name` = 'Hassan';


-- TASK 5:
-- For the table in task 2, generate a query for updating the table with fully qualified names and
-- update the following values:
UPDATE studentcourse
SET `Courses`='SE', `Offered_by`='Mr.Z'
WHERE `Name`='Ali';

UPDATE studentcourse
SET `Courses`='CG', `Offered_by`='Mr.X'
WHERE `Name`='Basit';


-- TASK 3:
-- Using the DELETE statement, delete the record for the student having name Akram and
-- Ahsan in the above table. Also delete the record for the course having course code=1001.

DELETE FROM studentcourse
WHERE `Name` = 'Akram' OR `Name`='Ahsan' OR `Course_Code` = 1001;


-- TASK 4:
-- Select distinct values from the above table for the last three columns.
SELECT DISTINCT Courses, Course_Code, Offered_by
FROM studentcourse;


