exec sp_configure

exec xp_msver

select * from sys.databases where name='AdventureWorks2019'

SELECT name, minimum, maximum, value, value_in_use from sys.configurations where is_advanced = 1 ORDER by name

exec sp_configure 'show advanced options', 1
reconfigure


exec sp_configure 'max worker threads'

exec sp_configure 'show advanced options', 0
reconfigure

select * from sys.dm_exec_connections