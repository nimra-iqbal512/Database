-- Select all employees whose name start with 'J'
SELECT * 
FROM Employee
WHERE name LIKE 'J%';


-- name the employee with third highest salary
SELECT name 
FROM Employee
WHERE salary = (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 2
);


-- name the employee with second highest salary
SELECT name 
FROM Employee
WHERE salary = (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
);


-- Find the students who join in last n months, n = 12
CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    admission_date DATE
);

INSERT INTO student (name, admission_date) VALUES 
('Ali', '2024-01-15'),
('Ayesha', '2023-12-10'),
('Bilal', '2023-11-05'),
('Fatima', '2023-09-20'),
('Hassan', '2024-02-01'),
('Sara', '2024-03-10'),
('Usman', '2023-06-30');

SELECT *
FROM student
WHERE admission_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH);


-- Find departments present in both table
SELECT DISTINCT(deptid, d.department)    -- There is no need for () with DISTINCT, bcoz DISTINCT applies to entire row 

SELECT DISTINCT deptid, d.department    
FROM Employee e
JOIN Departments d
ON e.department = d.department;

SELECT DISTINCT department
FROM Employee
WHERE department IN (
    SELECT DISTINCT department
    FROM Departments
);

-- Employee id whose salary range is between 30000-60000
SELECT empid, name, salary
FROM Employee
WHERE salary BETWEEN 30000 AND 60000;