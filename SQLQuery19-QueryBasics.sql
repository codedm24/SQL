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

