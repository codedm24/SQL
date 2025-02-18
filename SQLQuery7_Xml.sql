CREATE TABLE ItemInfo(
[OrderID] [INT] NOT NULL,
[ItemData] Xml NULL
)

DECLARE @var xml
SET @var ='<Order OrderID="1">
	<Item>
	<ItemNumber>V001</ItemNumber>
	<Quantity>1</Quantity>
	<Price>299.99</Price>
	</Item>
	</Order>'

	INSERT INTO ItemInfo
	VALUES(1,@var)

	CREATE XML SCHEMA COLLECTION OrderInfoSchemaCollection AS
	N'<?xml version="1.0" encoding="utf-16"?>
<xs:schema id="NewDataSet" xmlns="" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
  <xs:element name="Order">
    <xs:complexType>
      <xs:sequence>
        <xs:element name="Item" minOccurs="0" maxOccurs="unbounded">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="ItemNumber" type="xs:string" minOccurs="0" />
              <xs:element name="Quantity" type="xs:string" minOccurs="0" />
              <xs:element name="Price" type="xs:string" minOccurs="0" />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
      <xs:attribute name="OrderID" type="xs:string" />
    </xs:complexType>
  </xs:element>
  <xs:element name="NewDataSet" msdata:IsDataSet="true" msdata:UseCurrentLocale="true">
    <xs:complexType>
      <xs:choice minOccurs="0" maxOccurs="unbounded">
        <xs:element ref="Order" />
      </xs:choice>
    </xs:complexType>
  </xs:element>
</xs:schema>'

ALTER TABLE ItemInfo
ALTER COLUMN ItemData Xml (OrderInfoSchemaCollection)
GO

declare @var xml
SET @var = '<Root>
<Junk1>Some Junk</Junk1>
<Junk2>Some More Junk</Junk2>
<Junk3>Even More Junk</Junk3>
<Junk4>Too Much Junk</Junk4>
</Root>'
INSERT INTO ItemInfo
VALUES(2,@var)

declare @var1 xml
SET @var1 = '<Order OrderID="2">
<Item>
<ItemNumber>A017</ItemNumber>
<Quantity>1</Quantity>
<Price>2999.99</Price>
</Item>
</Order>'
INSERT INTO ItemInfo
VALUES(2,@var1)

USE TestDB
CREATE FUNCTION XMLFunc
(
@var int
) RETURNS xml
AS
BEGIN
DECLARE @val xml
SET @val = (SELECT OrderNumber, CustomerID
FROM SalesOrder WHERE OrderNumber=@var
FOR XML Path(''),Root('OrderInfo'))
RETURN @val
END
GO
SELECT dbo.XMLFunc(1).value('(OrderInfo/CustomerID)[1]','INT')
as Customer

declare @var2 xml
SET @var2 = '<Order OrderID="2">
<Item>
<ItemNumber>A017</ItemNumber>
<Quantity>1</Quantity>
<Price>2999.99</Price>
</Item>
</Order><Order OrderID="3">
<Item>
<ItemNumber>A018</ItemNumber>
<Quantity>2</Quantity>
<Price>5999.99</Price>
</Item>
</Order>'

SELECT @var2.value('(Order/@OrderID)[2]','INT') as orderid,
@var2.value('(Order/Item/ItemNumber)[2]','NVARCHAR(50)') as itemnumber


SELECT ItemData.value('(Order/@OrderID)[1]','INT') as orderid,
ItemData.value('(Order/Item/ItemNumber)[1]','NVARCHAR(50)') as itemnumber
FROM ItemInfo

declare @var3 xml
SET @var3 = '<Order OrderID="2">
<Item>
<ItemNumber>P002</ItemNumber>
<Quantity>3</Quantity>
<Price>3999.99</Price>
</Item>
</Order>'
INSERT INTO ItemInfo
VALUES(3,@var3)

DECLARE @var4 xml
SET @var4 = '
<Item>
<ItemNumber>V001</ItemNumber>
<ItemNumber>A017</ItemNumber>
<ItemNumber>P002</ItemNumber>
</Item>'

SELECT @var4.value('.','NVARCHAR(50)') as ItemNumber
FROM @var4.nodes('/Item/ItemNumber') o(var4)

SELECT OrderID, ItemData.value('(Order/Item/ItemNumber)[1]','NVARCHAR(50)') as itemnumber
FROM ItemInfo
CROSS APPLY ItemData.nodes('/Order/Item') o(X)

SELECT OrderID FROM ItemInfo
WHERE ItemData.exist('Order/Item/ItemNumber = "A017"') = 1

