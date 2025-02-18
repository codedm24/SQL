use sampleABG
--IF statement, block using BEGIN-END
IF (SELECT COUNT(*) 
	FROM works_on 
	WHERE project_no = 'p1'
	GROUP BY project_no) > 3
	PRINT 'The number of employees in the project p1 is 4 or more'
ELSE
	BEGIN
		PRINT 'The following employees work for the project p1'
		SELECT * 
		FROM employee, works_on
		WHERE employee.emp_no = works_on.emp_no
		AND project_no = 'p1'
	END

--WHILE statement
use sampleABG
WHILE (SELECT SUM(budget) FROM project) < 500000
	BEGIN
		UPDATE project SET budget = budget * 1.1
		IF (SELECT MAX(budget) FROM project) > 240000
			BREAK
		ELSE
			CONTINUE
	END

--USING variable within query or transact sql
USE sampleABG

DECLARE @avg_budget MONEY, @extra_budget MONEY
DECLARE @pr_nr CHAR(4)

SET @extra_budget = 15000
SELECT @avg_budget = AVG(budget) FROM project

IF (SELECT budget FROM project WHERE project_no = @pr_nr) < @avg_budget
	BEGIN
		UPDATE project
		SET budget = budget + @extra_budget
		WHERE project_no = @pr_nr
		PRINT 'Budget for @pr_nr increased by @extra_budget'
	END

--using CURSOR
USE sampleABG

DECLARE @avg_budget1 MONEY;
DECLARE @extra_budget1 MONEY;
DECLARE @budget MONEY;
DECLARE @pr_nr1 CHAR(4);
DECLARE @P_cursor as CURSOR;
SET @extra_budget1 = 15000
SELECT @avg_budget1 = AVG(budget) FROM project;
SET @budget = 0;
SET @P_cursor = CURSOR FOR
				SELECT project_no, budget from project;
OPEN @P_cursor;
FETCH NEXT FROM @P_cursor INTO @pr_nr1, @budget
WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT @pr_nr1
		PRINT @budget
		IF (SELECT budget FROM project WHERE project_no = @pr_nr1) >= @avg_budget1
			BEGIN
				GOTO L1
			END
		ELSE
			UPDATE project SET budget = budget + @extra_budget1
			WHERE project_no = @pr_nr1
			PRINT 'Budget for @pr_nr1 incresed'
	L1:
		FETCH NEXT FROM @P_cursor INTO @pr_nr1, @budget
	END
	CLOSE @P_cursor;
	DEALLOCATE @P_cursor;


