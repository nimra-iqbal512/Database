CREATE TABLE Employee(
    empid numeric(10),
    name varchar(20),
    salary numeric(10),
    department varchar(20)
);

CREATE TABLE Departments(
    deptid numeric(10),
    department varchar(20)
);


INSERT INTO Employee 
VALUES (100,"Jacob A",20000,"SALES"),(101,"James T",50000,"IT"),(102,"Riya S",30000,"IT");

INSERT INTO Departments 
VALUES (1,"IT"),(2,"ACCOUNTS"),(3,"SUPPORT");


SELECT * FROM Employee;
SELECT * FROM Departments;


-- MYSQL SubQuery with WHERE Clause (Mostly comparison, and Aggregate functions in WHERE clause)
-- (Scenario: when sub query returns a single value)

-- Select employees from department with the department id as 1

SELECT *
FROM Employee e
INNER JOIN Departments d
ON e.department = d.department
WHERE d.deptid = 1;


SELECT *
FROM Employee
WHERE department = (
    SELECT department FROM Departments where deptid = 1
)


-- MYSQL Subquery with comparison operator

-- SELECT employees whose salary is less than average salary of all employees

SELECT * 
FROM Employee
WHERE salary < (
    SELECT AVG(salary) 
    FROM Employee
)

-- SELECT employees whose salary is greater than or equal to average salary of all employees
SELECT * 
FROM Employee
WHERE salary >= (
    SELECT AVG(salary) 
    FROM employee
)

-- Employee with highest salary
SELECT empid, name, salary
FROM Employee
WHERE salary = (
    SELECT max(salary) 
    FROM Employee
);

-- Employee with second highest salary
SELECT empid, name, salary
FROM Employee
WHERE salary < (SELECT max(salary) FROM Employee)
ORDER BY salary DESC
LIMIT 1;
-- Working of above query:
-- (First select the maximum salary from Employee table, then sort the remaining salaries in Descending order, then use LIMIT 1 to get the second highest salary)

-- Better approach for above query
-- (Sort all unique(distinct) salaries in Descending order, skip first one, and then get employee with second highest salary)
SELECT *
FROM Employee
WHERE salary = (
    SELECT DISTINCT salary 
    FROM Employee 
    ORDER BY salary DESC 
    OFFSET 1 LIMIT 1
);


-- MYSQL Subquery with IN and NOT IN operators 
-- (Secenario: when sub query returns more than one rows, but one column)

-- SELECT all employees whose department is in department table
SELECT * 
FROM Employee e
INNER JOIN Departments d
ON e.department = d.department;

SELECT *
FROM Employee
WHERE department IN (
    SELECT department 
    FROM Departments
);

-- SELECT all employees whose department is not in department table

SELECT * 
FROM Employee e
LEFT JOIN Departments d
ON e.department = d.department
WHERE d.department IS NULL;

SELECT *
FROM Employee
WHERE department NOT IN (
    SELECT department 
    FROM Departments
);
-- The above query might work fine, bcoz if subquery contains NULL values, the NOT IN operator might behave unexpectedly(returns no result). So its better to exclude NULL values explicitly

INSERT INTO Departments 
VALUES (4,NULL);

-- (Now below query return no result)
SELECT *
FROM Employee
WHERE department NOT IN (
    SELECT department 
    FROM Departments
);

-- Working correctly
SELECT *
FROM Employee
WHERE department NOT IN (
    SELECT department 
    FROM Departments 
    WHERE department IS NOT NULL
);


-- MYSQL Subquery with FROM clause 
-- (Scenario: when subquery returns a table, i.e. multiple rows and columns)

-- Select all departments from employee table with nested query


-- Error in below query: Every derive must has its own Alias
SELECT department
FROM (SELECT * FROM Employee);

-- Correct
SELECT department
FROM (SELECT * FROM Employee) AS A;
-- Correct
SELECT department
FROM (SELECT * FROM Employee) A;

-- Select all Departments having more than 1 Employees (Use of aggregate function)
SELECT department, total_employees
FROM (
    SELECT department, COUNT(department) as total_employees
    FROM Employee
    GROUP BY department
) as employee_count
WHERE total_employees > 1;

-- Select all Departments having more than 1 Employees, Display department id, department name and total employees. (Use of aggregate function in subquery with FROM). 
SELECT  dep.deptid, emp_count.department, emp_count.total_employees
FROM (
    SELECT department, COUNT(department) as total_employees
    FROM Employee
    GROUP BY department
) as emp_count
INNER JOIN Departments dep
ON emp_count.department = dep.department
HAVING total_employees > 1;

-- Better Approach of above query
SELECT  dep.deptid, emp_count.department, emp_count.total_employees
FROM (
    SELECT department, COUNT(department) as total_employees
    FROM Employee
    GROUP BY department
    HAVING total_employees > 1
) as emp_count
INNER JOIN Departments dep
ON emp_count.department = dep.department

