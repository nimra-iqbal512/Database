CREATE DATABASE Lab6;
USE Lab6;
SHOW TABLES;

CREATE TABLE Customer(
	CustomerID INT PRIMARY KEY,
	CusomerName VARCHAR(50),
	ContactName VARCHAR(50),
	Country VARCHAR(20)
);

INSERT INTO Customer
VALUES
(1, 'John Smith', 'John Smith', 'USA'),
(2, 'Jane Doe', 'Jane Doe', 'Canada'),
(3, 'Bob Brown', 'Bob Brown', 'Mexico');

SHOW TABLES;
SELECT * FROM Customer;

CREATE TABLE Orders(
	OrderID INT PRIMARY KEY,
	CustomerID INT,
	OrderDate DATE,
	FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
);

INSERT INTO Orders
VALUES
(10308, 2, '1996-09-18');

INSERT INTO Orders
VALUES
(10309, 3, '1996-09-19'),
(10310, 1, '1996-09-20');

INSERT INTO Orders
VALUES
(10311, NULL, '1996-09-25');

SELECT * FROM Customer;
SELECT * FROM Orders;

-- Creating INNER JOIN, that selects records that have matching values in both tables.
SELECT *
FROM Orders
INNER JOIN Customer
ON Orders.CustomerID = Customer.CustomerID;

SELECT Orders.OrderID, Customer.CusomerName, Orders.OrderDate
FROM Orders
INNER JOIN Customer
ON Orders.CustomerID = Customer.CustomerID;


-- == JOIN / INNER JOIN
-- Create the Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL,
    Description TEXT
);

-- Insert data into the Categories table
INSERT INTO Categories (CategoryID, CategoryName, Description) VALUES
(1, 'Beverages', 'Soft drinks, coffees, teas, beers, and ales'),
(2, 'Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings'),
(3, 'Confections', 'Desserts, candies, and sweet breads');

-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    CategoryID INT,
    Price INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Insert data into the Products table
INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES
(1, 'Chais', 1, 18),
(2, 'Chang', 1, 19),
(3, 'Aniseed Syrup', 2, 10);

SELECT * FROM Categories;
SELECT * FROM Products;

SELECT  *
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID;

SELECT ProductID, ProductName, CategoryName
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID;

-- Naming the columns
SELECT Products.ProductID, Products.ProductName, Categories.CategoryName
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID;

-- Error due to CategoryID because table_name is not specified, and CategoryID column is present in both tables
SELECT ProductID, ProductName, CategoryID, CategoryName
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID;

-- It works because none of the speciified column is present in both tables 
SELECT ProductID, ProductName, CategoryName
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID;

-- JOIN OR INNER JOIN (return same result)
SELECT Products.ProductID, Products.ProductName, Categories.CategoryName
FROM Products
JOIN Categories
ON Products.CategoryID = Categories.CategoryID;

-- JOIN  Three Tables
DROP TABLE Orders;
DROP TABLE Customer;


CREATE TABLE Customer(
	CustomerID INT PRIMARY KEY,
	CusomerName VARCHAR(50),
	ContactName VARCHAR(50),
	Country VARCHAR(20)
);

INSERT INTO Customer
VALUES
(1, 'John Smith', 'John Smith', 'USA'),
(2, 'Jane Doe', 'Jane Doe', 'Canada'),
(3, 'Bob Brown', 'Bob Brown', 'Mexico');

-- Create the Shippers table
CREATE TABLE Shippers (
    ShipperID INT PRIMARY KEY,
    ShipperName VARCHAR(255) NOT NULL,
    Phone VARCHAR(20)
);

-- Insert data into the Shippers table
INSERT INTO Shippers (ShipperID, ShipperName, Phone) VALUES
(1, 'Speedy Express', '(503) 555-9831'),
(2, 'United Package', '(503) 555-3199'),
(3, 'Federal Shipping', '(503) 555-9931');

CREATE TABLE Orders(
	OrderID INT PRIMARY KEY,
	CustomerID INT,
	ShipperID INT,
	OrderDate DATE,
	FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY(ShipperID) REFERENCES Shippers(ShipperID)
);

INSERT INTO Orders
VALUES
(10308, 2, 1, '1996-09-18'),
(10309, 3, 3, '1996-09-19'),
(10310, 1, 3, '1996-09-20');

SELECT * FROM Customer;
SELECT * FROM Shippers;
SELECT * FROM Orders;

SELECT *
FROM (Orders
INNER JOIN Customer
ON Orders.CustomerID = Customer.CustomerID)
INNER JOIN Shippers
ON Orders.ShipperID = Shippers.ShipperID;


-- Another Example
CREATE TABLE Students(
	Admission INT PRIMARY KEY,
	firstName VARCHAR(20),
	lastName VARCHAR(20),
	age INT
);

INSERT INTO Students
VALUES
(3420, 'Nicholas', 'Samuel', 14),
(3380, 'Joel', 'John', 15),
(3410, 'Japheth', 'Becky', 16),
(3498, 'Goerge', 'Joshua', 14),
(3486, 'John', 'Lucky', 15),
(3403, 'Simon', 'Dan', 13),
(3400, 'Calton', 'Becham', 16);

CREATE TABLE Fee(
	Admission INT,
	course VARCHAR(20),
	amount_paid INT
);

INSERT INTO Fee 
VALUES
(3380, 'ELectrical', 20000),
(3420, 'ICT', 15000),
(3398, 'Commerce', 13000),
(3410, 'HR', 12000);

-- Note that in above two tables, there is not Foreign key, means we can also use joins among tables not having parent child relation, just data is logically grouped by admission column
SELECT Students.firstName, Students.lastName, Students.Admission, Fee.amount_paid
FROM Students
INNER JOIN Fee 
ON Students.Admission = Fee.Admission;

