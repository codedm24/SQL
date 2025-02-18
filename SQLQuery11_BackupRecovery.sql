select name, recovery_model_desc from sys.databases

alter database AdventureWorks2019 set recovery Full

alter database AdventureWorks2019 set recovery simple

<!--'F:\Program Files\Microsoft SQL Server\MSSQL15.HPHOMESQLSRVR\MSSQL\Backup'-->
backup database AdventureWorks2019
to disk='F:\Projects\SQL\AdventureWorks2019_backup.bak'
with name='AdventureWorks2019_backup'

backup database AdventureWorks2019
to disk='F:\Projects\SQL\AdventureWorks2019_fullbackup.bak'
with name='AdventureWorks2019_fullbackup'

backup log AdventureWorks2019
to disk='F:\Projects\SQL\AdventureWorks2019_logbackup.bak'
with name='AdventureWorks2019_logbackup'

ALTER DATABASE Plan2Recover SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
drop database Plan2Recover

create database Plan2Recover

use Plan2Recover

create Table T1(
PK int identity Primary Key,
Name varchar(15))

insert into T1 values('Full')

alter database Plan2Recover set recovery Full

backup database Plan2Recover 
to disk = 'F:\Projects\SQL\P2R.bak'
with name='P2R_Full', init;

insert into T1 values('Log 1')

backup Log Plan2Recover
to disk = 'F:\Projects\SQL\P2R.bak'
with name ='P2R_Log';

insert into T1 values('Log 2')

backup Log Plan2Recover
to disk='F:\Projects\SQL\P2R.bak'
with name = 'P2R_Log';

use master

ALTER DATABASE Plan2Recover SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
drop database Plan2Recover


restore database Plan2Recover
from disk='F:\Projects\SQL\P2R.bak'
with file = 1, norecovery

restore Log Plan2Recover
from disk='F:\Projects\SQL\P2R.bak'
with file = 2, norecovery

restore Log Plan2Recover
from disk='F:\Projects\SQL\P2R.bak'
with file = 3, norecovery

RESTORE DATABASE Plan2Recover WITH RECOVERY

use Plan2Recover
select * from T1