USE master;
CREATE DATABASE sample;

------------------------
USE master;
CREATE DATABASE projects 
ON (NAME=project_dat,
	FILENAME='F:\Projects\SQL\Database Files\projects.mdf',
	SIZE = 10,
	MAXSIZE = 10,
	FILEGROWTH = 5)
LOG ON (NAME=projects_log,
		FILENAME = 'F:\Projects\SQL\Database Files\projects.ldf',
		SIZE = 40,
		MAXSIZE = 100,
		FILEGROWTH = 10);
-------------------------------------------------------------------
USE master;
CREATE DATABASE projects_snapshot
ON (NAME = 'project_dat',
	FILENAME='F:\Projects\SQL\Database Files\projects_snapshot.mdf')
--LOG ON (NAME= projects_snapshot_log,
--		FILENAME = 'F:\Projects\SQL\Database Files\projects_snapshot.ldf')
AS SNAPSHOT OF projects;
-------------------------------------------------------------------------
USE sample;
CREATE TABLE employee(emp_no INTEGER NOT NULL,
					  emp_fname CHAR(20) NOT NULL,
					  emp_lname CHAR(20) NOT NULL,
					  dept_no CHAR NULL);
CREATE TABLE department(dept_no CHAR NOT NULL,
				       dept_anem CHAR(25) NOT NULL,
					   location CHAR(30) NULL);
CREATE TABLE project(project_no CHAR NOT NULL,
					project_name CHAR(15) NOT NULL,
					budget FLOAT NULL);
CREATE TABLE works_on(emp_no INTEGER NOT NULL,
					 project_no CHAR NOT NULL,
					 job CHAR(15) NULL,
					 enter_date DATE NULL);
-------------------------------------------------------------
USE sample;
CREATE TABLE Item_Attribute(item_id INT NOT NULL,
							attribute NVARCHAR(30) NOT NULL,
							value SQL_VARIANT NOT NULL,
							PRIMARY KEY(item_id,attribute));
--------------------------------------------------------------
USE sample;
DROP TABLE projects

CREATE TABLE projects(project_no CHAR DEFAULT 'p1',
			project_name CHAR(15) NOT NULL,
			budget FLOAT NULL,
			CONSTRAINT unique_no UNIQUE(project_no));
---------------------------------------------------------------
USE sample
DROP TABLE employee

--format 1
--CREATE TABLE employee(emp_no INTEGER NOT NULL,
--	emp_fname CHAR(20) NOT NULL,
--	emp_lname CHAR(20) NOT NULL,
--	dept_no CHAR NULL,
--	CONSTRAINT prim_empl PRIMARY KEY(emp_no));
--format 2
CREATE TABLE employee(emp_no INTEGER NOT NULL CONSTRAINT prim_empl PRIMARY KEY(emp_no),
	emp_fname CHAR(20) NOT NULL,
	emp_lname CHAR(20) NOT NULL,
	dept_no CHAR NULL);
---------------------------------------------------------------------------------------------
USE sample
DROP TABLE customer
CREATE TABLE customer(cust_no INTEGER NOT NULL,
		cust_group CHAR(10) NULL,
		CHECK (cust_group IN ('c1','c2','c10')));

INSERT INTO customer(cust_no,cust_group) VALUES(1,'c2')
----------------------------------------------------------------------------------------------
USE sample

DROP TABLE works_on

CREATE TABLE works_on(emp_no INTEGER NOT NULL,
			project_no CHAR NOT NULL,
			job CHAR(15) NULL,
			enter_date DATE NULL,
			CONSTRAINT prim_works PRIMARY KEY(emp_no, project_no),
			CONSTRAINT foreign_works FOREIGN KEY(emp_no)
				REFERENCES employee(emp_no));
---------------------------------------------------------------------------------------------------
USE sample

INSERT INTO works_on VALUES(1,1,2,'09-28-2024')
---------------------------------------------------------------------------------------------------
USE sample;

--ALTER TABLE works_on
--DROP CONSTRAINT  foreign_works
--DROP TABLE department
--DROP TABLE employee
--DROP TABLE project
--DROP TABLE projects
--DROP TABLE works_on

CREATE TABLE department(dept_no CHAR NOT NULL,
	dept_name CHAR(25) NOT NULL,
	location CHAR(30) NULL,
	CONSTRAINT primp_dept PRIMARY KEY(dept_no));
