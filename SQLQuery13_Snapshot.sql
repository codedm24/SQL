use AdventureWorks2019
go
execute sp_helpfile;

CREATE DATABASE AdventureWorks2019_SnapShot ON
(NAME=AdventureWorks2019, FILENAME='F:\Projects\SQL\ADVENTUREWORKS2019_SNAPSHOT.snap')
AS SNAPSHOT OF "AdventureWorks2019"
GO

CREATE DATABASE Books_SnapShot ON
(NAME=Books, FILENAME='F:\Projects\SQL\Books_SnapShot.snap')
AS SNAPSHOT OF [Books]
GO

SELECT name, physical_name FROM sys.master_files WHERE database_id = DB_ID('AdventureWorks2019');
SELECT name, physical_name FROM sys.master_files WHERE database_id = DB_ID('Books');

use AdventureWorks2019_SnapShot
select * from Production.Product

drop database AdventureWorks2019_SnapShot

	Use Books
  INSERT INTO Books(Title,Publisher) VALUES('SQL Server Bible','John Wiley & Sons')

    

  select * from Books Where BookId=7

  Use Books_SnapShot

  select * from Books Where BookId=7

  use Books;
  alter database [Books] set SINGLE_USER
  with ROLLBACK IMMEDIATE;

  use master;
  restore database Books from database_snapshot='Books_SnapShot';

  use Books;
  alter database Books set MULTI_USER