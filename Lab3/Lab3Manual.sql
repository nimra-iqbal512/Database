-- ============= Constraints, Primary key, Foreign Key

USE studentmgmt;

-- NOT  NULL Constraint

-- 1) 
CREATE TABLE Person(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	First VARCHAR(255) NOT NULL,
	Age INT
);

-- 2)
ALTER TABLE person
MODIFY COLUMN Age INT NOT NULL;

DROP TABLE person;


-- UNIQUE Constraint


-- Method 1
-- SQL Server (Also work on MySQL)
CREATE TABLE Persons(
	ID INT NOT NULL UNIQUE,
	LastName VARCHAR(255) NOT NULL,
	First VARCHAR(255),
	Age INT
);
DROP TABLE Persons;


-- Method 2
-- MySQL
CREATE TABLE Persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	First VARCHAR(255),
	Age INT,
	UNIQUE (ID)
);
DROP TABLE Persons;


-- Method 3
-- To name a 'UNIQUE' constraint, 
-- and to define a 'UNIQUE' constraint on multiple columns
CREATE TABLE Persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	First VARCHAR(255),
	Age INT,
	-- UNIQUE (ID, LastName)
	CONSTRAINT UC_Person UNIQUE (ID, LastName)
);
DROP TABLE Persons;


-- Method 4
-- UNIQUE Constraint on ALTER Table(Create 'UNIQUE' constraint when table is already created)
CREATE TABLE Persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT
);

ALTER TABLE Persons
ADD UNIQUE (ID);

DROP TABLE Persons;


-- Method 5
-- UNIQUE Constraint on ALTER Table(Create 'UNIQUE' constraint on multiple columns when table is already created)
CREATE TABLE Persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255) NOT NULL,
	Age INT
);

ALTER TABLE Persons
ADD CONSTRAINT UC_Person UNIQUE (ID, LastName);

DROP TABLE Persons;


-- Method 6
-- DROP a UNIQUE Constraint:
-- SQL Server (Also work in MySQL):
ALTER TABLE Persons
DROP CONSTRAINT UC_Person;

-- MySQL:
ALTER TABLE Persons
DROP INDEX UC_Person;

DROP TABLE Persons;


-- PRIMARY KEY Constraint

-- 1) SQL Server (Also work on MySQL)
CREATE TABLE Persons(
	ID INT NOT NULL PRIMARY KEY,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255) NOT NULL,
	Age INT
);
DROP TABLE Persons;

-- 2) MySQL
CREATE TABLE Persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255) NOT NULL,
	Age INT,
	PRIMARY KEY (ID)
);
DROP TABLE Persons;

-- 3) Alllow naming of a PRIMARY KEY constraint, and for defining a PRIMARY KEY constraint multiple columns
CREATE TABLE Persons(
	ID INT,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255) NOT NULL,
	Age INT,
	CONSTRAINT PK_Person PRIMARY KEY (ID, LastName)
);
-- Here, ther is only One PRIMARY KEY(PK_Person). However, the value of a Primary key is made up of Two Columns (ID + LastName)
DROP TABLE Persons;

-- 4) PRIMARY KEY on ALTER TABLE
CREATE TABLE Persons(
	ID INT,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255) NOT NULL,
	Age INT
);
ALTER TABLE Persons
ADD PRIMARY KEY (ID);

DROP TABLE Persons;

-- 5) PRIMARY KEY on ALTER TABLE
CREATE TABLE Persons(
	ID INT,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255) NOT NULL,
	Age INT
);
ALTER TABLE Persons
ADD CONSTRAINT PK_PERSON PRIMARY KEY (ID, LastName);

DROP TABLE Persons;

-- 6) DROP a PRIMARY KEY Constraint
CREATE TABLE Persons(
	ID INT,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255) NOT NULL,
	Age INT
);

ALTER TABLE Persons
ADD PRIMARY KEY (ID);

ALTER TABLE persons
DROP PRIMARY KEY;

