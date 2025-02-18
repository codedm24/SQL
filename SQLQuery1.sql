use AdventureWorks2019
SELECT NAME FROM Person.StateProvince WHERE StateProvinceCode IN ('NC','WV')
SELECT NAME FROM Person.StateProvince WHERE StateProvinceCode NOT IN ('NC','WV')
SELECT * FROM Person.StateProvince
SELECT FirstName, LastName FROM Person.Person WHERE 'Ken' IN (FirstName, LastName)
SELECT 'IN' WHERE 'A' NOT IN ('B',NULL)
SELECT Name FROM Production.Product WHERE Name LIKE 'Chain%'
SELECT Name FROM Person.StateProvince WHERE Name LIKE '[d-f]%'
SELECT ProductID, Name FROM Production.Product WHERE Name like 'Chain%' OR ProductID BETWEEN 320 AND 324
AND Name like '%s%'
SELECT Name as ProductName, 'abc', SellStartDate + 365 OneYearSellStartDate From Production.Product
CREATE TABLE t1 (col1 INT);
CREATE TABLE t2 (col1 INT);
SELECT col1 FROM t1 CROSS JOIN t2;
SELECT t1.col1 FROM t1 CROSS JOIN t2;
SELECT LASTNAME + ', ' + FirstName AS FullName From Person.Person ORDER BY LASTNAME + ', ' + FirstName
SELECT Description, LEN(Description) as TextLength FROM Production.ProductDescription WHERE Description LIKE 'Replacement%'
ORDER BY 
CASE
WHEN LEFT(Description,5)='This'
THEN Stuff(Description, 1, 5, '')
ELSE
Description
END;

SELECT p.FIRSTNAME + ' ' + p.LASTNAME CustomerName,
DATEDIFF(DD,OrderDate,ShipDate) DaysDiff
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.Customer c
on soh.CustomerID = c.CustomerID
INNER JOIN Person.Person p
ON c.PersonID = p.BusinessEntityID