-- Calcaulate average salary for each department
SELECT department, ROUND (AVG(salary), 2) as avg_salary
FROM Employee
GROUP BY department
ORDER BY avg_salary DESC;

-- Calcaulate average salary for each department and exclude department whose average salary is less than 250000
SELECT department, ROUND (AVG(salary), 2) as avg_salary
FROM Employee
GROUP BY department
HAVING avg_salary >= 25000
ORDER BY avg_salary DESC;

-- Calculate Employees of each department having salary above the average salary
SELECT *
FROM Employee emp
LEFT JOIN (
    SELECT department, ROUND(AVG(salary), 2) as avg_salary
    FROM Employee
    GROUP BY department
) as avg_count
ON emp.department = avg_count.department
WHERE salary > avg_salary;

-- Identifies employess from departments where average salary is greater than 25,000
SELECT e.name, e.salary, e.department
FROM Employee e
INNER JOIN  (
    SELECT department, ROUND(AVG(salary), 2) as avg_salary
    FROM Employee
    GROUP BY department
    HAVING avg_salary > 25000
) AS avg_count
ON e.department = avg_count.department;

-- Attempt above query using window functions:
-- (Revise windowFunctions.sql)

SELECT *
FROM (
    SELECT *,
    AVG(salary) OVER (PARTITION BY department) as dept_avg_salary
    FROM Employee
) AS dept_salary
WHERE dept_avg_salary > 25000;


-- -- Department with Maximum and Minimum Exployees

-- Below query not gives complete required result
SELECT MAX(total_employees), MIN(total_employees)
FROM (
    SELECT department, count(empid) as total_employees
    FROM Employee
    GROUP BY department
) AS count_emp;


-- Tried to get max and min employee using two queries and then UNION them.
-- But below query give error.
-- SELECT department, COUNT(*)
-- FROM Employee
-- GROUP BY department
-- ORDER BY COUNT(*) DESC
-- LIMIT 1
-- UNION
-- SELECT department, COUNT(*)
-- FROM Employee
-- GROUP BY department
-- ORDER BY COUNT(*)
-- LIMIT 1;

-- Why ERROR?
-- ERROR! bcoz 'ORDER BY' AND 'LIMIT' are applied individually to both queries before performing the UNION.
-- SQL not allow 'ORDER BY' inside subqueries when using UNION

-- Correct query with above approach
SELECT *
FROM (
    SELECT department, COUNT(*)
    FROM Employee
    GROUP BY department
    ORDER BY COUNT(*) DESC
    LIMIT 1
) as max_emp
UNION
SELECT *
FROM (
    SELECT department, COUNT(*)
    FROM Employee
    GROUP BY department
    ORDER BY COUNT(*)
    LIMIT 1
) min_emp;


-- ============= Filhal yahi stop kr rhi hu mai

-- Alternate ways to get max and min employees
SELECT *
FROM (
    SELECT department, count(empid) as total_employees
    FROM Employee
    GROUP BY department
) AS count_emp
WHERE total_employees = (
    SELECT COUNT(empid) AS total_employees
    FROM Employee
    GROUP BY department
    ORDER BY total_employees
    LIMIT 1
)
OR total_employees = (
    SELECT COUNT(empid) AS total_employees
    FROM Employee
    GROUP BY department
    ORDER BY total_employees DESC
    LIMIT 1
);
-- Above query can be improved: Instead of 'ORDER BY', we can use MIN() , MAX()
SELECT *
FROM (
    SELECT department, count(empid) as total_employees
    FROM Employee
    GROUP BY department
) AS count_emp
WHERE total_employees = (
    SELECT MIN(total_employees) FROM (
        SELECT COUNT(empid) AS total_employees
        FROM Employee
        GROUP BY department
    ) AS subquery
)
OR total_employees = (
    SELECT MAX(total_employees)
    FROM (
        SELECT COUNT(empid) AS total_employees
        FROM Employee
        GROUP BY department
    ) AS subquery
);

-- Using Window Function:
SELECT department, total_employees
FROM (
    SELECT 
        department, 
        COUNT(empid) as total_employees,
        MAX(COUNT(empid)) OVER () max_emp,
        MIN(COUNT(empid)) OVER () min_emp
    FROM Employee
    GROUP BY department
) AS count_emp
WHERE total_employees = min_emp OR total_employees= max_emp;
-- WHY OVER() is empty?
-- OVER() without a partition column means the window function will apply across all rows in the result set, without any specific grouping.
-- MAX(COUNT(empid)) OVER () AS max_emp: Calculates the maximum number of employees across all departments. Since OVER() is empty, it takes the maximum of the entire result set (the total number of employees in all departments).
-- MIN(COUNT(empid)) OVER () AS min_emp: Similar to the above, it calculates the minimum number of employees across all departments.