SHOW DATABASES;

CREATE DATABASE Lab5;
USE Lab5;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Address VARCHAR(200),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    Country VARCHAR(100)
);

INSERT INTO Customers (CustomerID, CustomerName, ContactName, Address, City, PostalCode, Country)
VALUES
(1, 'Alfreds Futterkiste', 'Maria Anders', 'Obere Str. 57', 'Berlin', '12209', 'Mexico'),
(2, 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Avda. de la Constitución 2222', 'México D.F.', '05021', 'Mexico'),
(3, 'Antonio Moreno Taquería', 'Antonio Moreno', 'Mataderos 2312', 'México D.F.', '05023', 'Mexico'),
(4, 'Around the Horn', 'Thomas Hardy', '120 Hanover Sq.', 'London', 'WA1 1DP', 'Mexico'),
(5, 'Berglunds snabbköp', 'Christina Berglund', 'Berguvsvägen 8', 'Luleå', 'S-958 22', 'Sweden');

SELECT * FROM Customers;


-- == LIMIT clause:
SELECT * FROM Customers
LIMIT 3;

-- Adding WHERE clause:
SELECT * FROM Customers
WHERE Country='Mexico'
LIMIT 3;

-- Adding ORDER BY keyword
SELECT * FROM Customers
ORDER BY CustomerID DESC
LIMIT 3;

SELECT * FROM Customers
WHERE Country = 'Mexico'
ORDER BY CustomerID DESC;

SELECT * FROM Customers
WHERE Country = 'Mexico'
ORDER BY CustomerID DESC
LIMIT 3;


-- == DISTINCT keyword

-- Without DISTINCT
SELECT Country 
FROM Customers;

-- With DISTINCT
SELECT DISTINCT Country 
FROM Customers;

SELECT DISTINCT City, Country 
FROM Customers;


-- == COUNT() 
SELECT COUNT(CustomerID) FROM Customers;
SELECT COUNT(Country) FROM Customers;

-- == Count DISTINCT
SELECT COUNT(DISTINCT Country) 
FROM Customers;

SELECT COUNT(DISTINCT City, Country)
FROM Customers;


-- == ORDER BY:

SELECT * FROM Customers;

SELECT * FROM Customers
ORDER BY CustomerID;

SELECT * FROM Customers
ORDER BY CustomerID DESC;

SELECT * FROM Customers
ORDER BY CustomerID ASC;


-- == GROUP BY
SELECT Country
FROM Customers
GROUP BY Country;

SELECT Country, City
FROM Customers
GROUP BY Country, City;

-- == GROUP BY and DISTINCT (both gives distinct values)
-- Alternate of above two quries
SELECT DISTINCT Country
FROM Customers;

SELECT DISTINCT Country, City 
FROM Customers;

-- If same thing can be achieved through DISTINCT, then why GROUP BY?
-- DISTINCT only tells unique values in a column.
-- GROUP BY not only tells unique values, but we can use aggregate functions with it, like COUNT() tells number of entries under each value.

SELECT COUNT(CustomerID)
FROM Customers;

-- Error, Aggtegated Functions used without GROUP BY
SELECT COUNT(CustomerID), Country
FROM Customers;

-- Correct
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country;

-- Error: 
-- Rule: All columns in the SELECT clause that are not aggregate functions must be included in the GROUP BY clause.
SELECT COUNT(CustomerID), Country, City
FROM Customers
GROUP BY Country;

-- Correct
SELECT COUNT(CustomerID), Country, City
FROM Customers
GROUP BY Country, City;

-- Error: 
-- Rule: All columns in the SELECT clause that are not aggregate functions must be included in the GROUP BY clause.
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY City;

-- No syntax Error, but not gives any meaningful purpose, bcoz customerID is unique, it can't be grouped
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY CustomerID;

-- Correct
SELECT COUNT(Country), Country
FROM Customers
GROUP BY Country;

SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID);
-- ORDER BY COUNT(CustomerID) DESC;


