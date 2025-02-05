
-- -- SELECT * FROM student;

-- Create the student table
CREATE TABLE student (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    city VARCHAR(50)
);

-- Insert 10 entries into the student table
INSERT INTO student (id, name, age, city) VALUES (1, 'Alice', 20, 'New York');
INSERT INTO student (id, name, age, city) VALUES (2, 'Bob', 22, 'Los Angeles');
INSERT INTO student (id, name, age, city) VALUES (3, 'Charlie', 19, 'Chicago');
INSERT INTO student (id, name, age, city) VALUES (4, 'Diana', 21, 'Houston');
INSERT INTO student (id, name, age, city) VALUES (5, 'Ethan', 23, 'Phoenix');
INSERT INTO student (id, name, age, city) VALUES (6, 'Fiona', 20, 'Philadelphia');
INSERT INTO student (id, name, age, city) VALUES (7, 'George', 22, 'San Antonio');
INSERT INTO student (id, name, age, city) VALUES (8, 'Hannah', 18, 'San Diego');
INSERT INTO student (id, name, age, city) VALUES (9, 'Ivan', 24, 'Dallas');
INSERT INTO student (id, name, age, city) VALUES (10, 'Julia', 21, 'San Jose');

SELECT *
FROM student;

-- ==
BEGIN TRANSCACTION mng_std; -- correct for SQL server, but in MySQL we don't assign name to transaction

-- -- In MySQL, transaction starts with two ways
-- -- START TRANSACTION;
-- -- BEGIN; (No TRANSACTION keyword even required.)

-- ==
START TRANSACTION;
INSERT INTO student (id, name, age, city) VALUES (11, 'Nimra', 22, 'Lahore');
DELETE FROM student
WHERE age = 20;
COMMIT;

-- == Below TRANSACTION has no COMMIT. So conceptually, data should not be stored in the database. 
-- But here, data is stored. Because by default, many databases like MySQL run in autocommit mode, which means each statement is committed automatically unless you explicitly disable it.
START TRANSACTION;
DELETE FROM student
WHERE age = 22;

-- ==
-- Data not stored in table due to ROLLBACK;
START TRANSACTION;
INSERT INTO student (id, name, age, city) VALUES (13, 'Zainab', 12, 'Lahore');
ROLLBACK;

START TRANSACTION;
INSERT INTO student (id, name, age, city) VALUES (15, 'Zainab', 12, 'Lahore');
DELETE FROM student
WHERE name = 'Ivan';
ROLLBACK;

-- ==
START TRANSACTION;
SAVEPOINT SP1;
INSERT INTO student (id, name, age, city) VALUES (15, 'Zainab', 12, 'Lahore');
SAVEPOINT SP2;
DELETE FROM student
WHERE name = 'Ivan';
ROLLBACK TO SP2;

-- ==
START TRANSACTION;
SAVEPOINT SP2;
DELETE FROM student
WHERE name = 'Ivan';
RELEASE SAVEPOINT SP2;
ROLLBACK TO SP2;