USE sampleABG

SELECT enter_month
FROM 
(SELECT MONTH(enter_date) as enter_month
FROM
works_on) AS m
GROUP BY enter_month

USE sampleABG
SELECT w.job, (SELECT e.emp_lname FROM employee e WHERE e.emp_no = w.emp_no) AS name
FROM works_on w
WHERE w.job IN ('Manager','Analyst')

--Query without CTE
use AdventureWorks2019
SELECT SalesOrderID FROM
Sales.SalesOrderHeader
WHERE
TotalDue > (SELECT AVG(TotalDue)
	FROM Sales.SalesOrderHeader 
	WHERE YEAR(OrderDate) = '2014')
AND
Freight > (SELECT AVG(TotalDue)
	From Sales.SalesOrderHeader
	WHERE YEAR(OrderDate) = '2014')/2.5
ORDER BY SalesOrderID
OFFSET 1000 ROWS FETCH NEXT 100 ROWS ONLY;

--using CTE
USE AdventureWorks2019;
WITH price_calc(year_2014) AS
(SELECT AVG(TotalDue)
	FROM Sales.SalesOrderHeader
	WHERE Year(OrderDate) = '2014')

SELECT SalesOrderID
FROM Sales.SalesOrderHeader
WHERE 
TotalDue > (SELECT year_2014 FROM price_calc)
AND
Freight > (SELECT year_2014 FROM price_calc)/2.5;

use sampleABG
CREATE TABLE airplane(
containing_assembly VARCHAR(10),
contained_assembly VARCHAR(10),
quantity_contained INT,
unit_cost DECIMAL(6,2));

INSERT INTO airplane VALUES('Airplane','Fuselage',1,10);
INSERT INTO airplane VALUES('Airplane','Wings',1,11);
INSERT INTO airplane VALUES('Airplane','Tail',1,12);
INSERT INTO airplane VALUES('Fuselage','Cockpit',1,13);
INSERT INTO airplane VALUES('Fuselage','Cabin',1,14);
INSERT INTO airplane VALUES('Fuselage','Nose',1,15);
INSERT INTO airplane VALUES('Cockpit',NULL,1,13);
INSERT INTO airplane VALUES('Cabin',NULL,1,14);
INSERT INTO airplane VALUES('Nose',NULL,1,15);
INSERT INTO airplane VALUES('Wings',NULL,2,11);
INSERT INTO airplane VALUES('Tail',NULL,1,12);

SELECT * FROm airplane

USE sampleABG;
WITH list_of_parts(assembly1, quantity, cost) AS
(SELECT containing_assembly, quantity_contained, unit_cost 
FROM 
airplane
WHERE contained_assembly IS NULL
UNION ALL
SELECT a.containing_assembly, a.quantity_contained,
CAST(l.quantity*l.cost AS DECIMAL(6,2))
FROM
list_of_parts l, airplane a
WHERE
l.assembly1 = a.contained_assembly)

SELECT assembly1, SUM(quantity) parts, SUM(COST) sum_cost
FROM list_of_parts
GROUP BY assembly1