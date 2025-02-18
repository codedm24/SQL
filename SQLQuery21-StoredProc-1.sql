USE sampleABG
GO
CREATE TYPE departmentType AS TABLE
	(dept_no CHAR(4), dept_name CHAR(25), location CHAR(30));
GO

CREATE TABLE #dallasTable
	(dept_no CHAR(4), dept_name CHAR(25), location CHAR(30));
GO

CREATE PROCEDURE insertDoc
	@Dallas departmentType READONLY
AS
	BEGIN
		SET NOCOUNT ON
		INSERT INTO #dallasTable(dept_no, dept_name, location)
		SELECT * FROM @Dallas
	END
DECLARE @dallas1 AS departmentType
INSERT INTO @dallas1(dept_no, dept_name, location)
SELECT * FROM department
WHERE location ='Dallas'
EXEC insertDoc @dallas1
SELECT * FROM #dallasTable
DROP TABLE #dallasTable