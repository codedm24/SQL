--E.6.1
use sampleABG;

SELECT * FROM works_on
GO;

--E.6.2
USE sampleABG;

SELECT emp_no 
FROM
works_on
WHERE job = 'Clerk'
GO;

--E.6.3
USE sampleABG;

SELECT emp_no 
FROM 
works_on w
WHERE EXISTS(
SELECT *
from 
employee e
WHERE e.emp_no = w.emp_no
)
AND w.project_no = 'p2'
GO

--E.6.4
USE sampleABG;

SELECT emp_no 
FROM employee e
WHERE EXISTS(
SELECT * 
FROM works_on w 
WHERE YEAR(enter_date) <> '2017'
AND w.emp_no = e.emp_no)
GO