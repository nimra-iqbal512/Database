CREATE DATABASE Sales;

USE Sales;

CREATE TABLE tblSupplier(
	SupplierID INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	Address VARCHAR(255) NOT NULL,
	City VARCHAR(20) NOT NULL,
	Province VARCHAR(20) NOT NULL
);

INSERT INTO tblSupplier
VALUES 
(NULL, 'Ali', 'Shahpur', 'Lahore', 'Punjab'),
(NULL, 'Ahmad', 'Khanpur', 'Multan', 'Sindh'),
(NULL, 'Shan', 'Sultanpura', 'FSD', 'Punjab');


CREATE TABLE tblProducts(
	ProductID INT PRIMARY KEY AUTO_INCREMENT,
	SupplierID INT NOT NULL,
	CategoryID INT NOT NULL,
	ProductName VARCHAR(50) NOT NULL,
	EnglishName VARCHAR(50) NOT NULL,
	QuantityPerUnit INT NOT NULL,
	UnitPrice INT NOT NULL,
	UnitsInStock INT NOT NULL,
	UnitsOnOrder INT NOT NULL,
	RecorderLevel INT NOT NULL,
	Discontinued TINYINT(1) NOT NULL,
	FOREIGN KEY (SupplierID) REFERENCES tblSupplier (SupplierID)
);

-- CHECK Constraint Added like Primary Key Constarint
ALTER TABLE tblProducts
ADD CONSTRAINT chk_QuantityPerUnit CHECK (QuantityPerUnit BETWEEN 1 AND 10);

INSERT INTO tblProducts (
	SupplierID, CategoryID, ProductName, EnglishName, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, RecorderLevel, Discontinued
)
VALUES
    (1, 1, 'چائے', 'Tea', 10, 250, 50, 10, 5, 0),
    (2, 2, 'چینی', 'Sugar', 7, 80, 200, 20, 10, 0),
    (1, 3, 'دودھ', 'Milk', 5, 120, 75, 5, 15, 1);


CREATE TABLE tblShippers(
	ShipperID INT PRIMARY KEY AUTO_INCREMENT,
	CompanyName VARCHAR(50) NOT NULL
);

INSERT INTO tblShippers (CompanyName)
VALUES
    ('Fast Track Logistics'),
    ('Global Express'),
    ('Reliable Freight Co.');


CREATE TABLE tblCustomers(
	CustomerID INT PRIMARY KEY AUTO_INCREMENT,
	CompanyName VARCHAR(50) NOT NULL,
	ContactName VARCHAR(50) NOT NULL,
	ContactTitle VARCHAR(50) NOT NULL,
	Address VARCHAR(100) NOT NULL,
	City VARCHAR(20) NOT NULL,
	Region VARCHAR(20) NOT NULL,
	PostalCode VARCHAR(15) NOT NULL,
	Country VARCHAR(20) NOT NULL,
	Phone VARCHAR(11) NOT NULL,
	Fax VARCHAR(15) NOT NULL
);

INSERT INTO tblCustomers (
    CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax
)
VALUES
    ('Tech Innovators', 'Alice Smith', 'CEO', '123 Tech Avenue', 'New York', 'NY', '10001', 'USA', '12345678901', '1234567890'),
    ('Global Traders', 'Bob Johnson', 'Manager', '456 Market Street', 'San Francisco', 'CA', '94105', 'USA', '98765432101', '9876543210'),
    ('Fresh Produce Co.', 'Carol Lee', 'Owner', '789 Orchard Lane', 'Los Angeles', 'CA', '90001', 'USA', '45678901234', '4567890123');


CREATE TABLE tblOrders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    ShipperID INT NOT NULL,
    CustomerID INT NOT NULL,
    ShipName VARCHAR(100) NOT NULL,
    ShipAddress VARCHAR(150) NOT NULL,
    ShipCity VARCHAR(50) NOT NULL,
    ShipRegion VARCHAR(50),
    ShipPostalCode VARCHAR(15) NOT NULL,
    ShipCountry VARCHAR(50) NOT NULL,
    ShipVia INT,
    OrderDate DATE NOT NULL,
    RequiredDate DATE NOT NULL,
    ShippedDate DATE,
    Freight DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ShipperID) REFERENCES tblShippers(ShipperID),
    FOREIGN KEY (CustomerID) REFERENCES tblCustomers(CustomerID)
);

INSERT INTO tblOrders (
    OrderID, ShipperID, CustomerID, ShipName, ShipAddress, ShipCity, ShipRegion, 
    ShipPostalCode, ShipCountry, ShipVia, OrderDate, RequiredDate, ShippedDate, Freight
)
VALUES
    (1, 1, 1, 'Alice Corp', '123 Tech Ave', 'New York', 'NY', '10001', 'UK', 1, '2024-12-01', '2024-12-05', '2024-12-03', 50.75),
    (DEFAULT, 2, 2, 'Global Express', '456 Market St', 'San Francisco', 'CA', '94105', 'USA', 2, '2024-12-02', '2024-12-06', '2024-12-04', 30.00),
    (DEFAULT, 3, 3, 'Fresh Co.', '789 Orchard Ln', 'Los Angeles', 'CA', '90001', 'USA', 3, '2024-12-03', '2024-12-07', NULL, 45.50);


DROP TABLE tblOrderDetails;
CREATE TABLE tblOrderDetails(
	OrderID INT NOT NULL,
	ProductID INT NOT NULL,
	UnitPrice INT NOT NULL,
	Quantity INT NOT NULL,
	Discount INT NOT NULL,
	FOREIGN KEY (OrderID) REFERENCES tblOrders(OrderID),
	FOREIGN KEY (ProductID) REFERENCES tblProducts(ProductID)
);

