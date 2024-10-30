---Subquery
USE sampleABG

SELECT emp_lname
FROM employee
WHERE EXISTS(
SELECT * 
FROM works_on
WHERE
employee.emp_no = works_on.emp_no
AND project_no = 'p1'
)
GO

USE sampleABG
SELECT emp_lname
FROM employee
WHERE NOT EXISTS
(SELECT *
FROM department
WHERE employee.dept_no = department.dept_no
AND department.location = 'Seattle'
)