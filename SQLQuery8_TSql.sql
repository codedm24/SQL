DECLARE @var1 varchar(50)
set @var1 = 'I''m a batch';
PRINT @var1;
go 5 --batch executes 5 times

Declare @Test int,
		@TestTwo nvarchar(50)
SELECT @Test, @TestTwo
set @Test = 1;
set	@TestTwo = 'a value';
select @Test, @TestTwo
GO
select @Test as BatchTwo, @TestTwo

declare @ProductID int,
		@ProductName varchar(25)

set @ProductID =782;
select @ProductID = ProductID,
		@ProductName = Name
		from Production.Product
		order by ProductID
select @ProductID ProductID, @ProductName ProductName

declare @x  int = 1;
set @x += 5
select @x

set @x -=3
select @x

set @x *= 2
select @x

declare @ProductID1 int = 999

select Name from Production.Product
where ProductID=@ProductID1

declare @MAV varchar(max)

select @MAV = coalesce(@MAV + ', ' + d.Name, d.Name)
from(select Name from HumanResources.Department) d
order by d.Name;

select @MAV

select [text()] = Name + ','
from(select distinct Name from HumanResources.Department) d
order by Name
for xml path('')

if 1 = 0

print 'line one'
print 'line two'

if exists
(select * from Production.ProductInventory where Quantity = 0)
begin
print 'replenish inventory'
end;

create table dbo.MainTable(
PKColumn int PRIMARY KEY,
ColumnA int);
create table dbo.FKTable(
FKColumn int PRIMARY KEY REFERENCES dbo.MainTable(PKColumn),
ColumnB int);
create index MainTableIndex on dbo.MainTable(PKColumn);
if exists(select OBJECT_ID('dbo.MainTable') from sys.objects)
BEGIN
drop table dbo.MainTable;
END

if exists(select OBJECT_ID('dbo.MainTable') from sys.objects)
BEGIN
if exists(select OBJECT_ID('dbo.FKTable') from sys.objects)
BEGIN
drop table dbo.FKTable;
END

if exists(select OBJECT_ID('MainTableIndex') from sys.objects)
BEGIN
drop index MainTableIndex on dbo.MainTable;
END

drop table dbo.MainTable;
END

declare @Temp int;
set @Temp =0;

while @Temp < 3
begin
print 'tested condition ' + str(@Temp)
set @Temp +=1;
end

goto errorhandler
print 'more code'
errorhandler:
print 'logging the error'

select s.Name + '.' + o2.Name as 'Table', pk.Name as 'Primary Key'
from sys.key_constraints as pk
join sys.objects as o
on pk.object_id = o.object_id
join sys.objects as o2
on o.parent_object_id = o2.object_id
join sys.schemas as s
on o2.schema_id = s.schema_id;

sp_help 'Production.Product';

select @@DATEFIRST, @@LANGID, @@LANGUAGE, @@LOCK_TIMEOUT, @@ERROR, @@NESTLEVEL, @@PROCID, @@ROWCOUNT,
@@SERVERNAME, @@SERVICENAME, @@SPID, @@VERSION

create table #ProductTemp
(ProductID int primary key)

select name from tempdb.sys.objects
where name like '#Pro%'

if not exists(select * from tempdb.sys.objects
where name='##TempWork')
create table ##TempWork(
pk int primary key,
col1 int
);

declare @WorkTable Table(
pk int primary key,
col1 int not null
)

insert into @WorkTable(pk,col1) values(1,101)

select pk, col1 from @WorkTable


select * from sys.dm_exec_describe_first_result_set
(N'select c.Name, s.Name, p.Name from 
Production.ProductCategory c
join Production.ProductSubcategory s
on c.ProductCategoryID = s.ProductCategoryID
join Production.Product p
on s.ProductSubCategoryID = p.ProductSubcategoryID
where c.ProductCategoryID = @ProductCategoryID',N'@ProductCategoryID int',0);

select * from sys.dm_exec_describe_first_result_set_for_object
(OBJECT_ID(N'dbo.uspGetEmployeeManagers'), 0);

sp_describe_undeclared_parameters
N'select c.Name, s.Name, p.Name from 
Production.ProductCategory c
join Production.ProductSubcategory s
on c.ProductCategoryID = s.ProductCategoryID
join Production.Product p
on s.ProductSubCategoryID = p.ProductSubcategoryID
where c.ProductCategoryID = @ProductCategoryID
and s.ProductSubcategoryID = @ProductSubcategoryID',N'@ProductCategoryID int';

select departmentid, name from HumanResources.Department
order by DepartmentID
offset 2 rows
fetch next 5 rows only;

declare @startrow int= 1,
@rowsperpage int = 4

while(select count(*) from HumanResources.Department) >= @startrow
begin
select departmentid, name 
from HumanResources.Department
order by DepartmentID
offset @startrow - 1 rows
fetch next @rowsperpage rows only;
set @startrow += @rowsperpage
end

declare @ErrorNumber varchar(100);

update HumanResources.Employee
set BusinessEntityID = 3000
where BusinessEntityID = 2;

set @ErrorNumber = @@ERROR

print @@Error

print @ErrorNumber

update HumanResources.Department
set Name = 'Ministry of Silly Wals'
where DepartmentID = 100;

if @@ROWCOUNT = 0 
begin
print 'no rows affected'
end

raiserror('unable to update %s',14,1,'Customer');

select * from sys.messages where language_id=1033

raiserror('unable to update %s',14,1,'Customer') with log

begin try
select 'Try one';
raiserror('simulated error',16,1);
select 'Try two'
end try
begin catch
select 'catch block'
end catch
select 'post try'
