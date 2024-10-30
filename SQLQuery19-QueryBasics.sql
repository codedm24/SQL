USE sampleABG;

SELECT dept_name, dept_no
FROM department
WHERE location='Dallas'

SELECT emp_no, emp_fname, emp_lname
FROM employee
WHERE emp_no IN (29346,28559, 25348)

SELECT emp_no, emp_fname, emp_lname
FROM employee
WHERE emp_no NOT IN (10102, 9031)

SELECT project_name, budget
FROM project
WHERE
budget BETWEEN 95000 AND 120000

SELECT project_name, budget
FROM project
WHERE
budget NOT BETWEEN 95000 AND 120000

SELECT emp_no, project_no
FROM works_on
WHERE project_no = 'p2'
AND job IS NULL

SELECT emp_no, ISNULL(job, 'Job unknown') AS task
FROM works_on
WHERE project_no = 'p1'

--single character matching using '_'
SELECT emp_fname, emp_lname, emp_no
FROM 
employee
WHERE
emp_fname LIKE '_a%';

--range matching
SELECT dept_no, dept_name, location
FROM department
WHERE 
location LIKE '[C-F]%';

--negation pattern 
SELECT emp_no, emp_fname, emp_lname
FROM 
employee
WHERE emp_lname LIKE '[^J-O]%'
AND emp_fname LIKE '[^EZ]%';

--not ends with
SELECT emp_no, emp_fname, emp_lname
FROM 
employee
WHERE
emp_fname NOT LIKE '%n'

--search wildcard character itself
SELECT project_no, project_name
FROM
project
WHERE project_name LIKE '%[_]%';

SELECT project_no, project_name
FROM
project
WHERE
project_name LIKE '%!_%' ESCAPE '!';

SELECT job 
FROM
works_on
GROUP BY job;

SELECT 
project_no, job
FROM
works_on
GROUP BY project_no, job


---------------------------------------------------------------
USE sampleABG;

CREATE table dbo.table1(
column1 INT PRIMARY KEY NOT NULL,
column2 char(10));

INSERT INTO table1(column1,column2) 
VALUES(NEXT VALUE FOR sequence1,'A')
INSERT INTO table1(column1,column2)
VALUES(NEXT VALUE FOR sequence1,'B')

SELECT * FROM table1

SELECT CURRENT_VALUE 
FROM sys.sequences
WHERE name='sequence1'

DROP SEQUENCE sequence1
------------------------------------------------------------------------
USE sampleABG;
SELECT emp_no, emp_fname, emp_lname, dept_no
INTO employee_enh
FROM employee;


ALTER TABLE employee_enh
	ADD domicile CHAR(25) NULL;

SELECT * 
FROM employee_enh;

ALTER TABLE employee_enh
	ALTER COLUMN domicile CHAR(30) NULL;

ALTER TABLE employee_Enh
	DROP COLUMN domicile;

ALTER TABLE employee_enh
	ADD domicile CHAR(25) NULL;

UPDATE employee_enh
SET domicile = 'San Antonio'
WHERE emp_no = 25348;

UPDATE employee_enh
SET domicile = 'Houston'
WHERE emp_no = 10102;

UPDATE employee_enh
SET domicile = 'San Antonio'
WHERE emp_no = 18316;

UPDATE employee_enh
SET domicile = 'Seattle'
WHERE emp_no = 29346;

UPDATE employee_enh
SET domicile = 'Portland'
WHERE emp_no = 2581;

UPDATE employee_enh
SET domicile = 'Taacoma'
WHERE emp_no = 9031;

UPDATE employee_enh
SET domicile = 'Houston'
WHERE emp_no = 28559;

SELECT domicile
FROM employee_enh
UNION ALL
SELECT location
FROM department
-------------------------------------------------------------
CREATE SEQUENCE dbo.sequence1
AS INT
START WITH 1
INCREMENT BY 5
MINVALUE 1 MAXVALUE 256
CYCLE;

SELECT NEXT VALUE FOR sequence1
SELECT NEXT VALUE FOR sequence1

ALTER SEQUENCE sequence1
RESTART WITH 1;
SELECT NEXT VALUE FOR sequence1
SELECT NEXT VALUE FOR sequence1
-----------------------------------------------------------


