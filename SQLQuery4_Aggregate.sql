SELECT COUNT(*) AS NumRows
FROM [Sales].[SalesOrderHeader]

SELECT ProductID, SUM(UnitPrice * OrderQty) AS Total
FROM [Sales].[SalesOrderDetail] 
GROUP BY ProductID
ORDER BY Total 

SELECT SUM(TotalDue) AS [SUM],
		AVG(TotalDue) AS [AVG],
		MIN(TotalDue) AS [MIN],
		MAX(TotalDue) AS [MAX]
		FROM [Sales].[SalesOrderHeader]

SELECT st.CountryRegionCode, SUM(TotalDue) TotalSalesDue
FROM [Sales].[SalesOrderHeader] soh
INNER JOIN [Sales].[SalesTerritory] st
ON soh.TerritoryID = st.TerritoryID
GROUP BY st.CountryRegionCode

SELECT Year(DueDate) AS DueYear, st.[Group],
SUM(TotalDue) TotalSalesAmount
FROM [Sales].[SalesOrderHeader] soh
INNER JOIN [Sales].[SalesTerritory] st
ON soh.TerritoryID = st.TerritoryID
GROUP BY Year(DueDate), st.[Group]
ORDER BY Year(DueDate)

SELECT NULL AS DueYear, st.[Group],
SUM(TotalDue) AS TotalSalesAmount
FROM [Sales].[SalesOrderHeader] soh
INNER JOIN [Sales].[SalesTerritory] st
ON soh.TerritoryID = st.TerritoryID
GROUP BY st.[Group]
UNION
SELECT Year(DueDate) AS DueYear, NULL [Group],
SUM(TotalDue) FROM [Sales].[SalesOrderHeader] soh
INNER JOIN [Sales].[SalesTerritory] st
ON soh.TerritoryID = st.TerritoryID
GROUP BY Year(DueDate)

SELECT Year(DueDate) DueYear, st.[Group],
SUM(TotalDue) AS TotalSalesAmount
FROM [Sales].[SalesOrderHeader] soh
INNER JOIN [Sales].[SalesTerritory] st
ON soh.TerritoryID = st.TerritoryID
GROUP BY 
GROUPING SETS(Year(DueDate),st.[Group])

SELECT st.CountryRegionCode, SUM(TotalDue) TotalSalesAmount
FROM [Sales].[SalesOrderHeader] soh
INNER JOIN [Sales].[SalesTerritory] st
ON soh.TerritoryID = st.TerritoryID
GROUP BY st.CountryRegionCode
HAVING SUM(TotalDue) > 10000000

SELECT ROW_NUMBER() OVER(ORDER BY ShipDate) AS RowNumber,
PurchaseOrderID, ShipDate FROM [Purchasing].[PurchaseOrderHeader]
WHERE EmployeeID = 259
ORDER BY RowNumber

SELECT ROW_NUMBER() OVER(PARTITION BY Year(ShipDate), Month(ShipDate)
ORDER BY ShipDate) AS RowNumber, PurchaseOrderID, ShipDate
FROM [Purchasing].[PurchaseOrderHeader]
WHERE EmployeeID = 259
ORDER BY ShipDate

WITH Results
AS(
SELECT ROW_NUMBER() OVER(ORDER BY PurchaseOrderID, ShipDate) AS RowNumber,
PurchaseOrderID, ShipDate FROM Purchasing.PurchaseOrderHeader)
SELECT * FROM Results WHERE RowNumber BETWEEN 21 AND 40

SELECT ROW_NUMBER() OVER(ORDER BY PurchaseOrderID, ShipDate) AS RowNumber,
PurchaseOrderID, ShipDate FROM [Purchasing].[PurchaseOrderHeader]
ORDER BY RowNumber 
OFFSET 20 ROWS
FETCH NEXT 20 ROWS ONLY

SELECT ProductID, COUNT(*) as [Count]
FROM [Sales].[SalesOrderDetail]
GROUP BY ProductID
ORDER BY COUNT(*)

SELECT ProductID, SalesCount, 
RANK() OVER (ORDER By SalesCount) as [RANK],
DENSE_RANK() OVER (Order By SalesCount) as [DenseRank]
FROM (SELECT ProductID, COUNT(*) AS SalesCount FROM [Sales].[SalesOrderDetail]
GROUP BY ProductID) AS Q
ORDER BY [Rank]

SELECT ProductID, SalesCount, NTILE(100) OVER(ORDER BY SalesCount) AS Percentile
FROM (SELECT ProductID, COUNT(*) AS SalesCount FROM [Sales].[SalesOrderDetail]
GROUP BY ProductID) AS Q
ORDER BY Percentile DESC

