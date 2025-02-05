-- MYSQL Correlated Subquery
-- Correlated Subquery is the one which uses columns from outer table for execution.

-- SELECT EmpId and name of employee from Employee where salary is less than salary and department is same as outer table

SELECT e1.empid, e1.name, e1.department
FROM Employee e1
WHERE salary < (SELECT AVG(salary) FROM Employee e2 WHERE e1.department = e2.department);
-- In above query, we select id, name, department of emplyees whose salary is lesser than the average salary of all employees in that department.
-- This query will first fetch average salary depending on department name in two tables and then select employees with salary less than average salary.