USE sampleABG
GO

CREATE PROCEDURE modify_empno(
@old_no INTEGER,
@new_no INTEGER
)
AS
	BEGIN
		UPDATE employee
		SET
			emp_no = @new_no
			WHERE emp_no = @old_no
		UPDATE works_on
		SET
			emp_no = @new_no
			WHERE emp_no = @old_no
	END
GO
