use sampleABG

INSERT INTO employee(emp_no,emp_fname,emp_lname)
VALUES(15201,'Dave','Davis')

use sampleABG

CREATE TABLE dallas_dept
(dept_no char(4) NOT NULL,
dept_name CHAR(20) NOT NULL);

INSERT INTO dallas_dept(dept_no,dept_name)
SELECT dept_no, dept_name from department
WHERE location = 'Dallas'
GO;

use sampleABG
SELECT * FROM dallas_dept

use sampleABG

CREATE TABLE clerk_t(emp_no INT NOT NULL,
project_no CHAR(4),
enter_date DATE);

INSERT INTO clerk_t(emp_no,project_no,enter_date)
SELECT emp_no, project_no, enter_date
FROM works_on
WHERE job = 'Clerk'
AND project_no='p2'
GO;

use sampleABG

INSERT INTO department
VALUES
('d4','Human Resources','Chicago'),
('d5','Distribution','New Orleans'),
('d6','Sales','Chicago');
GO

use sampleABG

UPDATE works_on 
SET job = 'Manager'
WHERE emp_no = 18316
AND project_no = 'p2'
GO

use sampleABG
UPDATE project
SET budget = budget*0.51
GO

use sampleABG

UPDATE works_on
SET job = NULL
WHERE emp_no IN
(SELECT emp_no FROM employee
WHERE emp_lname = 'Jones')
GO

use sampleABG

UPDATE works_on
SET job = NULL
FROM works_on, employee
WHERE emp_lname = 'Jones'
AND works_on.emp_no =employee.emp_no
GO

use sampleABG;

UPDATE project
SET budget = CASE
	WHEN budget > 0 and budget < 100000 THEN budget*1.2
	WHEN budget > 100000 and budget < 200000 THEN budget*1.1
	ELSE budget*1.05
	END
GO

use sampleABG 
SELECT * INTO works_on_duplicate 
FROM works_on
GO

use sampleABG
DELETE FROM works_on
WHERE emp_no 
IN
(SELECT emp_no 
	FROM employee
	WHERE emp_lname = 'Moser')

DELETE FROM employee
WHERE emp_lname = 'Moser'
GO


use sampleABG

DELETE works_on 
FROM works_on, employee
WHERE works_on.emp_no = employee.emp_no
AND emp_lname = 'Moser'
GO

use sampleABG

CREATE TABLE bonus
(pr_no CHAR(4),
bonus SMALLINT DEFAULT 100);
INSERT INTO bonus(pr_no) VALUES('p1');

use sampleABG

SELECT * INTO employee_duplicate
FROM employee
GO

use sampleABG
DECLARE @del_table TABLE (emp_no INT, emp_lname CHAR(20));
DELETE employee
OUTPUT DELETED.emp_no,Deleted.emp_lname INTO @del_table
WHERE emp_no > 15000
SELECT * FROm @del_table;
GO


USE sampleABG
DECLARE @update_table TABLE
(emp_no INT, project_no CHAR(20), old_job char(20), new_job CHAR(20));
UPDATE works_on
SET job = NULL
OUTPUT Deleted.emp_no, Deleted.project_no, Deleted.job, INSERTED.job
INTO @update_table
WHERE job = 'Clerk';
SELECT * FROM @update_table;
GO
GO