USE LAB6;
SHOW TABLES;

SELECT * FROM Customer;
SELECT * FROM Orders;

INSERT INTO Orders
VALUES
(10311, NULL, 3, '1996-09-22');

-- Multiple Orders against single customer
INSERT INTO Orders
VALUES
(10312, 2, 2, '1996-09-23'),
(10313, 2, 1, '1996-09-24'),
(10314, 3, 1, '1996-09-25');

SELECT * FROM Customer;
SELECT * FROM Orders;


SELECT *
FROM Customer
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID;

-- Instead of SELECT *, use SELECT Customer.*, Orders.*
-- This syntax is used when we want to select all columns from both tables involved in a join.
-- SELECT * might cause error, when the table2(Orders) have multiple rows against one row of table1(Customer). CustomerID '2' can place multiple orders. Using SELECT Customer.*, Orders.* ensures correct output
SELECT Customer.*, Orders.*
FROM Customer
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID;

-- == FULL OUTER JOIN

-- ERROR
SELECT *
FROM Customer AS C
FULL JOIN Orders AS O
ON C.CustomerID = O.CustomerID;

-- Above query gives error
-- because MySQL does not directly support a FULL OUTER JOIN. Instead we can achieve it combining a LEFT JOIN, a RIGHT JOIN, and a UNION operator.

SELECT * FROM Customer;
SELECT * FROM Orders;

SELECT Customer.*, Orders.*
FROM Customer
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID;

SELECT Customer.*, Orders.*
FROM Customer
RIGHT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID;

-- FULL OUTER JOIN (Method 1)
SELECT Customer.*, Orders.*
FROM Customer
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID
UNION
SELECT Customer.*, Orders.*
FROM Customer
RIGHT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID;

-- FULL OUTER JOIN (Method 2)
SELECT Customer.*, Orders.*
FROM Customer
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID
UNION
SELECT Customer.*, Orders.*
FROM Orders
LEFT JOIN Customer
ON Customer.CustomerID = Orders.CustomerID;


SELECT * FROM Students;
SELECT * FROM fee;


SELECT Students.Admission, Students.firstname, fee.amount_paid
FROM Students
LEFT JOIN fee
ON Students.Admission = fee.admission
UNION
SELECT Students.Admission, Students.firstname, fee.amount_paid
FROM Students
RIGHT JOIN fee
ON Students.Admission = fee.admission;


-- Q: Above query is fine, but how can I get the student's firstname names in sorted form?

SELECT Students.Admission, Students.firstname, fee.amount_paid
FROM Students
LEFT JOIN fee
ON Students.Admission = fee.admission
UNION
SELECT Students.Admission, Students.firstname, fee.amount_paid
FROM Students
RIGHT JOIN fee
ON Students.Admission = fee.admission
ORDER BY firstname;
-- ORDER BY Students.firstname; In above query if we replace last line with this, it generates error. Its because of using UNION
-- The error occurs because the UNION operator combines results from multiple SELECT statements into a single result set, and the ORDER BY clause applies to the final result. In the final result set, column names should be referred to by their aliases (if any) or by their plain column names, not prefixed by table names.


-- Using Students.firstname without UNION Operator
SELECT Students.Admission, Students.firstname, fee.amount_paid
FROM Students
RIGHT JOIN fee
ON Students.Admission = fee.admission
ORDER BY `Students`.firstname DESC;

