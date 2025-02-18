use mydemodatabase1

IF(SELECT COUNT(*) FROM works_on WHERE project_no='p1'
GROUP BY project_no) >3
	PRINT 'The number of employees in the project p1 is 4 or more'
ELSE
	BEGIN
		PRINT('The following empoyees work for the project p1')
		SELECT emp_fname, emp_lname
		FROM employee, works_on
		WHERE employee.emp_no= works_on.emp_no
		AND project_no = 'p1'

	END
GO

USE mydemodatabase1;

WHILE(SELECT SUM(budget) FROM project) < 500000
	BEGIN
		UPDATE project SET budget = budget * 1.1
		IF(SELECT MAX(budget) FROM project) > 240000
			BREAK
		ELSE
			CONTINUE
	END
GO

--SET oriented processing
USE mydemodatabase1

DECLARE @avg_budget MONEY, @extra_budget MONEY
DECLARE @pr_nr CHAR(4)
	SET @extra_budget = 15000
	SELECT @avg_budget = AVG(budget) FROM project
	IF(SELECT budget FROM project WHERE project_no=@pr_nr) < @avg_budget
		BEGIN
			UPDATE project 
				SET budget = budget + @extra_budget
				WHERE project_no = @pr_nr
			PRINT 'Budget for @pr_nr increased by @extra_budget'
		END
GO	

--Record oriented processing
use mydemodatabase1

DECLARE @avg_budget MONEY;
DECLARE @extra_budget MONEY;
DECLARE @budget MONEY;
DECLARE @pr_nr CHAR(4);
DECLARE @p_cursor CURSOR;
SET @extra_budget = 15000
SELECT @avg_budget = AVG(budget) FROM budget;
SET @budget = 0;
SET @P_cursor = CURSOR FOR 
		SELECT project_no, budget FROM project;
OPEN @P_cursor;
FETCH NEXT FROM @P_cursor INTO @pr_nr, @budget
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @pr_nr
	PRINT @budget
	IF(SELECT budget FROM project WHERE project_no=@pr_nr) >= @avg_budget
		BEGIN
			GOTO L1
		END
	ELSE
		UPDATE project 
		SET budget = budget + @extra_budget
		WHERE project_no = @pr_nr
		PRINT 'Budget for @pr_nr increased'
L1:
	FETCH NEXT FROM @P_cursor INTO @pr_nr, @budget
END
CLOSE @P_cursor;
DEALLOCATE @p_cursor;
GO;

	