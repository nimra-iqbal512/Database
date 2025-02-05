-- Window Functions:
-- Window Functions are advanced SQL functions that perform the calculations across a set of rows related to the current row, without collapsing them into a single aggregate result.
-- These allow to apply calculations over a subset of rows(called a "window") while still retaining individual row details.
-- Unlike aggregate functions (e.g. SUM(), AVG()) which group rows into a single result, window functions return a vale for each row based on a defined window of rows.

-- Key features:
-- Operate on a "window" of rows related to the current row.
-- Do not collapse rows meaning each row is still available in the result set.
-- User the OVER() clause to define the window (partitioning and ordering criteria).
-- can be combined with regular SQL queries.


-- SOME Common SQL Window Functions

-- Aggregate Window Functions:
-- AVG() OVER(): Avergae over a partition of rows
-- SUM() OVER(): Sum of values across a partition.
-- COUNT() OVER(): Count rows within a partition.
-- MIN OOVER(), MAX OVER(): Minimum/Maximum within a partition

-- Like Agrregate Window Functions, there are also some Ranking Functions, and Analytical Functions, but I am not gonna discuss them now


-- Examples:

-- Calculate average salary per department (Without collapsing rows)
SELECT *, 
    AVG(salary) OVER (PARTITION BY department) as avg_salary
FROM Employee;

-- Maximum salary per department
SELECT *, 
    MAX(salary) OVER (PARTITION BY department) as max_dept_salary
FROM Employee;






