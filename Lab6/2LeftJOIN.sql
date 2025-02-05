USE LAB6;
SHOW TABLES;

SELECT * FROM Customer;
SELECT * FROM Orders;

INSERT INTO Customer
VALUES
(4, 'Nimra', 'Iqbal', 'Pakistan'),
(5, 'Ashmal', 'Zahra', 'Pakistan');

SELECT *
FROM Customer
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID;

SELECT Customer.CustomerID, Customer.CusomerName, Orders.OrderID, Orders.OrderDate 
FROM Customer
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID;

SELECT Orders.CustomerID, Customer.CusomerName, Orders.OrderID, Orders.OrderDate 
FROM Customer
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID;

-- Also skip tha rows common in both tables (A - B) OR (Customer - Orders)
SELECT * 
FROM Customer
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID
WHERE Orders.CustomerID IS NULL; 

-- Providing results sames as JOIN/INNER JOIN
SELECT * 
FROM Customer
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID
WHERE Orders.CustomerID IS NOT NULL; 

-- LEFT JOIN and LEFT OUTER JOIN (Both are same things, both terms are used interchangeably)
SELECT Customer.CustomerID, Customer.CusomerName, Orders.OrderDate 
FROM Customer
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID;

SELECT Customer.CustomerID, Customer.CusomerName, Orders.OrderDate 
FROM Customer
LEFT OUTER JOIN Orders
ON Customer.CustomerID = Orders.CustomerID;

SELECT * FROM students;
SELECT * FROM fee;

SELECT Students.Admission, Students.firstName, Students.lastName, fee.amount_paid
FROM students
LEFT JOIN fee
ON students.admission = fee.admission;