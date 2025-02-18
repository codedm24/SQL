CREATE VIEW dbo.vEmployeeList
AS
SELECT p.BusinessEntityID, p.Title, p.LastName, p.FirstName, E.JobTitle
FROM Person.Person p
INNER JOIN
HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID

ALTER VIEW [dbo].[vEmployeeList](ID, Title, Last, First, Job)
AS
SELECT p.BusinessEntityID, p.Title, p.LastName, p.FirstName, E.JobTitle
FROM Person.Person p
INNER JOIN
HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID
GO

SELECT * FROM sys.dm_sql_referencing_entities
('dbo.vEmployeeList','Object')