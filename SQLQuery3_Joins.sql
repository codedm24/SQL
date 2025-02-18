USE AdventureWorks2019

SELECT CST.CustomerID, SOH.TotalDue
FROM Sales.Customer CST
INNER JOIN Sales.SalesOrderHeader SOH
ON CST.CustomerID = SOH.CustomerID

CREATE TABLE [dbo].[Customer](
[CustomerID] [INT] NOT NULL,
[LastName] [varchar] (50) NOT NULL);

INSERT INTO Customer(CustomerID, LastName)
VALUES(101,'Smith'),
(102,'Adams'),
(103, 'Reagan'),
(104, 'Franklin'),
(105, 'Dowdry'),
(106, 'John')

CREATE TABLE [dbo].[SalesOrder](
[OrderNumber] [varchar](50) NOT NULL,
[CustomerID] [INT] NOT NULL);

INSERT INTO SalesOrder(OrderNumber, CustomerID)
VALUES('1',101),
('2',101),
('3',102),
('4',102),
('5',103),
('6',105),
('7',105),
('8',107),
('9',108)

SELECT CST.CustomerID, OrderNumber from
Customer CST
INNER JOIN SalesOrder SO
ON SO.CustomerID = CST.CustomerID

SELECT CST.CustomerID, OrderNumber from
Customer CST
LEFT OUTER JOIN SalesOrder SO
ON SO.CustomerID = CST.CustomerID
ORDER BY CST.CustomerID

SELECT CST.CustomerID, OrderNumber from
SalesOrder SO
LEFT OUTER JOIN Customer CST
ON SO.CustomerID = CST.CustomerID
ORDER BY CST.CustomerID

SELECT CST.CustomerID, OrderNumber from
Customer CST
FULL OUTER JOIN SalesOrder SO
ON SO.CustomerID = CST.CustomerID
ORDER BY CST.CustomerID

SELECT CST.CustomerID, OrderNumber from
Customer CST
LEFT OUTER JOIN SalesOrder SO
ON SO.CustomerID = CST.CustomerID
AND CST.LastName='Adams'

SELECT CST.CustomerID, OrderNumber from
Customer CST
LEFT OUTER JOIN SalesOrder SO
ON SO.CustomerID = CST.CustomerID
WHERE CST.LastName='Adams'

CREATE TABLE Employee(
EmployeeID int PRIMARY KEY,
EmployeeName varchar(30),
MgrID int FOREIGN KEY REFERENCES Employee(EmployeeID))

INSERT INTO Employee(EmployeeID, EmployeeName, MgrID)
VALUES(1,'Janey Jones',NULL),
(2, 'Tom Smith',1),
(3, 'Ted Adams',2),
(4,'Mary Thomas',2),
(5, 'Jack Jones',2),
(6, 'Anita Kidder',3),
(7, 'William Owens',3),
(8,'Sean Watson',4),
(9, 'Brenda Jackson',5),
(10,'Frank Johnson',5)

SELECT Mgr.EmployeeName MgrName, Mgr.EmployeeID MgrEmpID,
Emp.EmployeeName EmpName, Emp.EmployeeID EmpID
FROM Employee Emp JOIN
Employee Mgr
ON Emp.MgrID = Mgr.EmployeeID

SELECT CST.CustomerID, OrderNumber from
Customer CST
CROSS JOIN SalesOrder SO

SELECT C.CustomerID, c.LastName, so.OrderNumber from
Customer C
LEFT OUTER JOIN SalesOrder SO
ON SO.CustomerID = C.CustomerID
WHERE SO.CustomerID IS NULL

SELECT C.CustomerID, c.LastName, so.OrderNumber from
Customer C
FULL OUTER JOIN SalesOrder SO
ON SO.CustomerID = C.CustomerID
WHERE C.CustomerID IS NULL OR
SO.CustomerID IS NULL

SELECT CustomerID, 'Customer - Data Source' as Source
FROM Customer
UNION
SELECT CustomerID, 'SalesOrder - DataSource'
FROM SalesOrder
ORDER BY 1

SELECT CustomerID From Customer
INTERSECT
SELECT CustomerID FROM SalesOrder

SELECT CustomerID From Customer
EXCEPT
SELECT CustomerID FROM SalesOrder
ORDER BY 1

SELECT (SELECT 3) AS SubQueryValue

SELECT pd.Name as ProductName
FROM Production.Product pd
WHERE pd.ProductSubcategoryID IN
(SELECT ProductSubcategoryID
FROM Production.ProductSubCategory
WHERE Name='Cranksets')