DROP TABLE Persons;

-- 7) DROP a PRIMARY KEY Constraint
CREATE TABLE Persons(
	ID INT,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255) NOT NULL,
	Age INT
);

ALTER TABLE Persons
ADD CONSTRAINT PK_Person PRIMARY KEY (ID, LastName);

-- Below query work for SQL Server, not for MySQL
-- ALTER TABLE Persons
-- DROP CONSTRAINT PK_Person;

-- Drop the Primary Key in MySQL (Note: no constraint name required)
ALTER TABLE Persons
DROP PRIMARY KEY;

DROP TABLE Persons;


-- FOREIGN KEY Constraint

-- 1)
CREATE TABLE Persons(
	ID INT,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255) NOT NULL,
	Age INT,
	PRIMARY KEY (ID)
);
CREATE TABLE Orders(
	OrderID int NOT NULL,
	OrderNumber int NOT NULL,
	PersonID int,
	PRIMARY KEY (OrderID),
	FOREIGN KEY (PersonID) REFERENCES Persons(ID)
	-- PersonID INT FOREIGN KEY REFERENCES Persons(ID)  --SQL server syntax, not workking in MySQL
);
DROP TABLE Orders;

-- 2) 
-- Naming a FOREIGN KEY constraint
-- Defining FOREIGN KEY constraint on multiple columns
CREATE TABLE Orders(
	OrderID int NOT NULL,
	OrderNumber int NOT NULL,
	PersonID int,
	PRIMARY KEY (OrderID),
	-- FOREIGN KEY (PersonID) REFERENCES Persons(ID)  -- By default, if a referenced row in the Person table is deleted, the foreign key constraint may block the deletion if related rows exist in the Orders table.
	-- FOREIGN KEY(PersonID) REFERENCES Person(ID) ON DELETE CASCADE -- This ensures that when a Person row is deleted, all associated Orders rows are also deleted.
	-- OREIGN KEY(PersonID) REFERENCES Person(ID) ON DELETE SET NULL

	CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID) REFERENCES Persons(ID)
);
DROP TABLE Orders;

-- 3) Foreign Key on ALTER TABLE
CREATE TABLE Orders(
	OrderID int NOT NULL,
	OrderNumber int NOT NULL,
	PersonID int,
	PRIMARY KEY (OrderID)
);

ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(ID);

DROP TABLE orders;

-- 4) 
-- Naming Foreign key constraint
-- Defining Foreign Key constraint on multiple tables
CREATE TABLE Orders(
	OrderID int NOT NULL,
	OrderNumber int NOT NULL,
	PersonID int,
	PRIMARY KEY (OrderID)
);

ALTER TABLE Orders
ADD CONSTRAINT FK_OrderPerson 
FOREIGN KEY (PersonID) REFERENCES Persons(ID);

DROP TABLE Orders;

-- 5)
-- DROP FOREIGN KEY Constraint
-- When we don't define constraint name
CREATE TABLE Orders(
	OrderID int NOT NULL,
	OrderNumber int NOT NULL,
	PersonID int,
	PRIMARY KEY (OrderID),
	FOREIGN KEY (PersonID) REFERENCES Persons(ID)
);

-- Invalid syntax below. To drop the foreign key, we need to know its constraint name
-- ALTER TABLE orders
-- DROP FOREIGN KEY (PersonID);

-- Identify the foreign key constraint name
SHOW CREATE TABLE Orders

ALTER TABLE orders
DROP FOREIGN KEY orders_ibfk_1;

DROP TABLE orders;

-- 6)
-- DROP FOREIGN KEY Constraint
-- When we define constraint name
CREATE TABLE Orders(
	OrderID int NOT NULL,
	OrderNumber int NOT NULL,
	PersonID int,
	PRIMARY KEY (OrderID),
	CONSTRAINT FK_OrdersPerson FOREIGN KEY (PersonID) REFERENCES Persons(ID)
);

ALTER TABLE Orders
DROP FOREIGN KEY FK_OrdersPerson;


