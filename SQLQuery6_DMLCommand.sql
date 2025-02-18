USE TestDB
GO

DROP TABLE [dbo].[Address]

DROP PROC ListAZAddress

DROP TABLE [dbo].[Person]

CREATE TABLE [dbo].[Address](
AddressID INT IDENTITY(1,1)
CONSTRAINT PK_Address_AddressId PRIMARY KEY,
Address1 VARCHAR (75) NOT NULL,
City VARCHAR(75) NOT NULL,
State CHAR(3) NOT NULL,
County VARCHAR(50) NOT NULL,
PostalCode VARCHAR(10)
)

ALTER TABLE [dbo].[Address]
ALTER COLUMN County VARCHAR(50) NULL

--INSERT/VALUES
INSERT INTO Address(City, State, Address1, PostalCode)
VALUES('Houston', 'TX', '1411 Mesa Road', 77016)
--INSERT/VALUES
INSERT INTO Address(City, State, Address1, County, PostalCode)
VALUES('Baton Rouge','LA','444 Perkins Road','East Baton Rouge',70808)
--INSERT/VALUES
INSERT INTO [dbo].[Address](City, State, Address1, County, PostalCode)
OUTPUT Inserted.*
VALUES('Baton Rouge','LA','444 Perkins Road','East Baton Rouge',70808), ('Chicago','IL','8765 Buttonwood Walk','Cook',60429)

SELECT * FROM [dbo].[Address]

--INSERT/VALUES DEFAULT COLUMN LIST
INSERT INTO [dbo].[Address] VALUES('3333 Pike Street','Seattle','WA','Pike',23674)

--INSERT/VALUES WITH IDENTITY FIELD INCLUDED
SET IDENTITY_INSERT [dbo].[Address] ON
INSERT INTO [dbo].[Address](AddressID, Address1, City, State, County, PostalCode)
VALUES(999,'444 Our Way','Detroit','MI','Pike','66666')
SET IDENTITY_INSERT [dbo].[Address] OFF

--INSERT/VALUES DEFAULT COLUMN LIST
INSERT INTO [dbo].[Address]
VALUES('99934'+' Orange Ct','Memphis','TN','Vols','74944')

--INSERT/SELECT
INSERT INTO [dbo].[Address]
SELECT TOP(10) AddressLine1, City, sp.StateProvinceCode, 'Sunshine', PostalCode FROM
[AdventureWorks2019].[Person].[Address] a
INNER JOIN [AdventureWorks2019].[Person].[StateProvince] sp
ON a.StateProvinceID = sp.StateProvinceID
WHERE sp.Name = 'California'

--CREATE STORED PROCEDURE
CREATE PROC ListAZAddress
AS
SELECT TOP(10) AddressLine1, City, sp.StateProvinceCode, 'Sunshine', PostalCode
FROM [AdventureWorks2019].[Person].[Address] a
INNER JOIN
[AdventureWorks2019].[Person].[StateProvince] sp
ON
a.StateProvinceID = sp.StateProvinceID
WHERE sp.Name = 'Arizona'

--INSERT/EXEC
INSERT INTO [dbo].[Address]
EXEC ListAZAddress

--Declare variable Table
declare @address TABLE
(
Address1 VARCHAR(75) NOT NULL,
City VARCHAR(75) NOT NULL,
State CHAR(3) NULL,
County VARCHAR(50) NOT NULL,
PostalCode VARCHAR(10) NOT NULL
)

--INSERT/EXEC in variable Table
INSERT INTO @address
EXEC ListAZAddress

SELECT * FROM @address

--SELECT/INTO
SELECT BusinessEntityID, LastName, FirstName
INTO [dbo].[Person]
FROM [AdventureWorks2019].[Person].[Person]
ORDER BY LastName, FirstName


UPDATE [dbo].[Address]
SET Address1 = '1970 Mesa Road'
OUTPUT Deleted.Address1 as OldAddress, Inserted.Address1 as NewAddress
WHERE AddressID = 1