WITH CTEQuery(ProductSubCategoryID)
AS (SELECT ProductSubcategoryID FROM 
Production.ProductSubcategory
WHERE Name='Cranksets')
SELECT p.Name as ProductName FROM Production.Product p
JOIN CTEQuery c ON
c.ProductSubCategoryID = p.ProductSubcategoryID

SElECT pc.NAME as PrpductCategoryName, SUM(OrderQty * UnitPrice) as Sales
FROM Sales.SalesOrderDetail as SOD
INNER JOIN Production.Product as PD
ON SOD.ProductID = PD.ProductID
INNER JOIN Production.ProductSubcategory as PC
ON PC.ProductSubcategoryID = PD.ProductSubcategoryID
GROUP BY PC.Name
ORDER BY COUNT(*) DESC

SELECT Name as ProductName FROM Production.Product
WHERE ProductID IN(
SELECT ProductID FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (
SELECT SalesOrderID From Sales.SalesOrderDetail
WHERE ProductID IN(
SELECT ProductID From Production.Product
WHERE ProductSubcategoryID =(
SELECT ProductSubCategoryID FROM Production.ProductSubcategory
WHERE Name = 'Vests'))))

SELECT p1.Name, a.ProductID, a.ProductTotal, a.ModifiedDate
FROM Production.Product p1
JOIN (
SELECT sod.ProductID, SUM(sod.LineTotal) as ProductTotal, sod.ModifiedDate
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p
ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory pc
ON pc.ProductSubcategoryID = p.ProductSubcategoryID
WHERE pc.Name = 'Vests'
GROUP BY sod.ProductID, sod.ModifiedDate) a
ON p1.ProductID = a.ProductID

SELECT 'True' as AllTest
WHERE 1 < ALL (
SELECT a FROM (VALUES (2),(3),(5),(7),(9)) AS ValuesTable(a))

SELECT 'True' as AllTest
WHERE 1 < ALL (
SELECT a FROM (VALUES (2),(3),(5),(7),(9), (null)) AS ValuesTable(a))

SELECT 'True' as AllTest
WHERE 5 = SOME (
SELECT a FROM (VALUES (2),(3),(5),(7),(9), (null)) AS ValuesTable(a))

SELECT 'True' as AllTest
WHERE 5 = ANY (
SELECT a FROM (VALUES (2),(3),(5),(7),(9), (null)) AS ValuesTable(a))

SELECT p.ProductID, p.ProductSubCategoryID, p.Name, ListPrice FROM Production.Product p
WHERE ListPrice < (
SELECT SUM(OrderQty * UnitPrice) / SUM(sod.OrderQty)
AS AveragePricePerItemInCategory
FROM Sales.SalesOrderDetail as SOD
INNER JOIN
Production.Product  as PD
ON PD.ProductID = SOD.ProductID
INNER JOIN 
Production.ProductSubcategory as PC
ON PD.ProductSubcategoryID = PC.ProductSubcategoryID
WHERE PC.ProductSubcategoryID = p.ProductSubcategoryID
GROUP BY pc.Name)

/*return XML*/
SELECT p.ProductID, p.ProductSubCategoryID, p.Name, ListPrice FROM Production.Product p
WHERE ListPrice < (
SELECT SUM(OrderQty * UnitPrice) / SUM(sod.OrderQty)
AS AveragePricePerItemInCategory
FROM Sales.SalesOrderDetail as SOD
INNER JOIN
Production.Product  as PD
ON PD.ProductID = SOD.ProductID
INNER JOIN 
Production.ProductSubcategory as PC
ON PD.ProductSubcategoryID = PC.ProductSubcategoryID
WHERE PC.ProductSubcategoryID = p.ProductSubcategoryID
GROUP BY pc.Name) FOR XML AUTO

CREATE TABLE TableA(ID INT);
INSERT INTO TableA(ID)
VALUES(1),(2);

CREATE TABLE TableB(ID INT);
INSERT INTO TableB(ID)
VALUES (1),(3);

SELECT B.ID as Bid, A.ID as Aid
FROM TableB AS B
CROSS APPLY
(SELECT ID From TableA
where TableA.ID = B.ID) AS A

SELECT B.ID as Bid, A.ID as Aid
FROM TableB AS B
OUTER APPLY
(SELECT ID From TableA
where TableA.ID = B.ID) AS A