CREATE TABLE employee(emp_no INTEGER NOT NULL,
	emp_fname CHAR(20) NOT NULL,
	emp_lname CHAR(20) NOT NULL,
	dept_no CHAR NULL,
	CONSTRAINT prim_emp PRIMARY KEY(emp_no),
	CONSTRAINT foriegn_emp FOREIGN KEY(dept_no)
	REFERENCES department(dept_no));
CREATE TABLE project(project_no CHAR NOT NULL,
	project_name CHAR(15) NOT NULL,
	budget FLOAT NULL,
	CONSTRAINT prim_project PRIMARY KEY(project_no));
CREATE TABLE works_on(emp_no INTEGER NOT NULL,
	project_no CHAR NOT NULL,
	job char(15) NULL,
	enter_date DATE NULL,
	CONSTRAINT prim_works PRIMARY KEY(emp_no, project_no),
	CONSTRAINT foreign1_works FOREIGN KEY(emp_no) REFERENCES employee(emp_no),
	CONSTRAINT foreign2_works FOREIGN KEY(project_no) REFERENCES project(project_no));
-----------------------------------------------------------------------------------------
USE sample

CREATE TABLE works_on1(emp_no INTEGER NOT NULL,
		project_no CHAR NOT NULL,
		job char(15) NULL,
		enter_date DATE NULL,
		CONSTRAINT prim_works1 PRIMARY KEY(emp_no, project_no),
		CONSTRAINT foreign1_works1 FOREIGN KEY(emp_NO)
			REFERENCES employee(emp_no) ON DELETE CASCADE,
		CONSTRAINT foreign2_works1 FOREIGN KEY(project_no)
			REFERENCES project(project_no) ON UPDATE CASCADE);
-------------------------------------------------------------------------------
USE sample

DROP TABLE customer

DROP TYPE zip

CREATE TYPE zip
	FROM SMALLINT NOT NULL;


CREATE TABLE customer(cust_no INT NOT NULL,
	cust_name CHAR(20) NOT NULL,
	city CHAR(20),
	zip_code zip,
	CHECK(zip_code BETWEEN 601 AND 99950));
------------------------------------------------------------------
USE sample
CREATE TYPE person_table_t AS TABLE
(name VARCHAR(30), salary decimal(8,2));
------------------------------------------------------------------
USE master
GO
ALTER DATABASE projects
ADD FILE(NAME=projects_dat1,
	FILENAME='F:\Projects\SQL\Database Files\projects1.mdf',SIZE=10,
	MAXSIZE=100,FILEGROWTH=5);
---------------------------------------------------------------------
USE sample

ALTER TABLE employee
	ADD telephone_no CHAR(12) NULL;

EXEC sp_help 'employee';

ALTER TABLE employee
	DROP COLUMN telephone_no;

EXEC sp_help 'employee';

-------------------------------------------
--Show Table Columns

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='employee';
---------------------------------------------
USE sample

ALTER TABLE department
	ALTER COLUMN location CHAR(25) NOT NULL;
-------------------------------------------------------------
USE sample

CREATE TABLE sales(
	order_no INTEGER NOT NULL,
	order_date DATE NOT NULL,
	ship_date DATE NOT NULL);
GO
ALTER TABLE sales
	ADD CONSTRAINT order_check CHECK(order_date <= ship_date);
---------------------------------------------------------------
USE sample

ALTER TABLE sales
	ADD CONSTRAINT prim_sales PRIMARY KEY(order_no);
----------------------------------------------------------------
USE sample

ALTER TABLE sales
	DROP CONSTRAINT order_check;

ALTER TABLE sales
	ADD CONSTRAINT order_check CHECK(order_date <= ship_date);

EXEC sp_helpconstraint sales;
---------------------------------------------------------------
USE sample

EXEC sp_rename @objname = department, @newname=subdivision

EXEC sp_rename @objname ='sales.order_no', @newname=ordernumber
----------------------------------------------------------------
USE sampleABG

CREATE TABLE Employees (
    EmployeeID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [Name] VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (Name, Salary) VALUES
('Alice', 25000),
('Bob', 35000),
('Charlie', 45000),
('Daisy', 55000),
('Eve', 75000);