dbcc checkdb('AdventureWorks2019')

dbcc checkcatalog('AdventureWorks2019')

dbcc checkconstraints('Person.Address') with ALL_CONSTRAINTS

dbcc checkident('Person.Address')

dbcc help ('checkconstraints')

dbcc help ('checktable')

dbcc help ('checkident')

dbcc checktable('Production.Product')

dbcc checkident('Production.Product')

select COUNT(*) from Production.Product

use tempdb;
create table Frag(
FragID uniqueidentifier not null default NewID(),
Col1 int,
Col2 char(200),
Created datetime default GetDate(),
Modified datetime default GetDate());

alter table Frag
add constraint PK_Frag
primary key clustered (FragID)

create nonclustered index ix_col
on Frag(col1);
 
create proc Add100K
as
set nocount on;
declare @x int;
set @x = 0;
while @x < 100000
begin
insert into Frag(Col1,Col2)
values(@X, 'sample data');
set @x = @x + 1;
end

exec Add100K;
exec Add100K;
exec Add100K;
exec Add100K;

select * from sys.dm_db_index_physical_stats(DB_ID('tempdb'), object_id('Frag'), null, null, 'DETAILED');

alter index PK_Frag on Frag reorganize
alter index ix_col on Frag reorganize

alter index all on Frag rebuild with (fillfactor = 98)

drop table Frag;
drop procedure Add100K;

use AdventureWorks2019
select name, size, max_size from sys.database_files

DBCC updateusage(AdventureWorks2019)
exec sp_spaceused

dbcc sqlperf (logspace)

exec master..xp_fixeddrives

dbcc shrinkdatabase(AdventureWorks2019)