-- CHECK Constraint

-- 1)
CREATE TABLE Person(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT,
	CHECK (Age >= 18)	--MySQL Syntax
);
DROP TABLE Person;


CREATE TABLE Person(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT CHECK (Age>=18)	-- SQL Server Syntax. Also work on MySQL
);
DROP TABLE Person;

-- 2)
-- Naming the CHECK constraint
-- CHECK Constraint on multiple columns

--Without Naming
CREATE TABLE Person(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT,
	City VARCHAR(255),
	CHECK (Age >= 18 AND City = 'Lahore')	
);

DROP TABLE person;
-- With Naming
CREATE TABLE Person(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT,
	City VARCHAR(255),
	CONSTRAINT CHK_Person CHECK (Age >= 18 AND City = 'Lahore')	
);
DROP TABLE person;

-- 3)
-- CHECK on ALTER TABLE
CREATE TABLE Person(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT
);

ALTER TABLE person
ADD CHECK (Age >= 18);

DROP TABLE person;

-- 4) 
-- Naming CHECK constraint
-- Defining CHECK on multiple colums
CREATE TABLE Person(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT
);

ALTER TABLE person
ADD CONSTRAINT CHK_PersonAge CHECK (Age >= 18 AND FirstName = 'Ali');


-- 5) DROP a CHECK Constraint when Contraint is given a name

-- -- SQL Server syntax, but also working for MySQL
-- ALTER TABLE person
-- DROP CONSTRAINT CHK_PersonAge;

-- --  MySQL Syntax
ALTER TABLE person
DROP CHECK CHK_PersonAge;

DROP TABLE person;

-- 6) DROP a CHECK Constraint when Contraint is not given a name
CREATE TABLE Person(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT,
	CHECK (Age >= 18)
);

SHOW CREATE TABLE person

ALTER TABLE person
DROP CHECK person_chk_1;

-- NOTE: We can only DROP 'FOREIGN KEY' and 'CHECK' Constraints by using the constraint names

DROP TABLE person;


-- DEFAULT Constraint

-- 1)
CREATE TABLE Person(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT DEFAULT 18
);

-- The DEFAULT constraint can also be used to insert system values, by using functions like GETDATE():
DROP TABLE orders

CREATE TABLE Orders(
	ID INT NOT NULL PRIMARY KEY,
	OrderNumber INT NOT NULL,
	-- OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP

	-- extract Dtae from timestamp
	OrderDate DATE DEFAULT (CURRENT_DATE())
);

INSERT INTO Orders(ID, `OrderNumber`) VALUES (6, 1234);

SELECT * FROM orders;

-- 2)
-- Set DEFAULT on ALTER TABLE
DROP TABLE person;

CREATE TABLE Person(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	City VARCHAR(255)
);

ALTER TABLE person
ALTER City SET DEFAULT 'Lahore';

-- 'MODIFY COLUMN' works when we want to change data type for a column, or to add constrainsts like NOT NULL, PRIMARY KEY

-- ERROR 'MODIFY COLUMN'
ALTER TABLE person
MODIFY COLUMN City SET DEFAULT 'LAHORE';	

-- Correct 'MODIFY COLUMN'
ALTER TABLE Patient
MODIFY COLUMN Gender CHAR(5);

-- Correct 'MODIFY COLUMN'
ALTER TABLE Patient
MODIFY COLUMN Gender CHAR(5) NOT NULL;


-- 3)
-- DROP a DEFAULT Constraint
ALTER TABLE person
ALTER City DROP DEFAULT;

DROP TABLE person;



-- ========
-- Again Focus on MODIFY COLUMN:
-- Agr ek single column py koi constraints dalny hai, to MODIFY COLUMN k through dal lo
-- But I think, yh multiple columns k liye kam nahi kry ga (i.e. when Primary Key is a combination of multiple columns, or when we want NOT NULL/UNIQUE constraint on multiple columns. It can't be dealt through it.)