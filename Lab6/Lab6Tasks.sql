-- Create Salesman Table
CREATE TABLE Salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(5, 2)
);

-- Insert data into Salesman Table
INSERT INTO Salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12);

-- Create Customer Table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT
);

-- Insert data into Customer Table
INSERT INTO Customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006),
(3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozv Altidor', 'Moscow', 200, 5007);

-- Create Orders Table
CREATE TABLE Orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);

-- Insert data into Orders Table
INSERT INTO Orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001);


-- Task 1
-- Write a SQL query to find the salesperson and customer who belongs to same city. Return Salesman name, cust_name and city.

-- Notice difference among both queries given below

SELECT salesman.name as salesman_name, customer.cust_name as customer_name, salesman.city as city 
FROM salesman
INNER JOIN customer
ON salesman.salesman_id = customer.salesman_id
WHERE salesman.city = customer.city;


SELECT s.name as salesman_name, c.cust_name as customer_name, s.city as city
FROM Salesman s
JOIN Customer c
ON s.city = c.city;

-- Task 2:
-- Write a SQL query to find those orders where order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city.
SELECT orders.ord_no, orders.purch_amt, customer.cust_name, customer.city
FROM orders
INNER JOIN customer
ON orders.customer_id = customer.customer_id
WHERE orders.purch_amt BETWEEN 500 AND 2000;


-- Task 3
-- Write a SQL query to find the salesperson(s) and the customer(s) he handles. Return Customer Name, city, Salesman, commission.
SELECT customer.cust_name, customer.city, salesman.name, salesman.commission
FROM customer
INNER JOIN salesman
ON customer.salesman_id = salesman.salesman_id;


-- Task 4:
-- From the following tables write a SQL query to find those salespersons who received a commission from the company more than 12%. Return Customer Name, customer city, Salesman, commission. 
SELECT customer.cust_name, customer.city, salesman.name, salesman.commission
FROM customer
INNER JOIN salesman
ON customer.salesman_id = salesman.salesman_id
WHERE salesman.commission > 0.12;
WHERE salesman.commission > 12/100;


-- Task 5:
-- Write a SQL query to display the cust_name, customer city, grade, Salesman, salesman city.
SELECT customer.cust_name, customer.city, customer.grade, salesman.name, salesman.city
FROM customer
INNER JOIN salesman
ON customer.salesman_id = salesman.salesman_id;


-- Task 6:
-- Write a SQL query to find those customers whose grade less than 300. Return cust_name, customer city, grade, Salesman, saleman city.
SELECT customer.cust_name, customer.city, customer.grade, salesman.name, salesman.city
FROM customer
LEFT JOIN salesman
ON customer.salesman_id = salesman.salesman_id
WHERE customer.grade < 300;


-- Task 7:
-- Write a SQL statement to make a list in ascending order for the salesmen who works either for one or more customer or not yet join under any of the customers
SELECT salesman.*, customer.*
FROM salesman
LEFT JOIN customer
ON salesman.salesman_id = customer.salesman_id;

SELECT salesman.name as salesman_name, COUNT(customer.customer_id) as no_of_customers_deal
FROM salesman
LEFT JOIN customer
ON salesman.salesman_id = customer.salesman_id
GROUP BY salesman.name
ORDER BY no_of_customers_deal;

-- Additional: filter salesman without customers
SELECT salesman.name as salesman_name, COUNT(customer.customer_id) as no_of_customers_deal
FROM salesman
LEFT JOIN customer
ON salesman.salesman_id = customer.salesman_id
GROUP BY salesman.name
HAVING COUNT(customer.customer_id) > 0
ORDER BY no_of_customers_deal;

-- Additional: salesman who deal no customers
SELECT s.name as salesman_name
FROM Salesman s
LEFT JOIN Customer c
ON s.salesman_id = c.salesman_id
GROUP BY s.name
HAVING COUNT(c.cust_name) = 0

-- Task 8:
-- Write a SQL statement to make a report with customer name, city, order no., order date, purchase amount for those customers from the existing list who placed one or more orders or which order(s) have been placed by the customer who is not on the list. 
SELECT customer.cust_name, customer.city, orders.ord_no, orders.ord_date, orders.purch_amt
FROM customer
LEFT JOIN orders
ON customer.customer_id = orders.customer_id;

SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM Customer c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
UNION
SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM Customer c
RIGHT JOIN Orders o
ON c.customer_id = o.customer_id

-- Additional: To find only customers who have placed orders
SELECT customer.cust_name, customer.city, orders.ord_no, orders.ord_date, orders.purch_amt
FROM customer
LEFT JOIN orders
ON customer.customer_id = orders.customer_id
WHERE orders.ord_no IS NOT NULL;