INSERT INTO tblOrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES
    (1, 1, 800, 2, 5),
    (2, 2, 1200, 5, 10),
    (3, 3, 1600, 1, 0); 

SELECT * FROM tblOrderDetails;

UPDATE tblOrderDetails
SET Discount = 20
WHERE UnitPrice > 1000;

SELECT * FROM tblOrderDetails;


-- Delete the row for the order being shipped to UK having OrderID one.


-- SCENARIO 1
-- (First we need to delete from child table, then from parent table)
DELETE FROM tblOrderDetails
WHERE OrderID = 1;

DELETE FROM tblOrders
WHERE OrderID = 1 AND ShipCountry = 'UK';

SELECT * FROM tblOrders;
SELECT * FROM tblOrderDetails;


-- SCENARIO 2
-- (See SCENARIO 3 below before seeing SCENARIO 2)
-- I would be able to directly run this command
DELETE FROM tblOrders
WHERE OrderID = 1 AND ShipCountry = 'UK';
-- if I had created the tblOrderDetails like this
FOREIGN KEY (OrderID) REFERENCES tblOrders(OrderID) ON DELETE CASCADE,

-- SEE BELOW
DROP TABLE tblOrderDetails;
DROP TABLE tblOrders;

CREATE TABLE tblOrders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    ShipperID INT NOT NULL,
    CustomerID INT NOT NULL,
    ShipName VARCHAR(100) NOT NULL,
    ShipAddress VARCHAR(150) NOT NULL,
    ShipCity VARCHAR(50) NOT NULL,
    ShipRegion VARCHAR(50),
    ShipPostalCode VARCHAR(15) NOT NULL,
    ShipCountry VARCHAR(50) NOT NULL,
    ShipVia INT,
    OrderDate DATE NOT NULL,
    RequiredDate DATE NOT NULL,
    ShippedDate DATE,
    Freight DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ShipperID) REFERENCES tblShippers(ShipperID),
    FOREIGN KEY (CustomerID) REFERENCES tblCustomers(CustomerID)
);

INSERT INTO tblOrders (
    OrderID, ShipperID, CustomerID, ShipName, ShipAddress, ShipCity, ShipRegion, 
    ShipPostalCode, ShipCountry, ShipVia, OrderDate, RequiredDate, ShippedDate, Freight
)
VALUES
    (1, 1, 1, 'Alice Corp', '123 Tech Ave', 'New York', 'NY', '10001', 'UK', 1, '2024-12-01', '2024-12-05', '2024-12-03', 50.75),
    (DEFAULT, 2, 2, 'Global Express', '456 Market St', 'San Francisco', 'CA', '94105', 'USA', 2, '2024-12-02', '2024-12-06', '2024-12-04', 30.00),
    (DEFAULT, 3, 3, 'Fresh Co.', '789 Orchard Ln', 'Los Angeles', 'CA', '90001', 'USA', 3, '2024-12-03', '2024-12-07', NULL, 45.50);


CREATE TABLE tblOrderDetails(
	OrderID INT NOT NULL,
	ProductID INT NOT NULL,
	UnitPrice INT NOT NULL,
	Quantity INT NOT NULL,
	Discount INT NOT NULL,
	FOREIGN KEY (OrderID) REFERENCES tblOrders(OrderID) ON DELETE CASCADE,
	FOREIGN KEY (ProductID) REFERENCES tblProducts(ProductID) ON DELETE CASCADE
);

INSERT INTO tblOrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES
    (1, 1, 800, 2, 5),
    (2, 2, 1200, 5, 10),
    (3, 3, 1600, 1, 0); 


SELECT * FROM tblOrderDetails;
SELECT * FROM tblOrders;

-- No need to delete child data first, when data from parent table will be deleted, the associated data from child table will also be deleted.
DELETE FROM tblOrders
WHERE OrderID = 1 AND ShipCountry = 'UK';
 
SELECT * FROM tblOrderDetails;
SELECT * FROM tblOrders;


-- SCENARIO 3
-- Tables created like scenario 1 (without ON DELETE CASCADE), COMMENT
-- Trying to add ON DELETE CASCADE using ALTER TABLE

ALTER TABLE tblOrderDetails
ADD FOREIGN KEY (OrderID) REFERENCES tblOrders(OrderID) ON DELETE CASCADE;
DELETE FROM tblOrders
WHERE OrderID = 1 AND ShipCountry = 'UK';


ALTER TABLE tblOrderDetails
MODIFY COLUMN OrderID FOREIGN KEY (OrderID) REFERENCES tblOrders(OrderID) ON DELETE CASCADE;
DELETE FROM tblOrders
WHERE OrderID = 1 AND ShipCountry = 'UK';

-- Unfortunately, above both 'ALTER TABLE' queries not working.. (Or abi internet nahi hai, gpt nahi kr skti, next time sahi)



-- ======== Scenario
-- If I change data type for a column, what happens to the previous data inserted in that column
CREATE TABLE Practice(
	ID DECIMAL(10, 2) NOT NULL,
	Name VARCHAR(20) NOT NULL
);

DROP TABLE Practice;

INSERT INTO Practice(ID, Name)
VALUES
(11.24, 'Nimra'),
(07.24, 'Kaneez');

SELECT * FROM Practice;


-- Changing Data Type of the column
ALTER TABLE Practice
MODIFY COLUMN ID INT NOT NULL;

INSERT INTO Practice(ID, Name)
VALUES
(12, 'Ali'),
(18, 'Khan');

SELECT * FROM Practice;


ALTER TABLE Practice
MODIFY COLUMN Name INT NOT NULL;

INSERT INTO Practice(ID, Name)
VALUES
(17, 55),
(16, 55);

SELECT * FROM Practice;