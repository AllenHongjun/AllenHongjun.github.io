---
title: sqlserver知识点拾遗
date: 2021-11-13 08:55:19
tags:
categories:
- 数据库
- 关系型
---


> 查询和整理出自己数据库知识的一些盲点 容易遗漏的点

<!-- more -->

还有几个知识点 后续有空再回头学习吧。。本地搭建一些测试环境。注册复制的。分布式多台缓存服务器的。等等情况



### **常用的数据库操作语句 alter 索引 约束 外键 等 Transact-SQL 语句**

[https://docs.microsoft.com/zh-cn/sql/t-sql/statements/statements?view=sql-server-ver15](https://docs.microsoft.com/zh-cn/sql/t-sql/statements/statements?view=sql-server-ver15)

> 还是官方文档最全面 查找 table 约束 对应的目录下 

[添加外键 SQL server中如何设置外键](https://blog.csdn.net/u012965373/article/details/39928401)  外键名称规范： FK_ForeignKeyTable_PrimaryKeyTable

如何来创建和修改索引？[https://segmentfault.com/a/1190000016560785](https://segmentfault.com/a/1190000016560785) ix_tablename_col1_col2



### [数据库文档生成工具](https://segmentfault.com/a/1190000023546317)



### **SQL Server 触发器:** [https://www.cnblogs.com/hoojo/archive/2011/07/20/2111316.html](https://www.cnblogs.com/hoojo/archive/2011/07/20/2111316.html)



### **游标**

游标的定义和使用 While Fetch ?[https://www.codenong.com/cs106349592/](https://www.codenong.com/cs106349592/)

SQL Server基础之游标: [https://www.cnblogs.com/selene/p/4480328.html](https://www.cnblogs.com/selene/p/4480328.html)



### **锁机制**



nolock 查询  共享锁保证了其他事务不能写，排他锁保证了其他事物不能读。

 [共享锁与排它锁区别（转）](https://www.cnblogs.com/panxuejun/p/9054080.html)

[sql查询，nolock写还是不写，这是一个问题](https://www.cnblogs.com/jeffwongishandsome/archive/2010/01/21/1652254.html)

select * from UserInfo --with(nolock)--不对查询添加共享锁

[https://blog.51cto.com/u_15316082/3220299](https://blog.51cto.com/u_15316082/3220299)





### [什么是 SQL Server Management Studio (SSMS)？](https://docs.microsoft.com/zh-cn/sql/ssms/sql-server-management-studio-ssms?view=sql-server-ver15)



### **主从复制数据库  读写分离使用**



[教程：为复制准备 SQL Server（发布服务器、分发服务器、订阅服务器）](https://docs.microsoft.com/zh-cn/sql/relational-databases/replication/tutorial-preparing-the-server-for-replication?view=sql-server-2017)

[Windows SQL Server 主从复制](https://b.sundayle.com/sql-server-replication/)

[sql server 主从配置](https://www.cnblogs.com/xuefy/p/12357194.html)

[基于SQL Server数据库搭建主从复制实现读写分离实战演练](https://cloud.tencent.com/developer/article/1584682)

[MySQL主从复制读写分离](https://segmentfault.com/a/1190000023775512)

### [如何实现 MySQL 的读写分离？](https://doocs.github.io/advanced-java/#/./docs/high-concurrency/mysql-read-write-separation?id=如何实现-mysql-的读写分离？)



### **SQL server 管理操作**

备份还原 附加 导入 [用分离、附加的方式实现sql server数据库的备份和还原](https://www.cnblogs.com/xqzt/p/5734579.html)

设置用户角色权限限制 [[SQL Server 权限管理](https://www.cnblogs.com/chenmh/p/4080420.html)](https://www.cnblogs.com/chenmh/p/4080420.html)

数据库监视 [https://docs.microsoft.com/zh-cn/sql/relational-databases/performance/monitor-and-tune-for-performance?view=sql-server-ver15](https://docs.microsoft.com/zh-cn/sql/relational-databases/performance/monitor-and-tune-for-performance?view=sql-server-ver15)

数据库安装  [手把手教你安装SqlServer](https://zhuanlan.zhihu.com/p/139170923)

[彻底卸载SQL Server详细步骤](https://www.modb.pro/db/53769)



------

### **索引**

- 频繁进行排序或分组（即进行GROUP BY 或ORDER BY操作）的列上建立索引，如果待排序的列有多个，可以在这些列上建立组合索引。
- 在条件表达式中经常用到的、不同值较多的列上建立索引

为什么使用索引？[https://www.cnblogs.com/selene/p/4474721.html#_label1](https://www.cnblogs.com/selene/p/4474721.html#_label1)

 [mysql索引使用技巧及注意事项](https://www.cnblogs.com/heyonggang/p/6610526.html)





### **窗口函数学习使用**

**[通俗易懂的学会：SQL窗口函数](https://zhuanlan.zhihu.com/p/92654574)**

**ROWNUMBER() OVER() ** 

over 字句的使用： [https://docs.microsoft.com/zh-cn/sql/t-sql/queries/select-over-clause-transact-sql?redirectedfrom=MSDN&view=sql-server-ver15#examples](https://docs.microsoft.com/zh-cn/sql/t-sql/queries/select-over-clause-transact-sql?redirectedfrom=MSDN&view=sql-server-ver15#examples)

[SQL Server ROW_NUMBER()函数简介](https://www.yiibai.com/sqlserver/sql-server-row_number-function.html)

[总结SQL Server窗口函数的简单使用](https://www.cnblogs.com/jeffwongishandsome/archive/2010/12/04/1896672.html)

[SQL Server中的窗口函数](https://www.cnblogs.com/CareySon/p/3411176.html)





### **数据库创建作业来执行定时的任务？** [https://www.cnblogs.com/mq0036/p/12916419.html](https://www.cnblogs.com/mq0036/p/12916419.html)

> 新建一个作业其实挺简单的。操作测试一遍就可以了

作业是在代理里面 可以管理服务器的所有数据库的作业都是在里面同意管理

作业Job 作业命名  exec 存储过程名 步骤命名 计划 命名 plan1 plan2 

同时需要先系统 sql server 代理服务。

作业通过脚本如何来创建  可以在测试库新建玩作业之后。然后更新到正式服务器

[如何备份和还原 SQL 代理作业](https://docs.microsoft.com/zh-cn/biztalk/core/how-to-back-up-and-restore-sql-agent-jobs)

[数据库迁移必备--批量导出定时作业](https://blog.csdn.net/z10843087/article/details/78781481)  注意数据库名称可能不同。需要修改还原和备份

有些业务不能再存储过程中执行。就需要使用定时任务。





### **使用存储过程利弊** 

> 不管有什么优缺点。既然项目中使用那么多。还是要学会使用。。比较复杂的查询业务处理。。简单能在代码中处理 还是在代码中处理好。互联网系统 存储过程使用的比较少  mysql  使用存储过程比较少。

根据之前 存储过程的命名习惯 关键字来查询 Admin QT HT Product Order GoodStock Check Coupon Comment Stat Sys Member Cart GiftCard

但是有些根据具体的业务来查找某一个存储过程 这个命名 真的很难找到

优点

①重复使用。存储过程可以重复使用，从而可以减少数据库开发人员的工作量。

②减少网络流量。存储过程位于服务器上，调用的时候只需要传递存储过程的名称以及参数就可以了，因此降低了网络传输的数据量。

③安全性。参数化的存储过程可以防止SQL注入式攻击，而且可以将Grant、Deny以及Revoke权限应用于存储过程。

简单讲：

1.存储过程只在创造时进行编译，以后每次执行存储过程都不需再重新编译，而一般SQL语句每执行一次就编译一次,所以使用存储过程可提高数据库执行速度。

2.当对数据库进行复杂操作时(如对多个表进行Update,Insert,Query,Delete时)，可将此复杂操作用存储过程封装起来与数据库提供的事务处理结合一起使用。

3.存储过程可以重复使用,可减少数据库开发人员的工作量

4.安全性高,可设定只有某些用户才具有对指定存储过程的使用权

有一点需要注意的是，一些网上盛传的所谓的存储过程要比sql语句执行更快的说法，实际上是个误解，并没有根据，包括微软内部的人也不认可这一点，所以不能作为正式的优点，希望大家能够认识到这一点。

缺点

1：**调试麻烦**，但是用 PL/SQL Developer 调试很方便！弥补这个缺点。

2：**移植问题**，数据库端代码当然是与数据库相关的。但是如果是做工程型项目，基本不存在移植问题。

3：重新编译问题，因为后端代码是运行前编译的，如果带有引用关系的对象发生改变时，受影响的存储过程、包将需要重新编译（不过也可以设置成运行时刻自动编译）。

4： 如果在一个程序系统中大量的使用存储过程，到程序交付使用的时候随着用户需求的增加会导致数据结构的变化，接着就是系统的相关问题了，最后如果用户想维护该系统可以说是很难很难、而且代价是空前的，维护起来更麻烦。



### **数据库链接服务器的使用**

[链接服务器（数据库引擎）](https://docs.microsoft.com/zh-cn/sql/relational-databases/linked-servers/linked-servers-database-engine?view=sql-server-ver15)

[SQL Server链接服务器-创建](https://www.yiibai.com/sql_server/linked_servers.html)

[SQLServer之创建链接服务器](https://www.cnblogs.com/vuenote/p/10611411.html)

[SQL Server跨库查询](https://www.cnblogs.com/xulele/p/5327939.html)

```sql
-- sql server 跨库查询
SELECT * FROM  AdventureWorks2008.dbo.ErrorLog a, FreshDB_Dev.dbo.Orders b 
```







```sql
--select newid()

--create Table TestIndex
--(
--	Id int identity(1,1)  primary key not null,
--	Name nvarchar(32) null
--)

create Table MyCreatIndexTest
(
	Id int identity(1,1)  not null,
	Age int null,
	Name nvarchar(32) null,
	Phone nvarchar(16)
)

create CLUSTERED Index  IX_MyCreatIndexTest_Age on MyCreatIndexTest(Age) 

alter table MyCreatIndexTest add constraint
 PK_MyCreatIndexTest_Id primary key(Id)



 create index IX_MyCreatIndexTest_Name on
  MyCreatIndexTest(Name)

   create unique nonclustered index IX_MyCreatIndexTest_Phone on
  MyCreatIndexTest(Phone)


  --加索引： 经常使用的 过滤条件的列 上加索引。where nmae=
```



### **系统函数使用**

常用的函数有哪些如何使用？[https://www.cnblogs.com/MR_ke/archive/2010/02/22/1671296.html](https://www.cnblogs.com/MR_ke/archive/2010/02/22/1671296.html)

[SQL 数据库函数有哪些？](https://docs.microsoft.com/zh-cn/sql/t-sql/functions/functions?view=sql-server-ver15)

```sql
----------类型转换---------------
--select * from SalesLT.Customer

--select CustomerId+Title from SalesLT.Customer

--类型转换
	-->  Convert(目标类型，转换的表达式，格式规范)
	-->  Cast（表达 as 类型）

--select Convert(nvarchar(32), CustomerId)+Title from SalesLT.Customer

--select cast(CustomerId as nvarchar(32))+Title from SalesLT.Customer

--use [ItcastDB]

--select * from  [dbo].[tblStudent]
----快速创建表的方式。  
--select * into tblStudent2 from tblStudent
--where stuid>5

--select * from  [dbo].[tblStudent2]

-- 把[tblStudent2]和 [tblStudent] 两个表的数据联合起来
--select stuId, stuName, stuSex, stuBirthdate, stuPhone
-- from dbo.tblStudent
-- union all
-- --union  会进行去重操作，效率非常低。
-- select stuId, stuName, stuSex, stuBirthdate, stuPhone
-- from dbo.tblStudent2

--select * from tblStudent2

--set Identity_Insert tblStudent2 on
--go
--insert into tblStudent2(stuId,stuName) values(112,'sss')

----批量向一个已经存在的表中添加  数据
--insert into tblStudent2(stuId, stuName, stuSex, stuBirthdate, stuPhone) select stuId, stuName, stuSex, stuBirthdate, stuPhone from tblStudent where stuid<5
--go
--set Identity_Insert tblStudent2 off

-----------日期函数---------------------
--获取当前日期
--select getdate()
--dateadd(单位，个数，日期)
--select DATEADD(day,1,'2015-3-1')

-----***************
--select DATEDIFF(MONTH,'2015-5-1','2015-5-9')

--select  datepart(MONTH,'2014-4-3')
--select year('2014-5-6')

------字符串函数

--select LOWER(stuName) from tblStudent

--select ASCII('a')

--select LEFT('123456',4)

--select Right('123456',4)

--select datalength(N'1234')
--select RTRIM('    123  ')

--use [SqlDemos]
```







### **一条sql 语句的执行过程？** [https://www.cnblogs.com/wyq178/p/11576065.html](https://www.cnblogs.com/wyq178/p/11576065.html)







### **TSQL脚本编程？**[SQL Server Transact-SQL 编程](https://www.cnblogs.com/hoojo/archive/2011/07/15/2107740.html)  [https://www.cnblogs.com/hong-fithing/p/7637948.html](https://www.cnblogs.com/hong-fithing/p/7637948.html)





