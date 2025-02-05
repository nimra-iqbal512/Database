USE studentmgmt;

-- Q1. Create a table Patient with following fields
-- • PatientID varchar (15)
-- • Name varchar (15)
-- • Age int
-- • Gender varchar(5)
-- • Address varchar(20)
-- • Disease varchar(10)
-- • DoctorID varchar(15)
--  Constraints.
-- • PatientID in Patient, is primary key

CREATE TABLE Patient(
	PatientID VARCHAR(15),
	Name VARCHAR(15),
	Age INT,
	Gender VARCHAR(5),
	Address VARCHAR(20),
	Disease VARCHAR(10),
	DoctorID VARCHAR(15)
)

ALTER TABLE Patient
ADD CONSTRAINT PatientID PRIMARY KEY (PatientID);


--  Q2. Change the datatype of Gender from varchar(5) to char in Patient table.
ALTER TABLE Patient
MODIFY COLUMN Gender CHAR(5);

-- ALTER TABLE Patient
-- MODIFY COLUMN Gender CHAR(5) NOT NULL;


-- Q3. Create a table Doctor with following fields
-- • DoctorID varchar (15)
-- • Name varchar (15)
-- • Age int
-- • Gender char
-- • Address varchar(20)
--  Constraints.
-- • DoctorID in Doctor, is primary key
CREATE TABLE Doctor(
	DoctorID VARCHAR(15),
	Name VARCHAR(15),
	Age INT,
	Gender CHAR,
	Address VARCHAR(20),
	PRIMARY KEY (DoctorID)
);


--  Q4. Now add column DoctorWard varchar(15) in Doctor table.
ALTER TABLE Doctor
ADD COLUMN DoctorWard VARCHAR(15);


-- Adding column with a constraint
-- ALTER TABLE Doctor
-- ADD COLUMN DoctorWard VARCHAR(15) NOT NULL;


--  Q5. Delete column Address in Doctor table.
ALTER TABLE Doctor
DROP COLUMN Address;

--  Q6. Delete Doctor table.
DROP TABLE Doctor;



-- ==== Understand a scenario
-- Suppose we create a table, and insert some data into it
-- Example:

CREATE TABLE Doctor(
	DoctorID INT AUTO_INCREMENT,
	Name VARCHAR(15),
	PRIMARY KEY (DoctorID)
);

INSERT INTO Doctor
VALUES
(NULL, 'abc'),
(NULL, 'def');

-- Now if I add some column, then what will be the value for that column for previously stored data?

ALTER TABLE Doctor
ADD COLUMN Age INT;
-- In this scenario, the value for Age will be NULL for previously stored data

ALTER TABLE Doctor
ADD COLUMN Age INT NOT NULL;
-- In this scenario, the value for Age will be 0 for previously stored data

ALTER TABLE Doctor
ADD COLUMN Contact VARCHAR(11) NOT NULL;
-- In this scenario, the value for Contact will be ''(empty) for previously stored data

ALTER TABLE Doctor
ADD COLUMN Age INT DEFAULT 6;
-- In this scenario, the value for Age will be 6 for previously stored data

SELECT * FROM Doctor;