---
title: [SQL Server 常用近百条SQL语句（收藏版）]
date: 2021-11-13 09:13:17
tags:
categories:
- 数据库
- sqlserver
---


1. sqlserver查看实例级别的信息，使用SERVERPROPERTY函数

```sql
select SERVERPROPERTY ('propertyname')
```

2. 查看实例级别的某个参数XX的配置

```sql
select * from sys.configurations where name='XX'
```
<!-- more -->

3. 更改实例级别的某个参数XX的值

```sql
sp_configure 'XX','0' 
RECONFIGURE WITH OVERRIDE
```

sp_configure显示或更改当前服务器的全局配置设置。  RECONFIGURE表示[SQL Server](https://cloud.tencent.com/product/sqlserver?from=10680)不用重新启动就立即生效 。

使用sp_configure更改设置时，请使用RECONFIGURE语句使更改立即生效，否则更改将在SQL Server重新启动后生效。RECONFIGURE后面加WITH OVERRIDE表示不管这个值是不是符合要求都会生效，比如recovery interval的范围值是10--60对应sys.configurations.minimum是10、sys.configurations.maximum是60，如果sp_configure 'recovery interval', 75设置为75，超过了这个10--60规范，但是要让75生效，则必须加上WITH OVERRIDE。

4. sqlserver没有系统表可以查询所有[数据库](https://cloud.tencent.com/solution/database?from=10680)下面对象，以下只能在当前数据库下面查

```sql
select * from sys.all_objects --查询当前数据库的所有架构范围的对象
select * from sys.sysobjects --查询当前数据库的所有对象
--sys.all_objects、sys.sysobjects 这种的视图，在每个数据库的系统视图下面都有

select * from sys.databases --在当前数据库下可以查询到所有数据库信息，包含是否on状态
select * from sys.sysdatabases --在当前数据库下可以查询到所有数据库信息，不包含是否on状态，这个系统视图会在后续的版本中删除
--sys.databases、sys.sysdatabases这种的视图，在每个数据库的系统视图下面都有
sys.processes --没有这个视图
select * from sys.sysprocesses --在当前数据库下可以查询所有正在SQL Server 实例上运行的进程的相关信息，也就是所有数据库上的线程，这个系统视图会在后续的版本中删除
```

5. 全局系统视图、单个数据库系统视图

```sql
sys.database_files --每个存储在数据库本身中的数据库文件在表中占用一行。这是一个基于每个数据库的视图。
sys.master_files --master 数据库中的每个文件对应一行。这是一个系统范围视图。
--sys.database_files、sys.master_files这种的视图，在每个数据库的系统视图下面都有
```

6.  一些只存在msdb的系统表，而非系统视图

```sql
dbo.backupset
dbo.log_shipping_secondary
dbo.restorehistory
dbo.sysjobs
dbo.sysjobhistory
--这些系统表只存在msdb数据库，使用的时候必须加上msdb前缀
```

7.  sp_lock、sp_who、sp_who2、sp_helptext等一些系统存储过程存在于每个数据库中

8.  报告有关锁的信息，会显示实例里面的所有数据库的锁信息、堵塞信息

```sql
sp_lock
```

\9. 提供有关当前用户、 会话和进程的实例中的信息，可以看到会话的状态running、SUSPENDED、sleeping、rollback，sp_who2通过CPUTime、DiskIO可以判断对应的transaction是否很大 

> sp_who  sp_who2  sp_who2 active (可选参数LoginName, 或active代表活动会话数) 
>
> CPUTime (进程占用的总CPU时间)  DiskIO (进程对磁盘读的总次数)  LastBatch (客户最后一次调用存储过程或者执行查询的时间)  ProgramName (用来初始化连接的应用程序名称，或者主机名)

10. 查看某个存储过程的内容

```sql
sp_helptext pro_name
```

11.显示某个线程号发送到sqlserver数据库的最后一个语句

```sql
DBCC INPUTBUFFER
```

12.假设查询到249被锁给堵塞了，查询被堵塞的SQL语句

```sql
DBCC INPUTBUFFER (249)
```

13. 查看某个数据库中是否存在活动事务，有活动事务就一定会写日志

```sql
DBCC OPENTRAN (dbname)
```

14. 监视日志空间

```sql
DBCC SQLPERF (LOGSPACE)
```

15. 查找无法重用日志中的空间的原因(日志无法截断导致日志文件越来越大，但是可用空间很小，无法收缩)

```sql
select name,log_reuse_wait_desc from sys.databases
```

16. 查看虚拟日志文件信息

```sql
DBCC LOGINFO
```

结果有多少行，代表有多少虚拟日志文件，活动的虚拟日志文件的状态(status)为2

17. 修复msdb数据库，比如ssms页面sql server agent丢失或看不了job view history等功能，说明msdb坏了，需要修复

```sql
dbcc checkdb (msdb);
```

18. 在您当前连接到的 SQL Server 数据库中生成一个手动检查点

```sql
CHECKPOINT [ checkpoint_duration ]
--checkpoint_duration表示以秒为单位指定手动检查点完成所需的时间，一般不使用这个参数，让数据库自己控制
```

19. 查看数据库各种设置

```sql
select name,State,user_access,is_read_only,recovery_model from sys.databases
```

20. 查看某个数据库中是否存在会话

```sql
select DB_NAME(dbid),* from sys.sysprocesses where dbid=db_id('dbname')
```

21. 查询当前阻塞的所有请求

```sql
select * from sys.sysprocesses where blocked>0
或
SELECT t1.resource_type,db_name(t1.resource_database_id),t1.resource_associated_entity_id,t1.request_mode,
t1.request_session_id,t2.blocking_session_id,t2.wait_duration_ms
FROM sys.dm_tran_locks as t1
INNER JOIN sys.dm_os_waiting_tasks as t2
ON t1.lock_owner_address = t2.resource_address;
或
select A.SPID as 被阻塞进程,a.CMD AS 正在执行的操作,b.spid AS 阻塞进程号,b.cmd AS 阻塞进程正在执行的操作
from master..sysprocesses a,master..sysprocesses b
where a.blocked<>0 and a.blocked= b.spid
或
SELECT session_Id,spid,ecid,DB_NAME (sp.dbid),nt_username,er.status,wait_type,
[Individual Query] =SUBSTRING (qt.text,er.statement_start_offset / 2,
( CASE
WHEN er.statement_end_offset = -1
THEN
LEN (CONVERT (NVARCHAR (MAX), qt.text)) * 2
ELSE
er.statement_end_offset
END
- er.statement_start_offset)
/ 2),
qt.text,program_name,Hostname,nt_domain,start_time
FROM sys.dm_exec_requests er
INNER JOIN sys.sysprocesses sp ON er.session_id = sp.spid
CROSS APPLY sys.dm_exec_sql_text (er.sql_handle) AS qt
WHERE session_Id > 50 /* Ignore system spids.*/
AND sp.blocked>0 AND session_Id NOT IN (@@SPID)
或
SELECT session_id ,status ,blocking_session_id
,wait_type ,wait_time ,wait_resource
,transaction_id
FROM sys.dm_exec_requests
WHERE status = N'suspended';
--sys.dm_exec_requests返回SQL Server 中正在执行的每个请求的信息
```

22. 查看哪些表被锁了，以及这些表被哪个进程锁了

```sql
select request_session_id spid,OBJECT_NAME(resource_associated_entity_id) tableName
from sys.dm_tran_locks where resource_type='OBJECT' ORDER BY request_session_id ASC
```

23. 查询某个job是否被堵塞

```sql
select * from msdb.dbo.sysjobs where name='jobname'
select a.program_name,a.* from master..sysprocesses a where a.program_name like '%0D1CE57E8AC5%'
--把第一个语句查询到的job_id代入第二个语句的program_name
```

24. 检查SQL Agent是否开启

```sql
IF EXISTS (
SELECT TOP 1 1
FROM sys.sysprocesses
WHERE program_name = 'SQLAgent - Generic Refresher'
)
SELECT 'Running'
ELSE
SELECT 'Not Running'
```

25. 查看活动线程执行的sql语句,并生成批量杀掉的语句

```sql
select 'KILL '+CAST(a.spid AS NVARCHAR(100)) AS KillCmd,REPLACE(hostname,' ','') as hostname ,replace(program_name,' ','') as program_name
,REPLACE(loginame, ' ', '') AS loginame, db_name(a.dbid) AS DBname,spid,blocked,waittime/1000 as waittime
,a.status,Replace(b.text,'''','''') as sqlmessage,cpu
from sys.sysprocesses as a with(nolock)
cross apply sys.dm_exec_sql_text(sql_handle) as b
where a.status<>'sleeping' AND a.spid<>@@SPID
```

26. 查看备份进度

```sql
SELECT DB_NAME(database_id) AS Exec_DB
,percent_complete
,CASE WHEN estimated_completion_time < 36000000
THEN '0' ELSE '' END + RTRIM(estimated_completion_time/1000/3600)
+ ':' + RIGHT('0' + RTRIM((estimated_completion_time/1000)%3600/60), 2)
+ ':' + RIGHT('0' + RTRIM((estimated_completion_time/1000)%60), 2) AS [Time Remaining]
,b.text as tsql
,*
FROM SYS.DM_EXEC_REQUESTS
cross apply sys.dm_exec_sql_text(sql_handle) as b
WHERE command LIKE 'Backup%' --and database_id=db_id('cardorder')
--OR command LIKE 'RESTORE%'
ORDER BY 2 DESC
```

27. 查看恢复进度

```sql
SELECT DB_NAME(database_id) AS Exec_DB
,percent_complete
,CASE WHEN estimated_completion_time < 36000000
THEN '0' ELSE '' END + RTRIM(estimated_completion_time/1000/3600)
+ ':' + RIGHT('0' + RTRIM((estimated_completion_time/1000)%3600/60), 2)
+ ':' + RIGHT('0' + RTRIM((estimated_completion_time/1000)%60), 2) AS [Time Remaining]
,b.text as tsql
,*
FROM SYS.DM_EXEC_REQUESTS
cross apply sys.dm_exec_sql_text(sql_handle) as b
WHERE command LIKE 'RESTORE%' --and database_id=db_id('cardorder')
--OR command LIKE 'RESTORE%'
ORDER BY 2 DESC
```

28. 查看数据库的最近备份信息

```sql
SELECT database_name,type,MAX(backup_finish_date) AS backup_finish_date FROM msdb.dbo.backupset GROUP BY database_name,type ORDER BY database_name,type
备注：D 表示全备份，i 表示差异备份，L 表示日志备份
```

29. 查看数据库的历史备份记录，并生成restore语句

```sql
SELECT
CONVERT(CHAR(100),SERVERPROPERTY('Servername'))AS Server,
bs.database_name,
bs.backup_start_date,
bs.backup_finish_date,
bs.expiration_date,
CASE bs.type
WHEN 'D' THEN 'Database'
WHEN 'L' THEN 'Log'
END AS backup_type,
bs.backup_size,
bmf.logical_device_name,
bmf.physical_device_name,
bs.name AS backupset_name,
bs.description,
'RESTORE DATABASE ['+bs.database_name+'] FROM DISK=N'''
+bmf.physical_device_name+ '''WITH NORECOVERY;'
FROM msdb.dbo.backupmediafamily bmf
INNER JOIN msdb.dbo.backupset bs
ON bmf.media_set_id=bs.media_set_id
WHERE bs.backup_start_date>DATEADD(DAY,-1,GETDATE())
ORDER BY bs.backup_finish_date
```

30. 查询XX库从YYYY-MM-DD日期开始的日志备份记录，并生成restore log的语句

```sql
SELECT TOP 1000 
      S.database_name [Database], 
      CASE [S].[type] 
            WHEN 'L' 
            THEN N'RESTORE LOG ' + QUOTENAME(S.database_name) + N' FROM DISK = ''' + F.physical_device_name + N''' WITH NORECOVERY;' 
      END [LogRestore], 
      F.physical_device_name, 
      S.[Type], 
      S.backup_start_date, 
      S.backup_finish_date 
FROM msdb.dbo.backupmediafamily F 
INNER JOIN msdb.dbo.backupset S 
ON S.media_set_id = F.media_set_id 
WHERE S.database_name = 'XX' AND 
      S.type = 'L' AND S.backup_start_date > 'YYYY-MM-DD' ORDER BY S.backup_start_date ASC
```

  31. 查询always on状态是否正常

```sql
select dc.database_name, d.synchronization_health_desc, d.synchronization_state_desc, d.database_state_desc from sys.dm_hadr_database_replica_states d join sys.availability_databases_cluster dc on d.group_database_id=dc.group_database_id and d.is_local=1
```

32. 查看mirror镜像信息

```sql
SELECT
db_name(database_id),
mirroring_state_desc,
mirroring_role_desc,
mirroring_partner_name,
mirroring_partner_instance
FROM sys.database_mirroring
```

33. 查询SSRS Report Subscriptions相关的job

```sql
SELECT
b.name AS JobName
, e.name
, e.path
, d.description
, a.SubscriptionID
, laststatus
, eventtype
, LastRunTime
, date_created
, date_modified
FROM
ReportServer.dbo.ReportSchedule a
JOIN msdb.dbo.sysjobs b ON CONVERT(SYSNAME,a.ScheduleID) = b.name
JOIN ReportServer.dbo.ReportSchedule c ON b.name = CONVERT(SYSNAME,c.ScheduleID)
JOIN ReportServer.dbo.Subscriptions d ON c.SubscriptionID = d.SubscriptionID
JOIN ReportServer.dbo.Catalog e ON d.report_oid = e.itemid
WHERE
e.name = 'Report Name Goes Here'
```

34. 查看某个数据库的数据文件信息，就算是mirror从库的数据文件也可以查到，filestream目录也可以查到

```sql
SELECT db_name(database_id),* FROM master.sys.master_files WHERE database_id =DB_ID(N'DBA');
```

35. 查看某个数据文件信息

```sql
select b.name,a.type_desc,a.name,a.physical_name,a.size,a.max_size,a.is_percent_growth,a.growth from sys.master_files a join sys.databases b on a.database_id=b.database_id and a.physical_name like '%DTSWonda_1%'
```

36. 查询实例的数据文件总大小

```sql
SELECT sum(size*8/1024/1024) FROM master.sys.master_files
```

37. 查询某个目录中数据库使用的总大小

```sql
SELECT a.size*8/1024/1024 ,a.* FROM master.sys.master_files a WHERE physical_name like 'G:\DEFAULT.DATA%'
```

38. 查询某个目录中哪些数据库占用了8G以上容量

```sql
SELECT b.name dbname,a.size*8/1024/1024 sum_GB,a.type_desc,a.name datafilename,a.physical_name FROM master.sys.master_files a join sys.sysdatabases b on a.database_id=b.dbid and a.physical_name like 'G:\DEFAULT.DATA%' and a.size*8/1024/1024>8
```

39. 查询实例上的每个数据库的大小

```sql
SELECT
DB_NAME(db.database_id) DatabaseName,
(CAST(mfrows.RowSize AS FLOAT)*8)/1024 RowSizeMB,
(CAST(mflog.LogSize AS FLOAT)*8)/1024 LogSizeMB,
(CAST(mfstream.StreamSize AS FLOAT)*8)/1024 StreamSizeMB,
(CAST(mftext.TextIndexSize AS FLOAT)*8)/1024 TextIndexSizeMB
FROM sys.databases db
LEFT JOIN (SELECT database_id, SUM(size) RowSize FROM sys.master_files WHERE type = 0 GROUP BY database_id, type) mfrows ON mfrows.database_id = db.database_id
LEFT JOIN (SELECT database_id, SUM(size) LogSize FROM sys.master_files WHERE type = 1 GROUP BY database_id, type) mflog ON mflog.database_id = db.database_id
LEFT JOIN (SELECT database_id, SUM(size) StreamSize FROM sys.master_files WHERE type = 2 GROUP BY database_id, type) mfstream ON mfstream.database_id = db.database_id
LEFT JOIN (SELECT database_id, SUM(size) TextIndexSize FROM sys.master_files WHERE type = 4 GROUP BY database_id, type) mftext ON mftext.database_id = db.database_id
```

40. 查询总耗CPU最多的前3个SQL，且最近5天出现过

```sql
SELECT TOP 3
total_worker_time/1000 AS [总消耗CPU 时间(ms)],execution_count [运行次数],
qs.total_worker_time/qs.execution_count/1000 AS [平均消耗CPU 时间(ms)],
last_execution_time AS [最后一次执行时间],max_worker_time /1000 AS [最大执行时间(ms)],
SUBSTRING(qt.text,qs.statement_start_offset/2+1,
(CASE WHEN qs.statement_end_offset = -1
THEN DATALENGTH(qt.text)
ELSE qs.statement_end_offset END -qs.statement_start_offset)/2 + 1)
AS [使用CPU的语法], qt.text [完整语法],
qt.dbid, dbname=db_name(qt.dbid),
qt.objectid,object_name(qt.objectid,qt.dbid) ObjectName
FROM sys.dm_exec_query_stats qs WITH(nolock)
CROSS apply sys.dm_exec_sql_text(qs.sql_handle) AS qt
WHERE execution_count>1 and last_execution_time>dateadd(dd,-5,getdate())
ORDER BY total_worker_time DESC
```

41. 查询平均耗CPU最多的前3个SQL，且最近5小时出现过

```sql
SELECT TOP 3
total_worker_time/1000 AS [总消耗CPU 时间(ms)],execution_count [运行次数],
qs.total_worker_time/qs.execution_count/1000 AS [平均消耗CPU 时间(ms)],
last_execution_time AS [最后一次执行时间],min_worker_time /1000 AS [最小执行时间(ms)],
max_worker_time /1000 AS [最大执行时间(ms)],
SUBSTRING(qt.text,qs.statement_start_offset/2+1,
(CASE WHEN qs.statement_end_offset = -1
THEN DATALENGTH(qt.text)
ELSE qs.statement_end_offset END -qs.statement_start_offset)/2 + 1)
AS [使用CPU的语法], qt.text [完整语法],
qt.dbid, dbname=db_name(qt.dbid),
qt.objectid,object_name(qt.objectid,qt.dbid) ObjectName
FROM sys.dm_exec_query_stats qs WITH(nolock)
CROSS apply sys.dm_exec_sql_text(qs.sql_handle) AS qt
WHERE execution_count>1 and last_execution_time>dateadd(hh,-5,getdate())
ORDER BY (qs.total_worker_time/qs.execution_count/1000) DESC
```

42. 查看当前最耗资源的10个SQL及其spid

```sql
SELECT TOP 10
session_id,request_id,start_time AS '开始时间',status AS '状态',
command AS '命令',d_sql.text AS 'sql语句', DB_NAME(database_id) AS '数据库名',
blocking_session_id AS '正在阻塞其他会话的会话ID',
wait_type AS '等待资源类型',wait_time AS '等待时间',wait_resource AS '等待的资源',
reads AS '物理读次数',writes AS '写次数',logical_reads AS '逻辑读次数',
row_count AS '返回结果行数'
FROM sys.dm_exec_requests AS d_request
CROSS APPLY
sys.dm_exec_sql_text(d_request.sql_handle) AS d_sql
WHERE session_id>50
ORDER BY cpu_time DESC
--前50号session_id一般是系统后台进程，sys.dm_exec_requests的status显示为background
```

43. 查询某个存储过程被哪些job调用了

```sql
SELECT *
FROM msdb.dbo.sysjobs JOB WITH( NOLOCK)
INNER JOIN msdb. dbo.sysjobsteps STP WITH(NOLOCK )
ON STP .job_id = JOB .job_id
WHERE STP .command LIKE N'%sp_name%'
--以上要查询某个job被哪个job调用了，把sp_name存储过程名字改成job_name作业名字即可
```

44. 命令执行某个job

```sql
EXECUTE msdb.dbo.sp_start_job N'job_name' 
```

45. 查询某表标识列的列名

```sql
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.columns WHERE TABLE_NAME='表名' AND COLUMNPROPERTY(OBJECT_ID('表名'),COLUMN_NAME,'IsIdentity')=1
```

46. 获取标识列的种子值

```sql
SELECT IDENT_SEED ('表名')
```

47. 获取标识列的递增量

```sql
SELECT IDENT_INCR('表名')
```

48. 获取指定表中最后生成的标识值

```sql
SELECT IDENT_CURRENT('表名')
```

49. 重新设置标识种子值为XX

```sql
DBCC CHECKIDENT (表名, RESEED, XX)
```

50. 升级前，查询服务器名、实例名、版本号 

```sql
select SERVERPROPERTY('machinename'),@@SERVERNAME,SERVERPROPERTY ('edition'),@@version
```

51. 用户被grant这样操作赋予的权限 

```sql
use dbname 
exec sp_helprotect @username = 'username'
```

52. 授予某个用户执行某个数据库的sp的权限

```sql
use dbname 
grant execute to "username"
```

53. always on

-查看集群各节点的信息，包含节点成员的名称，类型，状态，拥有的投票仲裁数

```sql
SELECT * FROM  sys.dm_hadr_cluster_members;
```

-查看集群各节点的信息，包含节点成员的名称，节点成员上的sql实例名称

```sql
select * from sys.dm_hadr_instance_node_map
```

-查看WSFC(windows server故障转移群集)的信息，包含集群名称，仲裁类型，仲裁状态

```sql
SELECT * FROM SYS.dm_hadr_cluster;
```

-查看AG名称

```sql
select * from sys.dm_hadr_name_id_map
```

-查看集群各节点的子网信息，包含节点成员的名称，子网段，子网掩码

```sql
SELECT * FROM  sys.dm_hadr_cluster_networks;
```

-查看侦听ip

```sql
select * from sys.availability_group_listeners;
```

-查看主从各节点的状态

```sql
select d.is_local,dc.database_name, d.synchronization_health_desc, 
d.synchronization_state_desc, d.database_state_desc 
from sys.dm_hadr_database_replica_states d 
join sys.availability_databases_cluster dc 
on d.group_database_id=dc.group_database_id;
```

-查看辅助副本(传说中的从库)延迟多少M日志量

```sql
select db_name(database_id),log_send_queue_size/1024 delay_M,* 
from sys.dm_hadr_database_replica_states where is_primary_replica=0;


select ar.replica_server_name, db_name(drs.database_id),drs.truncation_lsn, 
drs.log_send_queue_size, drs.redo_queue_size 
from sys.dm_hadr_database_replica_states drs 
join sys.availability_replicas ar on drs.replica_id=ar.replica_id where drs.is_local=0;

select ar.replica_server_name, db_name(drs.database_id),drs.truncation_lsn, 
drs.log_send_queue_size,drs.log_send_rate, drs.redo_queue_size,drs.redo_rate 
from sys.dm_hadr_database_replica_states drs 
join sys.availability_replicas ar on drs.replica_id=ar.replica_id where drs.is_local=0
--log_send_queue_size 主数据库中尚未发送到辅助数据库的日志记录量 (KB)
--log_send_rate 在最后一个活动期间，以千字节 (KB) 的平均主副本发送实例数据的速率/秒
--redo_queue_size 在最后一个活动期间，以千字节 (KB) 的平均主副本发送实例数据的速率/秒
--redo_rate 平均千字节 (KB) 中的给定辅助数据库做的日志记录速率 / 秒
```

54. 查询实例的FILESTREAM 使用的DIRECTORY_NAME 

```sql
SELECT  SERVERPROPERTY('FilestreamShareName') 
```

55. 查询FILETABLE表的数据库对应的DIRECTORY_NAME

```sql
select db_name(database_id),* from sys.database_filestream_options
```

仅仅使用filestream功能时，数据库不需要对应的DIRECTORY_NAME  56. 查询FILETABLE表对应的DIRECTORY_NAME 

```sql
select object_name(object_id),* from sys.filetables
```

57. 查询filetable表testdb.dbo.table1中的文件完整路径名称 

```sql
SELECT FileTableRootPath()+[file_stream].GetFileNamespacePath(),name FROM testdb.dbo.table1
```

58. 查询所有job的状态是否running 

```sql
SELECT sj.Name, 
    CASE 
        WHEN sja.start_execution_date IS NULL THEN 'Not running' 
        WHEN sja.start_execution_date IS NOT NULL AND sja.stop_execution_date IS NULL THEN 'Running' 
        WHEN sja.start_execution_date IS NOT NULL AND sja.stop_execution_date IS NOT NULL THEN 'Not running' 
    END AS 'RunStatus' 
FROM msdb.dbo.sysjobs sj 
JOIN msdb.dbo.sysjobactivity sja 
ON sj.job_id = sja.job_id 
WHERE session_id = ( 
    SELECT MAX(session_id) FROM msdb.dbo.sysjobactivity) order by RunStatus desc;
```

59. 锁表的四种用法

```sql
TABLOCKX 
SELECT * FROM table WITH (TABLOCKX)
```

查询过程中，其他会话无法查询、更新此表，直到查询过程结束

```sql
TABLOCK 
SELECT * FROM table WITH (TABLOCK)
```

查询过程中，其他会话可以查询，但是无法更新此表，直到查询过程结束 

```sql
HOLDLOCK 
SELECT * FROM table WITH (HOLDLOCK)
```

查询过程中，其他会话可以查询，但是无法更新此表，直到查询过程结束

```sql
NOLOCK 
SELECT * FROM table WITH (NOLOCK)
```

查询过程中，其他会话可以查询、更新此表

60. 查询某个发布XX，发布的数据库对象的2种方法

发布数据库上执行(数据来源这三张表distribution.dbo.MSpublications、distribution.dbo.MSarticles、sysarticlecolumns) 

```sql
select a.article,a.source_object,a.destination_object,b.colid from 
(select article,article_id,source_object,destination_object 
from [distribution].[dbo].MSarticles where publication_id in 
( select publication_id from 
[distribution].[dbo].MSpublications where publication='XX' 
) 
) a 
inner join 
(select * from replicate1.dbo.sysarticlecolumns) b 
on a.article_id=b.artid order by a.article
```

订阅数据库上执行 

```sql
select distinct article  from MSreplication_objects where publication='XX'
```

\61. 查询发布信息，发布名称，发布名称对应的发布序号 

```sql
Select * from distribution.dbo.MSpublications 
```

62. 查询发布名里面的发布对象的信息，包含表、视图、存储过程等 

```sql
Select * from  distribution.dbo.MSarticles
```

63. 监控发布订阅是否有异常，执行以下5条语句即可

```sql
select * from [distribution].[dbo].[MSlogreader_history] WHERE error_id != 0 AND [time] >= DATEADD(HOUR, -1, GETDATE()) 
select * from [distribution].[dbo].[MSdistribution_history] WHERE error_id != 0 AND [time] >= DATEADD(HOUR, -1, GETDATE()) 
select * from [distribution].[dbo].[MSsnapshot_history] WHERE error_id != 0 AND [time] >= DATEADD(HOUR, -1, GETDATE()) 
select * from [distribution].[dbo].MSrepl_errors order by 2 desc
select * from msdb.dbo.sysreplicationalerts order by 7 desc
```

64. 查询XX表的索引信息 

```sql
SELECT a.name index_name,c.name table_name,d.name column_name 
FROM sysindexes a JOIN sysindexkeys b 
ON a.id=b.id AND a.indid=b.indid 
JOIN sysobjects c 
ON b.id=c.id 
JOIN syscolumns d 
ON b.id=d.id= AND b.colid=d.colid 
WHERE a.indid NOT IN(0,255) AND c.name in ('XX')
```

65. 生成sql语句的执行计划(select XXX为例，当然select XXX也可以换成执行存储过程比如exec pro_XXX，都是只生成执行计划，不产生结果集，不会执行存储过程) 

```sql
SET SHOWPLAN_ALL ON; 
GO 
select XXX 
GO 
SET SHOWPLAN_ALL OFF; 
GO 
或 
SET SHOWPLAN_XML ON; 
GO 
select XXX 
GO 
SET SHOWPLAN_XML OFF; 
GO
```

66. 查询名称为XXX的job的最后一次运行成功的时间 

```sql
SELECT TOP 1 CONVERT(DATETIME, RTRIM(run_date))+ ((run_time / 10000 * 3600) + ((run_time % 10000) / 100 * 60) + (run_time % 10000) % 100) / (86399.9964) 
FROM msdb.dbo.sysjobhistory jobhis inner join msdb.dbo.sysjobs  jobs 
on jobhis.job_id = jobs.job_id AND jobhis.step_id = 0 AND jobhis.run_status = 1 
and jobs.name='XXX' 
ORDER BY 1 DESC
```

67. 查询某张分区表的总行数和大小，比如表为crm.EmailLog 

```sql
exec sp_spaceused 'crm.EmailLog';
```

68. 查询某张分区表的信息，每个分区有多少行，比如表为crm.EmailLog 

```sql
select convert(varchar(50), ps.name 
) as partition_scheme, 
p.partition_number, 
convert(varchar(10), ds2.name 
) as filegroup, 
convert(varchar(19), isnull(v.value, ''), 120) as range_boundary, 
str(p.rows, 9) as rows 
from sys.indexes i 
join sys.partition_schemes ps on i.data_space_id = ps.data_space_id 
join sys.destination_data_spaces dds 
on ps.data_space_id = dds.partition_scheme_id 
join sys.data_spaces ds2 on dds.data_space_id = ds2.data_space_id 
join sys.partitions p on dds.destination_id = p.partition_number 
and p.object_id = i.object_id and p.index_id = i.index_id 
join sys.partition_functions pf on ps.function_id = pf.function_id 
LEFT JOIN sys.Partition_Range_values v on pf.function_id = v.function_id 
and v.boundary_id = p.partition_number - pf.boundary_value_on_right 
WHERE i.object_id = object_id('crm.EmailLog') 
and i.index_id in (0, 1) 
order by p.partition_number 
```

69. 查询分区函数 

```sql
select * from sys.partition_functions
```

70. 查看分区架构 

```sql
select * from sys.partition_schemes
```

71. 查询ssis包的信息 

```sql
select * from msdb.dbo.sysssispackages
```

72. 查询某张表里的索引的大小,如下示例表为dbo.table1 

```sql
SELECT 
    i.name              AS IndexName, 
    SUM(page_count * 8) AS IndexSizeKB 
FROM sys.dm_db_index_physical_stats( 
    db_id(), object_id('dbo.table1'), NULL, NULL, 'DETAILED') AS s 
JOIN sys.indexes AS i 
ON s.[object_id] = i.[object_id] AND s.index_id = i.index_id 
GROUP BY i.name 
ORDER BY i.name
```

73. 重建表上的所有索引

```sql
alter index all on table_name rebuild with (online=on)
```

重建表上的某个索引

```sql
alter index index_name on table_name rebuild with (online=on)
```

重新组织表上的所有索引 

```sql
alter index all on table_name reorganize
```

重新组织表上的某个索引 

```sql
alter index index_name on table_name reorganize
```

74. 查看数据文件可收缩空间，结果见Availabesize_MB字段值 

```sql
select name ,size*8/1024 as Totalsize_MB ,CAST(FILEPROPERTY(name,'SpaceUsed') AS int)*8/1024 as Usedsize_MB, 
size*8/1024 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)*8/1024 AS Availabesize_MB 
 from sys.master_files where database_id=db_id(N'DBNAME')
```

75. 查询某个表中的全部索引的信息 

```sql
declare @tableName varchar(50) = 'LbaListAlertDetail' 
declare @tableId int 

select @tableId = object_id 
from sys.objects 
where name = @tableName 

SELECT OBJECT_NAME(IX.OBJECT_ID) Table_Name 
       ,IX.name AS Index_Name 
       ,IX.type_desc Index_Type 
       ,SUM(PS.[used_page_count]) * 8 IndexSizeKB 
       ,IXUS.user_seeks AS NumOfSeeks 
       ,IXUS.user_scans AS NumOfScans 
       ,IXUS.user_lookups AS NumOfLookups 
       ,IXUS.user_updates AS NumOfUpdates 
       ,IXUS.last_user_seek AS LastSeek 
       ,IXUS.last_user_scan AS LastScan 
       ,IXUS.last_user_lookup AS LastLookup 
       ,IXUS.last_user_update AS LastUpdate 
FROM sys.indexes IX 
INNER JOIN sys.dm_db_index_usage_stats IXUS ON IXUS.index_id = IX.index_id AND IXUS.OBJECT_ID = IX.OBJECT_ID
INNER JOIN sys.dm_db_partition_stats PS on PS.object_id=IX.object_id 
WHERE OBJECTPROPERTY(IX.OBJECT_ID,'IsUserTable') = 1 
    and IX.OBJECT_ID = @tableId 
GROUP BY OBJECT_NAME(IX.OBJECT_ID) ,IX.name ,IX.type_desc ,IXUS.user_seeks ,IXUS.user_scans ,IXUS.user_lookups,IXUS.user_updates ,IXUS.last_user_seek ,IXUS.last_user_scan ,IXUS.last_user_lookup ,IXUS.last_user_update
```

sqlserver中类似oracle的dba_source的视图是sys.sql_modules

76. 查询某个数据库下的表数据占用磁盘容量最大的10张表 

```sql
use XX 
if exists(select 1 from tempdb..sysobjects where id=object_id('tempdb..#tabName') and xtype='u') 
drop table #tabName 
go 
create table #tabName( 
table_name varchar(100), 
rowsNum varchar(100), 
reserved_size varchar(100), 
data_size varchar(100), 
index_size varchar(100), 
unused_size varchar(100) 
) 
  
declare @name varchar(100) 
declare cur cursor for 
select name from sysobjects where xtype='u' order by name 
open cur 
fetch next from cur into @name 
while @@fetch_status=0 
begin 
    insert into #tabName 
    exec sp_spaceused @name 
    fetch next from cur into @name 
end 
close cur 
deallocate cur 

select top 10 table_name, data_size,rowsNum ,index_size,unused_size ,reserved_size,convert(int,SUBSTRING(data_size,0,LEN(data_size)-2)) size 
from #tabName ORDER BY size desc


或 
select top 10 a.tablename,a.SCHEMANAME,sum(a.TotalSpaceMB) TotalSpaceMB,sum(a.RowCounts) RowCounts 
from ( 
SELECT 
    t.NAME AS TableName, 
    s.Name AS SchemaName, 
    p.rows AS RowCounts, 
    SUM(a.total_pages) * 8 AS TotalSpaceKB, 
    CAST(ROUND(((SUM(a.total_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS TotalSpaceMB, 
    SUM(a.used_pages) * 8 AS UsedSpaceKB, 
    CAST(ROUND(((SUM(a.used_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS UsedSpaceMB, 
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB, 
    CAST(ROUND(((SUM(a.total_pages) - SUM(a.used_pages)) * 8) / 1024.00, 2) AS NUMERIC(36, 2)) AS UnusedSpaceMB 
FROM 
    sys.tables t 
INNER JOIN       
    sys.indexes i ON t.OBJECT_ID = i.object_id 
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id 
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id 
LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id 
WHERE 
    t.NAME NOT LIKE 'dt%' 
    AND t.is_ms_shipped = 0 
    AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, s.Name, p.Rows) a 
GROUP BY  a.tablename,a.SCHEMANAME 
order by sum(a.TotalSpaceMB) desc 
--这个比上一个专业 
```

77. 查询某个数据库中是否有create index '+name+ CHAR(10) 

```sql
select 'use '+name+ CHAR(10) +'select DB_NAME(),OBJECT_NAME(OBJECT_ID),definition from '+name+'.sys.sql_modules
WHERE objectproperty(OBJECT_ID, ''IsProcedure'') = 1 
AND definition like ''%online%=%on%'' and definition like ''%index%''' from sys.databases; 
```

78. 根据id号查询某个数据库名 

```sql
SELECT DB_NAME(18) 
```

根据id号查询某个对象名 

```sql
SELECT OBJECT_NAME(1769220894)
```

79. 查看收缩的进度100%，此语句要到指定的数据库下执行

```sql
SELECT DB_NAME(database_id) AS Exec_DB
,percent_complete
,CASE WHEN estimated_completion_time < 36000000
THEN '0' ELSE '' END + RTRIM(estimated_completion_time/1000/3600)
+ ':' + RIGHT('0' + RTRIM((estimated_completion_time/1000)%3600/60), 2)
+ ':' + RIGHT('0' + RTRIM((estimated_completion_time/1000)%60), 2) AS [Time Remaining]
,b.text as tsql
,*
FROM SYS.DM_EXEC_REQUESTS
cross apply sys.dm_exec_sql_text(sql_handle) as b
WHERE command LIKE 'DbccFilesCompact%' --and database_id=db_id('cardorder')
ORDER BY 2 DESC
```

80. 查看重新组织索引的100%进度

```sql
SELECT DB_NAME(database_id) AS Exec_DB
,percent_complete
,CASE WHEN estimated_completion_time < 36000000
THEN '0' ELSE '' END + RTRIM(estimated_completion_time/1000/3600)
+ ':' + RIGHT('0' + RTRIM((estimated_completion_time/1000)%3600/60), 2)
+ ':' + RIGHT('0' + RTRIM((estimated_completion_time/1000)%60), 2) AS [Time Remaining]
,b.text as tsql
,*
FROM SYS.DM_EXEC_REQUESTS
cross apply sys.dm_exec_sql_text(sql_handle) as b
WHERE command LIKE '%REORGANIZE%' --and database_id=db_id('cardorder')
ORDER BY 2 DESC
```

81. 查看存储过程的执行计划 

```sql
SELECT 
        d.object_id , 
        DB_NAME(d.database_id) DBName , 
        OBJECT_NAME(object_id, database_id) 'SPName' , 
        d.cached_time , 
        d.last_execution_time , 
        d.total_elapsed_time/1000000    AS total_elapsed_time, 
        d.total_elapsed_time / d.execution_count/1000000 
                                        AS [avg_elapsed_time] , 
        d.last_elapsed_time/1000000     AS last_elapsed_time, 
        d.execution_count , 
        d.total_physical_reads , 
        d.last_physical_reads , 
        d.total_logical_writes , 
        d.last_logical_reads , 
        et.text SQLText , 
        eqp.query_plan executionplan 
FROM    sys.dm_exec_procedure_stats AS d 
CROSS APPLY sys.dm_exec_sql_text(d.sql_handle) et 
CROSS APPLY sys.dm_exec_query_plan(d.plan_handle) eqp 
WHERE   OBJECT_NAME(object_id, database_id) = 'xxxx' 
ORDER BY [total_worker_time] DESC; 
```

82. 查看当前用户 

```sql
select system_user 
```

\83. 查询ddl修改操作的记录 

-执行如下找到trace文件的目录和名称 

```sql
select * from Sys.traces
```

-使用sqlserver profiler工具打开trace文件，就可以查到相关记录