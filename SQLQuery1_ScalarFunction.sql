SELECT USER_NAME()	
SELECT SUSER_SNAME()
SELECT HOST_NAME()
SELECT APP_NAME()

SELECT GETDATE()
SELECT CURRENT_TIMESTAMP
SELECT GETUTCDATE()
SELECT SYSDATETIME()
SELECT SYSUTCDATETIME()
SELECT SYSDATETIMEOFFSET()

SELECT DATEADD("DAY",5,GETDATE())

declare @newDate  DATETIME
SET @newDate = DATEADD("DAY",5,GETDATE())
SELECT DATEDIFF("DAY",GETDATE(),@newDate)

SELECT DATENAME(YEAR, CURRENT_TIMESTAMP)
SELECT DATEPART(YEAR, CURRENT_TIMESTAMP)

SELECT CONVERT(char(10),GETDATE(),112)

SELECT TODATETIMEOFFSET(CURRENT_TIMESTAMP, '-07:00')

SELECT EOMONTH(GETDATE(),5)

SELECT DATEFROMPARTS(2000,1,31)

declare @strVariable VARCHAR(100)
SET @strVariable = 'These are string functions'

SELECT SUBSTRING(@strVariable,1,10) as Substring

SELECT STUFF(@strVariable,11,0,'SQL ') as Stuff

SELECT CHARINDEX('STRING',@strVariable, 5) as CharIndex

SELECT PATINDEX('%ARE%', @strVariable) as PatIndex

SELECT RIGHT(@strVariable, 5) as 'Right'

SELECT LEFT(@strVariable, 5) as 'Left'

SELECT LEN(@strVariable) as Len

SELECT RTRIM(@strVariable) as Rtrim

SELECT LTRIM(@strVariable) as Ltrim

SELECT UPPER(@strVariable) as Upper

SELECT LOWER(@strVariable) as Lower

SELECT REPLACE(@strVariable,'SQL','') AS Replace

declare @nameVar varchar(100)
set @nameVar = 'Chain Stay''s'
SELECT @nameVar
SELECT REPLACE(@nameVar,'''','')

SELECT CONCAT('Patrick ','LeBlanc') Results
SELECT CONCAT(null, 1 , ' Patrick ','LeBlanc') Results

declare @myMoney decimal(5,2) = 10.52
SELECT FORMAT(@myMoney, 'C','en-US')

use AdventureWorks2019
SELECT LastName, FirstName FROM Person.Person WHERE SOUNDEX('Andersen')= SOUNDEX(LASTNAME)

SELECT CURRENT_TIMESTAMP as RawDate, CONVERT(nvarchar(25),CURRENT_TIMESTAMP,100) as Date100,
CONVERT(nvarchar(25), CURRENT_TIMESTAMP, 1) as Date1

SELECT STR(123,6,2) as [str]

SELECT PARSE('123' as INT) as Parsed

SELECT TRY_PARSE('123' as datetime) as TryParse

SELECT DB_NAME()

SELECT SERVERPROPERTY('ServerName') as ServerName,
		SERVERPROPERTY('Edition') as Edition,
		SERVERPROPERTY('ProductVersion') as 'ProductVersion',
		SERVERPROPERTY('ProductLevel') as ProductLevel