UPDATE [dbo].[Address]
SET Address1 = '1970 Napa Court'
OUTPUT Deleted.Address1 as OldAddress, Inserted.Address1 as NewAddress
WHERE AddressID = 1

UPDATE [dbo].[Address]
SET County = REPLACE(County, 'Sun', 'Sun1')
OUTPUT Deleted.County as OldCOunty, Inserted.County as NewCounty
WHERE County LIKE '%Shine'

SELECT * FROM [dbo].[Address]

SELECT County From [dbo].[Address] WHERE County LIKE '%Shine'

UPDATE [dbo].[Address]
SET County = REPLACE(County, 'Sun1', 'Sun')
OUTPUT Deleted.County as OldCOunty, Inserted.County as NewCounty
WHERE County LIKE '%Shine'

Use AdventureWorks2019
Go
ALTER TABLE [Sales].[Customer]
ADD HasPurchassed bit

Use AdventureWorks2019
Go
ALTER TABLE [Sales].[Customer]
DROP COLUMN HasPurchassed

Use AdventureWorks2019
Go
ALTER TABLE [Sales].[Customer]
ADD HasPurchased bit


Use AdventureWorks2019
Go
Update [Sales].[Customer]
SET HasPurchased = 1
FROM [Sales].[Customer] c
INNER JOIN [Sales].[SalesOrderHeader] soh
ON c.CustomerID = soh.CustomerID

Use AdventureWorks2019
Go
SELECT * FROM [Sales].[Customer]

Use AdventureWorks2019
Go
ALTER TABLE [Sales].[Customer]
DROP COLUMN HasPurchased

SELECT CAST(CAST(DATEDIFF(d,'19970101','20120625') AS DECIMAL(7,2)) /365.25 AS INT) As YrsCo
SELECT CAST(CAST(DATEDIFF(d, '19970101','20120625') AS DECIMAL(7,2)) / 365.25 * 12 AS INT) AS MoPos

DROP Table [dbo].[Product]

SELECT * 
INTO [dbo].[Product]
FROM [AdventureWorks2019].[Production].[Product]
OUTPUT Inserted.*;


SELECT * FROM [dbo].[Product]

SELECT *  FROM [dbo].[Product] p 
INNER JOIN [AdventureWorks2019].[Production].[ProductSubcategory] ps
ON p.ProductSubcategoryID = ps.ProductSubcategoryID AND ps.Name = 'Jerseys'

DELETE [dbo].[Product]  FROM [dbo].[Product] p 
INNER JOIN [AdventureWorks2019].[Production].[ProductSubcategory] ps
ON p.ProductSubcategoryID = ps.ProductSubcategoryID AND ps.Name = 'Jerseys'

DELETE FROM [dbo].[Product]
WHERE ProductSubcategoryID IN (SELECT ps.ProductSubcategoryID FROM [AdventureWorks2019].[Production].[ProductSubcategory] ps
INNER JOIN [dbo].[Product] p ON ps.ProductSubcategoryID = p.ProductSubcategoryID AND ps.Name = 'Jerseys')

DELETE FROM [dbo].[Product] 
WHERE EXISTS (SELECT * FROM [AdventureWorks2019].[Production].[ProductSubcategory] ps 
WHERE ps.ProductSubcategoryID = [dbo].[Product].ProductSubcategoryID AND ps.Name = 'Jerseys')

SELECT * FROM [dbo].[Product] p
WHERE EXISTS (SELECT * FROM [AdventureWorks2019].[Production].[ProductSubcategory] ps WHERE ps.ProductSubcategoryID = p.ProductSubcategoryID AND ps.Name = 'Jerseys')

Use TestDB
Go
UPDATE [dbo].[Address]
SET Address1='Test',City='Test',State='Test', County='Test', PostalCode=123456
WHERE AddressID = 1021