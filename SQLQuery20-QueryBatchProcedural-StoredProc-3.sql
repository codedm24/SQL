USE sampleABG
GO
CREATE PROCEDURE delete_emp(
@employee_no INT,
@counter INT OUTPUT
)
AS
	BEGIN
		SELECT @counter = COUNT(*)
		FROM works_on
		WHERE emp_no = @employee_no;

		DELETE FROM employee
		WHERE emp_no = @employee_no;

		DELETE FROM works_on
		WHERE emp_no = @employee_no;
	END
GO

DECLARE @quantity INT;
EXECUTE delete_emp @employee_no = 234459, @counter = @quantity OUTPUT;