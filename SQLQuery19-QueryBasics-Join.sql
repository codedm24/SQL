use sampleABG

-- Records of both the tables, if UNION ALL duplicate rows are also selected
SELECT emp_no
FROM employee
WHERE dept_no = 'd1'
UNION 
SELECT emp_no
FROM works_on
WHERE enter_date < '01.01.2017'
ORDER BY 1

-- Records that belong two both the tables
SELECT emp_no
FROM employee
WHERE dept_no = 'd1'
INTERSECT
SELECT emp_no
FROM works_on
WHERE enter_date < '01.01.2018'

-- Records from first table that do not exist in second table
SELECT emp_no
FROM employee
WHERE dept_no = 'd1'
INTERSECT
SELECT emp_no
FROM works_on
WHERE enter_date < '01.01.2018'
-------------------------------------------------------------------------------------
USE AdventureWorks2019;
GO
SELECT ProductNumber, Category =
CASE ProductLine
WHEN 'R' THEN 'Road'
WHEN 'M' THEN 'Mountain'
WHEN 'T' THEN 'Touring'
WHEN 'S' THEN 'Other sale items'
ELSE 'Not for sale'
END,
Name
FROM Production.Product
ORDER BY Category;
GO

USE sampleABG;
GO
SELECT project_name,
CASE 
	WHEN budget > 0 AND budget < 100000 THEN 1
	WHEN budget >= 100000 AND budget < 200000 THEN 2
	WHEN budget >= 200000 AND budget < 300000 THEN 3
	ELSE 4
	END budget_weight
FROM project;
GO
--------------------------------------------------------------------------------------
------------------------------SubQuery------------------------------------------------
--------------------------------------------------------------------------------------
USE sampleABG;
GO
SELECT emp_fname, emp_lname
FROM employee
WHERE dept_no =
(select dept_no
FROM department
WHERE dept_name = 'Research');
GO

--same query using JOIN
USE sampleABG;
GO
SELECT emp_fname, emp_lname
FROM employee
JOIN
department ON employee.dept_no = department.dept_no
WHERE department.dept_name = 'Research'
GO

USE sampleABG;
GO
SELECT *
FROM
employee
WHERE dept_no IN
(SELECT dept_no 
FROM department
WHERE location = 'Dallas');
GO

USE sampleABG;
GO
SELECT emp_lname
FROM employee
WHERE
emp_no IN
(SELECT emp_no
FROM works_on
WHERE project_no IN
(SELECT project_no
FROM project
WHERE project_name = 'Apollo'))
GO
-- ===========================================================
USE sampleABG;
CREATE TABLE #project_temp
(project_no CHAR(40) NOT NULL,
project_name CHAR(25) NOT NULL);

USE sampleABG;
SELECT project_no, project_name INTO
#project_temp1
FROM
project;

--===========================

USE sampleABG

SELECT employee.*, department.*
FROM employee INNER JOIN department
ON employee.dept_no = department.dept_no

SELECT employee.*, department.*
FROM employee, department
WHERE employee.dept_no = department.dept_no

--===========================================
USE sampleABG

SELECT emp_no, project.project_no, job, enter_date, project_name, budget
FROM works_on JOIN
project
ON
works_on.project_no = project.project_no
WHERE project_name = 'Gemini'
GO
------------------------
--Old style

USE sampleABG

SELECT emp_no, project.project_no, job, enter_date, project_name, budget
FROM works_on, project
WHERE
works_on.project_no = project.project_no
AND project_name = 'Gemini'
GO

--------------------------------------------------------------------------
USE sampleABG

SELECT dept_no
FROM employee
JOIN
works_on
ON employee.emp_no = works_on.emp_no
WHERE enter_date = '10.15.2017'
-------------------------------------------------------------------------
USE sampleABG

SELECT emp_fname, emp_lname
FROM works_on 
JOIN
employee
ON
works_on.emp_no = employee.emp_no
JOIN
department 
ON
department.dept_no = employee.dept_no
--AND location ='Seattle'
--AND job = 'analyst'
WHERE
location ='Seattle'
AND job = 'analyst'

-----------------------------------------------------
USE sampleABG

SELECT DISTINCT project_name
FROM
project  
JOIN
works_on
ON
project.project_no = works_on.project_no
JOIN
employee 
ON
works_on.emp_no = employee.emp_no
JOIN
department
ON
employee.dept_no = department.dept_no
WHERE
dept_name = 'Accounting'
GO
------------------------------------------------
USE sampleABG

SELECT employee_enh.*, department.location
FROM employee_enh
JOIN
department
ON
domicile = location
--------------------------------------------------
USE sampleABG

SELECT employee_enh.*, department.location
FROM
employee_enh
LEFT OUTER JOIN
department
ON
domicile = location;
GO
--------------------------------------------------
USE sampleABG

SELECT employee_enh.domicile, department.*
FROM
employee_enh
RIGHT OUTER JOIN
department
ON
domicile = location;
GO
-------------------------------------------------
USE sampleABG

SELECT employee_enh.domicile, department.location
FROM
employee_enh
FULL OUTER JOIN
department
ON
domicile = location
GO
---------------------------------------------------
USE sampleABG

SELECT employee_enh.*, department.location
FROM employee_enh
JOIN
department
ON
domicile = location
UNION
SELECT employee_enh.*, 'NULL'
FROM
employee_enh
WHERE
NOT EXISTS
(SELECT * FROM 
department
WHERE location = domicile)
-----------------------------------------
USE sampleABG

SELECT * 
FROM
employee
LEFT JOIN
department
ON
employee.dept_no = department.dept_no
--------------------------------------------
-------------- Theeta join-------------------
use sampleABG
SELECT emp_fname, emp_lname, domicile, location
FROM employee_enh JOIN
department
ON domicile < location
-----------------------------------------------------
-------------------Self join
use sampleABG

SELECT t1.dept_no, t1.dept_name, t1.location
FROM department t1 
JOIN department t2
ON
t1.location = t2.location
WHERE
t1.dept_no <> t2.dept_no
-------------------------------------------------
---Semi Join
use sampleABG

SELECT emp_no, emp_lname, e.dept_no
FROM employee e JOIN
department d
ON
e.dept_no = d.dept_no
WHERE
location = 'Dallas'