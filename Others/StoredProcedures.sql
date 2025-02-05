CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    Address VARCHAR(255),
    City VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50)
);

INSERT INTO Customer (CustomerID, CustomerName, ContactName, Address, City, PostalCode, Country) VALUES
(1, 'Alfreds Futterkiste', 'Maria Anders', 'Obere Str. 57', 'Berlin', '12209', 'Germany'),
(2, 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Avda. de la Constitución 2222', 'México D.F.', '05021', 'Mexico'),
(3, 'Antonio Moreno Taquería', 'Antonio Moreno', 'Mataderos 2312', 'México D.F.', '05023', 'Mexico'),
(4, 'Around the Horn', 'Thomas Hardy', '120 Hanover Sq.', 'London', 'WA1 1DP', 'UK'),
(5, 'Berglunds snabbköp', 'Christina Berglund', 'Berguvsvägen 8', 'Luleå', 'S-958 22', 'Sweden');


SELECT * FROM Customer;


-- == Procedure without Parameter
-- Create a stored procedure named "select_all_customers"
CREATE PROCEDURE select_all_customers()
BEGIN
    SELECT * FROM Customer;
END;

CALL select_all_customers;


-- BEGIN and END are not mandatory when there is only one MySQL statement, but still use of BEGIN and END even with one MySQL statement is a good approach
CREATE PROCEDURE get_customers_city(IN city_name VARCHAR(50))
    SELECT * FROM Customer WHERE city = city_name;

CALL get_customers_city('London');


-- == Procedure with single Parameter (IN parameter mode)
-- Create a stored procedure named "customers_city"
CREATE PROCEDURE customers_city(IN city_name VARCHAR(50))
BEGIN
    SELECT * FROM Customer WHERE city = city_name;
END;

-- DROP PROCEDURE IF EXISTS customers_city;
CALL customers_city('London');


-- == Can we create parameters without specifying parameter mode(IN/OUT/INOUT)?
-- -- Yes, default parameter mode is IN
CREATE PROCEDURE get_customers_country(country_name VARCHAR(50))
    SELECT * FROM Customer WHERE Country = country_name;

CALL get_customers_country('UK');


-- == Procedure with multi_parameters
CREATE PROCEDURE customers_details(IN city_name VARCHAR(50), IN country_name VARCHAR(50))
BEGIN
    SELECT * FROM Customer 
    WHERE city = city_name || Country = country_name;
END;

CALL customers_details('London', 'Mexico');


-- == Procedure with OUT parameters
CREATE PROCEDURE get_customer_address(OUT get_address VARCHAR(255))
BEGIN
    SELECT Address INTO get_address 
    FROM Customer
    WHERE CustomerID = 2;
END;

CALL get_customer_address(@Address);
SELECT @Address;


-- == Combine IN and OUT parameters
CREATE PROCEDURE get_customer_details(IN cus_id INT, OUT country_name VARCHAR(255))
BEGIN
    SELECT Country INTO country_name 
    FROM Customer
    WHERE CustomerID = cus_id;
END;

CALL get_customer_details(1, @country);
SELECT @country as Country;


-- == Procedure with INOUT Parameter
CREATE PROCEDURE get_residence(INOUT res VARCHAR(255))
BEGIN
    SELECT city INTO res
    FROM Customer
    WHERE Country = res;
END;

SET @res = 'UK';
CALL get_residence(@res);   
SELECT @res;

SET @res = 'Mexico';
CALL get_residence(@res);   --ERROR! The above procedure can return result from a single row in @res variable. But the result consisted of more than one row.
-- In order to correct the error, we can change the SQL statement to:
--     SELECT city INTO res
--     FROM Customer
--     WHERE Country = res
--     LIMIT 1;
SELECT @res;