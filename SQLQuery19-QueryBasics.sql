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