-- == GROUP BY with joins (will see when we'll cover join)
-- https://www.w3schools.com/sql/sql_groupby.asp


-- == Another Example for GROUP BY
CREATE TABLE sales(
    OrderID INT PRIMARY KEY,
    Product VARCHAR(255),
    Name VARCHAR(50),
    Price INT
);

INSERT INTO sales (OrderID,Product, Name, Price) VALUES
    (1, 'Laptop','John', 1200),
    (2, 'Smartphone','Alice', 800),
    (3, 'Tablet','John', 500),
    (4, 'Laptop','Bob', 1200),
    (5, 'Laptop','Alice', 1200),
    (6, 'Tablet','Emily', 400),
    (7, 'Tablet', NULL, 600),
    (8, 'Tablet', NULL, 400),
    (9, NULL,'Alice', 1200);

-- == Delete all data
-- DELETE FROM sales;

-- == Delete all data
-- TRUNCATE TABLE sales;

-- == Delete all data + schema
-- SELECT * FROM sales;

SELECT *
FROM sales
WHERE Name IS NULL;


SELECT DISTINCT Product FROM sales;
SELECT DISTINCT Name FROM sales;
SELECT DISTINCT Product, Price FROM sales;
SELECT DISTINCT Product, Name FROM sales;

-- Total sales of each product
SELECT Product, SUM(Price)
FROM sales
GROUP BY Product;

SELECT Product, SUM(Price) as Total_sales
FROM sales
WHERE Product IS NOT NULL
GROUP BY Product
ORDER BY Total_sales DESC;

-- == COUNT(column_name) VS COUNT(*)
-- COUNT(column_name): In a group, it counts the rows having non_NULL values in the specified column(column_name). Rows having NULL value in the specified columns are ignored.
-- COUNT(*): counts all rows, regardless of whether any column contains NULL or not.

SELECT Product, COUNT(OrderID) as Quantity
FROM sales
GROUP BY Product;

SELECT Product, COUNT(Name) as Quantity
FROM sales
GROUP BY Product;

SELECT Product, COUNT(Product) as Quantity
FROM sales
GROUP BY Product;

SELECT Product, COUNT(*) as Quantity
FROM sales
GROUP BY Product;

-- Total sales and quantity of each product
SELECT Product, COUNT(Product) as Quantity, SUM(Price) as Total_sales
FROM sales
GROUP BY Product;

SELECT Product, COUNT(*) as Quantity, SUM(Price) as Total_sales
FROM sales
GROUP BY Product;

-- =======================
-- Wildcard Characters
SHOW DATABASES;
USE LAB5;
SHOW TABLES;

SELECT * FROM Customers;

-- Select all customers with the city starting with 'Mex'
SELECT * FROM Customers WHERE City LIKE 'Mex%';
SELECT * FROM Customers WHERE City LIKE 'Mexico%';

-- Select all customers with the city starting with 'n'
SELECT * FROM Customers WHERE City LIKE '%n';
SELECT * FROM Customers WHERE City LIKE '%on';

-- Select all customers with a City containing the pattern 'xi' at any position
SELECT * FROM Customers WHERE City LIKE '%xi%';
SELECT * FROM Customers WHERE City LIKE '%Me%';
SELECT * FROM Customers WHERE City LIKE '%o%';

-- Selecct all customers with a city starting with any character, followed by 'ondon'.
SELECT * FROM Customers 
WHERE City LIKE '_ondon';

SELECT * FROM Customers 
WHERE City LIKE '_erlin';

-- Find all customers with a City starting with 'L', followed by any 3 characters, ending with 'on
SELECT * FROM Customers 
WHERE City LIKE 'L___on';

-- The following SQL statement selects all customers with
--  a City starting with 'L', 
-- followed by any character, 
-- followed by 'n'
-- followed by any character, 
-- followed by 'on'
SELECT * FROM Customers
WHERE City LIKE 'L_n_on';

-- Find all customers whose second character is 'e' in City
SELECT * FROM Customers
WHERE City LIKE '_e%';

-- Find all Customers whose city starts 'L' and at least 3 characetrs in length
SELECT * FROM Customers
WHERE City LIKE 'L__%';
-- Same as above
SELECT * FROM Customers
WHERE City LIKE 'L_%_%';

SELECT * FROM Customers
WHERE City LIKE 'L_____%';

-- Find all Customers whose name start with 'A' and end with 'n'
SELECT * FROM Customers
WHERE CustomerName LIKE 'A%n';

SELECT * FROM Customers
WHERE CustomerName LIKE 'a%n';  --(Names stores as 'A', but still accesed with 'a'. SQL is case in-sensitive in this scenarip)

-- == Without WildCard 
-- If no wildcard is specified, the phrase has to have an exact match to return a result.

-- Return all customers having Country 'Mexico'
SELECT * FROM Customers
WHERE Country LIKE 'Mexico';

-- Above query is same as
SELECT * FROM Customers
WHERE Country = 'Mexico';