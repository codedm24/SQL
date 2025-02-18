use sampleABG;

ALTER TABLE department
ADD CONSTRAINT prim_dept PRIMARY KEY(dept_no)

ALTER TABLE employee
ADD CONSTRAINT prim_emp PRIMARY KEY(emp_no)

ALTER TABLE employee
ADD CONSTRAINT foreign_emp FOREIGN KEY(dept_no) REFERENCES department(dept_no)

ALTER TABLE project
ADD CONSTRAINT prim_proj PRIMARY KEY(project_no)

--DELETE FROM employee WHERE emp_no IN (11111,22222,33333)

--DELETE FROM works_on WHERE emp_no IN(
--SELECT emp_no FROM works_on WHERE emp_no NOT IN(
--SELECT emp_no FROM employee))

ALTER TABLE works_on
ADD CONSTRAINT prim_works PRIMARY KEY(emp_no,project_no)

ALTER TABLE works_on
ADD CONSTRAINT foreign1_works FOREIGN KEY([emp_no]) REFERENCES employee([emp_no])

ALTER TABLE works_on
ADD CONSTRAINT foreign2_works FOREIGN KEY(project_no) REFERENCES project(project_no)

BEGIN TRY
	BEGIN TRANSACTION
	INSERT INTO employee VALUES(11111,'Ann','Smith','d2');
	INSERT INTO employee VALUES(22222,'Mathew','Jones','d4');
	--referential integrity error
	INSERT INTO employee VALUES(33333,'John','Barrimore','d7');
	COMMIT TRANSACTION
	PRINT 'Transaction committed'
END TRY
BEGIN CATCH
	ROLLBACK
	PRINT 'Transaction rolled back';
	THROW
END CATCH
