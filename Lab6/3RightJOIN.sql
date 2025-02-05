USE LAB6;
SHOW TABLES;

SELECT * FROM Customer;
SELECT * FROM Orders;

SELECT *
FROM Orders
RIGHT JOIN Customer
ON Orders.CustomerID = Customer.CustomerID;

-- RIGHT JOIN and RIGHT OUTER JOIN, both terms are used interchangably
SELECT Customer.CustomerID, Customer.CusomerName, Orders.OrderID, Orders.OrderDate 
FROM Orders
RIGHT OUTER JOIN Customer
ON Orders.CustomerID = Customer.CustomerID;


-- Also skip tha rows common in both tables (B - A) OR (Customer - Orders)
SELECT * 
FROM Orders
RIGHT JOIN Customer
ON Orders.CustomerID = Customer.CustomerID
WHERE Customer.CustomerID IS NULL; 

-- Providing results sames as JOIN/INNER JOIN
SELECT * 
FROM Orders
RIGHT JOIN Customer
ON Orders.CustomerID = Customer.CustomerID
WHERE Orders.CustomerID IS NOT NULL;  


SELECT * FROM students;
SELECT * FROM fee;

SELECT students.admission, students.firstName, students.lastname, fee.amount_paid
FROM fee
RIGHT JOIN students
ON fee.Admission = students.Admission;