Use AdventureWorks2019
SELECT o.PurchaseOrderNumber, o.OrderDate, p.FirstName + ' ' + p.LastName as Name
FROM [Sales].[SalesOrderHeader] o
INNER JOIN [Sales].[Customer] c ON o.CustomerID = c.CustomerID
INNER JOIN [Person].[Person] p ON c.PersonID = p.BusinessEntityID
FOR XML AUTO

Use AdventureWorks2019
SELECT o.PurchaseOrderNumber, o.OrderDate, p.FirstName + ' ' + p.LastName as Name
FROM [Sales].[SalesOrderHeader] o
INNER JOIN [Sales].[Customer] c ON o.CustomerID = c.CustomerID
INNER JOIN [Person].[Person] p ON c.PersonID = p.BusinessEntityID
FOR XML AUTO, ELEMENTS

Use AdventureWorks2019
SELECT o.PurchaseOrderNumber, o.OrderDate, p.FirstName + ' ' + p.LastName as Name
FROM [Sales].[SalesOrderHeader] o
INNER JOIN [Sales].[Customer] c ON o.CustomerID = c.CustomerID
INNER JOIN [Person].[Person] p ON c.PersonID = p.BusinessEntityID
FOR XML RAW

Use AdventureWorks2019
SELECT o.PurchaseOrderNumber, o.OrderDate, p.FirstName + ' ' + p.LastName as Name
FROM [Sales].[SalesOrderHeader] o
INNER JOIN [Sales].[Customer] c ON o.CustomerID = c.CustomerID
INNER JOIN [Person].[Person] p ON c.PersonID = p.BusinessEntityID
FOR XML RAW('Order')

Use AdventureWorks2019
SELECT o.PurchaseOrderNumber, o.OrderDate, p.FirstName + ' ' + p.LastName as Name
FROM [Sales].[SalesOrderHeader] o
INNER JOIN [Sales].[Customer] c ON o.CustomerID = c.CustomerID
INNER JOIN [Person].[Person] p ON c.PersonID = p.BusinessEntityID
FOR XML RAW('Order'), ROOT('OrderDetails')

Use AdventureWorks2019
SELECT o.PurchaseOrderNumber AS '@OrderNumber', o.OrderDate, p.FirstName + ' ' + p.LastName as 'Customer/@Name',
d.ProductID as 'LineItems/Item/@ItemNo'
FROM [Sales].[SalesOrderHeader] o
INNER JOIN [Sales].[SalesOrderDetail] d ON o.SalesOrderID = d.SalesOrderDetailID
INNER JOIN [Sales].[Customer] c ON o.CustomerID = c.CustomerID
INNER JOIN [Person].[Person] p ON c.PersonID = p.BusinessEntityID
WHERE o.PurchaseOrderNumber IS NOT NULL
FOR XML PATH('Order'), ROOT('OrderDetails')

Use TestDB
SELECT OrderNumber AS '@orderID', CustomerID AS '*'
FROM SalesOrder
FOR XML PATH('Order'), Root('Orders')

SELECT OrderNumber as 'data()'
FROM SalesOrder 
FOR XML PATH(''), ROOT('Items')

SELECT OrderNumber as 'text()'
FROM SalesOrder 
FOR XML PATH(''), ROOT('Items')

Use AdventureWorks2019
SELECT 'Order Number' AS 'comment()',
OrderNumber,
'CustomerID' AS 'comment()',
CustomerID FROM SalesOrder WHERE OrderNumber = 1
FOR XML PATH(''), ROOT

DECLARE @var5 xml
SET @var5 = '
<Item>
<ItemNumber>V001</ItemNumber>
<ItemNumber>A017</ItemNumber>
</Item>
'
SELECT @var5.query('for $item in Item/ItemNumber return $item')

DECLARE @var6 xml
SET @var6 = '
<Item>
<ItemNumber>1011</ItemNumber>
<ItemNumber>1017</ItemNumber>
<ItemNumber>1008</ItemNumber>
<ItemNumber>1007</ItemNumber>
<ItemNumber>1004</ItemNumber>
<ItemNumber>1006</ItemNumber>
<ItemNumber>1010</ItemNumber>
<ItemNumber>1009</ItemNumber>
<ItemNumber>1005</ItemNumber>
<ItemNumber>1002</ItemNumber>
<ItemNumber>1001</ItemNumber>
<ItemNumber>1003</ItemNumber>
</Item>
'
SELECT @var6.query('for $item in Item/ItemNumber where $item[.>"1002"] order by $item return $item')