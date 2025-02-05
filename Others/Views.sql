-- Create StudentDetails table
CREATE TABLE StudentDetails (
    S_ID INT PRIMARY KEY,
    NAME VARCHAR(255),
    ADDRESS VARCHAR(255)
);

INSERT INTO StudentDetails (S_ID, NAME, ADDRESS)
VALUES
    (1, 'Harsh', 'Kolkata'),
    (2, 'Ashish', 'Durgapur'),
    (3, 'Pratik', 'Delhi'),
    (4, 'Dhanraj', 'Bihar'),
    (5, 'Ram', 'Rajasthan');
    
    
-- Create StudentMarks table
CREATE TABLE StudentMarks (
    ID INT PRIMARY KEY,
    NAME VARCHAR(255),
    Marks INT,
    Age INT
);

INSERT INTO StudentMarks (ID, NAME, Marks, Age)
VALUES
    (1, 'Harsh', 90, 19),
    (2, 'Suresh', 50, 20),
    (3, 'Pratik', 80, 19),
    (4, 'Dhanraj', 95, 21),
    (5, 'Ram', 85, 18);


-- Create View from Single tavle
CREATE VIEW DetailsView AS
SELECT NAME, ADDRESS
FROM StudentDetails
WHERE S_ID < 5;

-- To see data from view
SELECT * FROM DetailsView;


-- Create view from multiple tables
CREATE VIEW MarksView AS
SELECT sd.NAME, sm.Marks
FROM StudentDetails sd, StudentMarks sm
WHERE sd.NAME = sm.NAME;

SELECT * FROM MarksView;


CREATE VIEW MarksView2 AS
SELECT sd.NAME, sm.Marks
FROM StudentDetails sd
JOIN StudentMarks sm
ON sd.NAME = sm.NAME;

SELECT * FROM MarksView2;


-- Create view to get students having marks above than average
CREATE VIEW MarksAboveThanAverage AS
SELECT NAME, Marks 
FROM StudentMarks
WHERE Marks > (
    SELECT AVG(Marks)
    FROM StudentMarks
);

SELECT * 
FROM MarksAboveThanAverage; 


-- Update data within view
UPDATE DetailsView
SET NAME = 'Nimra', ADDRESS = 'Lahore'
WHERE ADDRESS = 'Bihar';

SELECT * FROM DetailsView;
SELECT * FROM StudentDetails;  -- Data in original table is also updated.

-- If view is a virtual table, then why changes are also made in original/base table?
-- Although a view is a virtual table (meaning it doesn't store data itself), it acts as a window to the data in the underlying base table(s). When you perform operations like INSERT, UPDATE, or DELETE on a view, those changes are actually passed through to the base table(s) because the view is just a representation of that data.
-- DML operations on simple views are redirected to the base table.
-- When you run:
    -- UPDATE DetailsView
    -- SET ADDRESS = 'Lahore'
    -- WHERE NAME = 'Ashmal';
-- It’s equivalent to:
    -- UPDATE StudentDetails
    -- SET ADDRESS = 'Lahore'
    -- WHERE NAME = 'Ashmal';


-- Update a view (change view definition without affecting data)
CREATE OR REPLACE VIEW MarksView AS
SELECT sd.NAME, sm.Marks, sm.Age
FROM StudentDetails sd, StudentMarks sm
WHERE sd.NAME = sm.NAME;

SELECT * FROM MarksView;


CREATE OR REPLACE VIEW MarksAboveThanAverage AS
SELECT NAME, Marks 
FROM StudentMarks
WHERE Marks <= (
    SELECT AVG(Marks)
    FROM StudentMarks
);

SELECT * 
FROM MarksAboveThanAverage;