USE sampleABG

CREATE INDEX i_empno ON employee(emp_no);

USE sampleABG
CREATE UNIQUE INDEX i_empno_prno 
ON works_on(emp_no, project_no)
WITH FILLFACTOR=80;

SELECT * FROM sys.indexes