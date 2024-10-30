use sampleABG

SELECT
MIN(ALL emp_no)
FROM
employee

SELECT
MIN(DISTINCT emp_no)
FROM
employee

--sub query eith aggregate function
SELECT
emp_lname, emp_no
FROM
employee
WHERE emp_no = (
SELECT MIN(emp_no) 
FROM 
employee)

--subquery
SELECT 
emp_no
FROM
works_on
WHERE
enter_date = (
SELECT
MAX(enter_date)
FROM 
works_on
WHERE 
job = 'Manager')

--aggregate function 'SUM'
SELECT SUM(budget) sum_of_budgets
FROM project;

SELECT SUM(budget) sum_of_budgets
FROM project
GROUP BY();

--aggregate function 'AVG'
SELECT AVG(budget)
FROM project
WHERE budget > 100000;


--aggregate function COUNT(DISTINCT colname)
SELECT project_no, COUNT(DISTINCT job) job_count
FROM works_on
GROUP BY project_no;

--SELECT project_no, job 
--FROM works_on
--WHERE project_no='p1'

--SELECT project_no, COUNT(job), job
--from works_on
--GROUP BY project_no, job;

--aggregate function COUNT(*)
SELECT job, COUNT(*) job_count
FROM works_on
GROUP BY job;

--statistical aggregate function
--VAR, VARP, STDEV, STDEVP
SELECT project_no, budget, (SELECT VAR(budget)
FROM project) AS var_budget
FROM project;

SELECT project_no, budget, (SELECT VARP(budget)
FROM project) AS varp_budget
FROM project;

SELECT project_no, budget, (SELECT STDEV(budget)
FROM project) AS stdev_budget
FROM project;

SELECT project_no, budget, (SELECT STDEVP(budget)
FROM project) AS stdevp_budget
FROM project;

--HAVING clause
SELECT project_no
FROM works_on
GROUP BY project_no
HAVING COUNT(*) < 5

SELECT job
FROM works_on
GROUP BY job
HAVING job LIKE 'M%';

--ORDER BY
SELECT
emp_fname, emp_lname, dept_no
FROM employee
WHERE emp_no < 20000
ORDER BY emp_lname, emp_fname;
--ORDER BY 2,1; -- USING column index

SELECT project_no, COUNT(*) emp_quantity
FROM works_on
GROUP BY project_no
ORDER BY 2 DESC

--paging
USE AdventureWorks2019;
SELECT BusinessEntityID, JobTitle, BirthDate, ROW_NUMBER() OVER (ORDER BY BusinessEntityID) AS RowID
FROM
HumanResources.Employee
WHERE
Gender = 'F'
ORDER BY JobTitle
OFFSET 20 ROWS
FETCH NEXT 10 ROWS ONLY;

USE AdventureWorks2019;
SELECT BusinessEntityID, JobTitle, BirthDate, ROW_NUMBER() OVER (ORDER BY BusinessEntityID) AS RowID
FROM
HumanResources.Employee
WHERE
Gender = 'F'
ORDER BY JobTitle
OFFSET 30 ROWS
FETCH NEXT 10 ROWS ONLY;

USE SampleABG;
CREATE TABLE Product
(product_no INTEGER IDENTITY(10000, 1) NOT NULL,
product_name CHAR(30) NOT NULL,
price MONEY);

SELECT $identity FROM Product
WHERE product_name = 'Soap';

SELECT IDENT_SEED('Product'), IDENT_INCR('Product')

SET IDENTITY_INSERT Product ON

SET IDENTITY_INSERT Product OFF
-------------------------------------------------------------
USE sampleABG;

SELECT 
    EmployeeID, 
    Name, 
    Salary,
    CASE
        WHEN Salary < 30000 THEN 'Low'
        WHEN Salary BETWEEN 30000 AND 60000 THEN 'Medium'
        ELSE 'High'
    END AS SalaryBracket
FROM 
    Employees;
---------------------------------------------------------------------
---------------------Corelated subquery
use sampleABG

SELECT emp_lname
FROM employee
WHERE 'p3' IN
(
SELECT project_no
from works_on 
WHERE works_on.emp_no = employee.emp_no)
