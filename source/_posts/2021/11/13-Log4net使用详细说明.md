---
title: Log4net使用详细说明
date: 2021-11-13 17:06:09
tags:
categories:
---





# 1、概述

log4net是.Net下一个非常优秀的开源日志记录组件。log4net记录日志的功能非常强大。它可以将日志分不同的等级，以不同的格式，输出到不同的媒介。本文主要是介绍如何在Visual Studio2008中使用log4net快速创建系统日志，如何扩展以输出自定义字段。



<!-- more -->



# 2、一个简单的使用实例

**第一步：**在项目中添加对log4net.dll的引用，这里引用版本是1.2.10.0。

**第二步：**程序启动时读取log4net的配置文件。

如果是CS程序，在根目录的Program.cs中的Main方法中添加：

log4net.Config.XmlConfigurator.Configure();

如果是BS程序，在根目录的Global.asax.cs（没有新建一个）中的Application_Start方法中添加：

log4net.Config.XmlConfigurator.Configure();

无论BS还是CS程序都可直接在项目的AssemblyInfo.cs文件里添加以下的语句：

[assembly: log4net.Config .XmlConfigurator()]

也可以使用自定义的配置文件，具体请参见4.4 关联配置文件。

**第三步：**修改配置文件。如果是CS程序，则在默认的App.config文件（没有新建一个）中添加内容；如果是BS程序，则添加到Web.config文件中，添加内容一样，这里不再列出。

App.config文件添加内容如下：

 

```xml
 1 <?xml version="1.0" encoding="utf-8" ?>
 2 
 3 <configuration>
 4 
 5   <configSections>
 6 
 7 <section name="log4net"
 8 
 9 type="log4net.Config.Log4NetConfigurationSectionHandler, log4net" />
10 
11   </configSections>
12 
13  
14 
15   <log4net>
16 
17     <root>
18 
19       <level value="WARN" />
20 
21       <appender-ref ref="LogFileAppender" />
22 
23       <appender-ref ref="ConsoleAppender" />
24 
25     </root>
26 
27  
28 
29     <logger name="testApp.Logging">
30 
31       <level value="DEBUG"/>
32 
33     </logger>
34 
35  
36 
37     <appender name="LogFileAppender" type="log4net.Appender.FileAppender" >
38 
39       <param name="File" value="log-file.txt" />
40 
41       <param name="AppendToFile" value="true" />
42 
43  
44 
45       <layout type="log4net.Layout.PatternLayout">
46 
47         <param name="Header" value="[Header] "/>
48 
49         <param name="Footer" value="[Footer] "/>
50 
51         <param name="ConversionPattern" value="%d [%t] %-5p %c [%x]  - %m%n" />
52 
53       </layout>
54 
55  
56 
57       <filter type="log4net.Filter.LevelRangeFilter">
58 
59         <param name="LevelMin" value="DEBUG" />
60 
61         <param name="LevelMax" value="WARN" />
62 
63       </filter>
64 
65     </appender>
66 
67  
68 
69     <appender name="ConsoleAppender"  type="log4net.Appender.ConsoleAppender" >
70 
71       <layout type="log4net.Layout.PatternLayout">
72 
73         <param name="ConversionPattern"  value="%d [%t] %-5p %c [%x] - %m%n" />
74 
75       </layout>
76 
77     </appender> 
78 
79   </log4net>
80 
81 </configuration>
```

 

**第四步：**在程序使用。

log4net.ILog log = log4net.LogManager.GetLogger("testApp.Logging");//获取一个日志记录器

log.Info(DateTime.Now.ToString() + ": login success");//写入一条新log

这样就将信息同时输出到控制台和写入到文件名为“log-file.txt”的文件中，其中“log-file.txt”文件的路径是当前程序运行所在目录；也可以定义为绝对路径，配置如：

<param name="File" value="C:/log-file.txt" />就写入C盘根目录下log-file.txt文件中

# 3、Log4net的主要组成部分

## 3.1 Appenders

Appenders用来定义日志的输出方式，即日志要写到那种介质上去。较常用的Log4net已经实现好了，直接在配置文件中调用即可，可参见上面配置文件例子；当然也可以自己写一个，需要从log4net.Appender.AppenderSkeleton类继承。它还可以通过配置Filters和Layout来实现日志的过滤和输出格式。

已经实现的输出方式有：

AdoNetAppender 将日志记录到数据库中。可以采用SQL和存储过程两种方式。

AnsiColorTerminalAppender 将日志高亮输出到ANSI终端。

AspNetTraceAppender 能用asp.net中Trace的方式查看记录的日志。

BufferingForwardingAppender 在输出到子Appenders之前先缓存日志事件。

ConsoleAppender 将日志输出到应用程序控制台。

EventLogAppender 将日志写到Windows Event Log。

FileAppender 将日志输出到文件。

ForwardingAppender 发送日志事件到子Appenders。

LocalSyslogAppender 将日志写到local syslog service (仅用于UNIX环境下)。

MemoryAppender 将日志存到内存缓冲区。

NetSendAppender 将日志输出到Windows Messenger service.这些日志信息将在用户终端的对话框中显示。

OutputDebugStringAppender 将日志输出到Debuger，如果程序没有Debuger，就输出到系统Debuger。如果系统Debuger也不可用，将忽略消息。

RemoteSyslogAppender 通过UDP网络协议将日志写到Remote syslog service。

RemotingAppender 通过.NET Remoting将日志写到远程接收端。

RollingFileAppender 将日志以回滚文件的形式写到文件中。

SmtpAppender 将日志写到邮件中。

SmtpPickupDirAppender 将消息以文件的方式放入一个目录中，像IIS SMTP agent这样的SMTP代理就可以阅读或发送它们。

TelnetAppender 客户端通过Telnet来接受日志事件。

TraceAppender 将日志写到.NET trace 系统。

UdpAppender 将日志以无连接UDP数据报的形式送到远程宿主或用UdpClient的形式广播。

## 3.2 Filters

使用过滤器可以过滤掉Appender输出的内容。过滤器通常有以下几种：

DenyAllFilter 阻止所有的日志事件被记录

LevelMatchFilter 只有指定等级的日志事件才被记录

LevelRangeFilter 日志等级在指定范围内的事件才被记录

LoggerMatchFilter 与Logger名称匹配，才记录

PropertyFilter 消息匹配指定的属性值时才被记录

StringMathFilter 消息匹配指定的字符串才被记录

## 3.3 Layouts

Layout用于控制Appender的输出格式，可以是线性的也可以是XML。

一个Appender只能有一个Layout。

最常用的Layout应该是经典格式的**PatternLayout**，其次是SimpleLayout，**RawTimeStampLayout**和ExceptionLayout。然后还有IRawLayout，XMLLayout等几个，使用较少。Layout可以自己实现，需要从log4net.Layout.LayoutSkeleton类继承，来输出一些特殊需要的格式，在后面扩展时就重新实现了一个Layout。

SimpleLayout简单输出格式，只输出日志级别与消息内容。

**RawTimeStampLayout** 用来格式化时间，在向数据库输出时会用到。

样式如“yyyy-MM-dd HH:mm:ss“

ExceptionLayout需要给Logger的方法传入Exception对象作为参数才起作用，否则就什么也不输出。输出的时候会包含Message和Trace。

PatterLayout使用最多的一个Layout，能输出的信息很多，使用方式可参见上面例子中的配置文件。PatterLayout的格式化字符串见文后附注8.1。

## 3.4 Loggers

Logger是直接和应用程序交互的组件。Logger只是产生日志，然后由它引用的Appender记录到指定的媒介，并由Layout控制输出格式。

Logger提供了多种方式来记录一个日志消息，也可以有多个Logger同时存在。每个实例化的Logger对象对被log4net作为命名实体（Named Entity）来维护。log4net使用继承体系，也就是说假如存在两个Logger，名字分别为a.b.c和a.b。那么a.b就是a.b.c的祖先。每个Logger都继承了它祖先的属性。所有的Logger都从Root继承,Root本身也是一个Logger。

日志的等级，它们由高到底分别为：

OFF > FATAL > ERROR > WARN > INFO > DEBUG > ALL 

高于等级设定值方法（如何设置参见“配置文件详解”）都能写入日志， Off所有的写入方法都不写到日志里，ALL则相反。例如当我们设成Info时，logger.Debug就会被忽略而不写入文件，但是FATAL,ERROR,WARN,INFO会被写入，因为他们等级高于INFO。

在具体写日志时，一般可以这样理解日志等级：

FATAL（致命错误）：记录系统中出现的能使用系统完全失去功能，服务停止，系统崩溃等使系统无法继续运行下去的错误。例如，数据库无法连接，系统出现死循环。

ERROR（一般错误）：记录系统中出现的导致系统不稳定，部分功能出现混乱或部分功能失效一类的错误。例如，数据字段为空，数据操作不可完成，操作出现异常等。

WARN（警告）：记录系统中不影响系统继续运行，但不符合系统运行正常条件，有可能引起系统错误的信息。例如，记录内容为空，数据内容不正确等。

INFO（一般信息）：记录系统运行中应该让用户知道的基本信息。例如，服务开始运行，功能已经开户等。

DEBUG （调试信息）：记录系统用于调试的一切信息，内容或者是一些关键数据内容的输出。

Logger实现的ILog接口，ILog定义了5个方法（Debug,Inof,Warn,Error,Fatal）分别对不同的日志等级记录日志。这5个方法还有5个重载。以Debug为例说明一下，其它的和它差不多。

ILog中对Debug方法的定义如下：

void Debug(object message);

void Debug(object message, Exception ex);

还有一个布尔属性：

bool IsDebugEnabled { get; }

如果使用Debug(object message, Exception ex)，则无论Layout中是否定义了%exception，默认配置下日志都会输出Exception。包括Exception的Message和Trace。如果使用Debug(object message)，则日志是不会输出Exception。

最后还要说一个LogManager类，它用来管理所有的Logger。它的GetLogger静态方法，可以获得配置文件中相应的Logger：

log4net.ILog log = log4net.LogManager.GetLogger("logger-name");

## 3.5 Object Renders

它将告诉logger如何把一个对象转化为一个字符串记录到日志里。（ILog中定义的接口接收的参数是Object，而不是String。）

例如你想把Orange对象记录到日志中，但此时logger只会调用Orange默认的ToString方法而已。所以要定义一个OrangeRender类实现log4net.ObjectRender.IObjectRender接口，然后注册它（我们在本文中的扩展不使用这种方法，而是直接实现一个自定义的Layout）。这时logger就会知道如何把Orange记录到日志中了。

## 3.6 Repository

Repository主要用于日志对象组织结构的维护。

# 4、配置文件详解

## 4.1 配置文件构成

主要有两大部分，一是申明一个名为“log4net“的自定义配置节，如下所示：

 

```xml
1 <configSections>
2 
3 <section name="log4net"
4 
5 type="log4net.Config.Log4NetConfigurationSectionHandler, log4net" />
6 
7   </configSections>
```

 

二是<log4net>节的具体配置，这是下面要重点说明的。

### 4.1.1<log4net>

所有的配置都要在<log4net>元素里定义。

支持的属性：

| debug     | 可选，取值是true或false，默认是false。设置为true，开启log4net的内部调试。 |
| --------- | ------------------------------------------------------------ |
| update    | 可选，取值是Merge(合并)或Overwrite(覆盖)，默认值是Merge。设置为Overwrite，在提交配置的时候会重置已经配置过的库。 |
| threshold | 可选，取值是repository（库）中注册的level，默认值是ALL。     |

支持的子元素：

| appender | 0或多个  |
| -------- | -------- |
| logger   | 0或多个  |
| renderer | 0或多个  |
| root     | 最多一个 |
| param    | 0或多个  |

 

### 4.1.2 <root>

实际上就是一个根logger，所有其它logger都默认继承它，如果配置文件里没有显式定义，则框架使用根日志中定义的属性。root元素没有属性。

支持的子元素：

| appender-ref | 0个或多个，要引用的appender的名字。               |
| ------------ | ------------------------------------------------- |
| level        | 最多一个。 只有在这个级别或之上的事件才会被记录。 |
| param        | 0个或多个， 设置一些参数。                        |

 

### 4.1.3 <logger>

支持的属性：

| name       | 必须的，logger的名称                                         |
| ---------- | ------------------------------------------------------------ |
| additivity | 可选，取值是true或false，默认值是true。设置为false时将阻止父logger中的appender。 |

支持的子元素：

| appender-ref | 0个或多个，要引用的appender的名字。               |
| ------------ | ------------------------------------------------- |
| level        | 最多一个。 只有在这个级别或之上的事件才会被记录。 |
| param        | 0个或多个， 设置一些参数。                        |

 

### 4.1.4 <appender>

定义日志的输出方式，只能作为 log4net 的子元素。name属性必须唯一，type属性必须指定。

支持的属性：

| name | 必须的，Appender对象的名称     |
| ---- | ------------------------------ |
| type | 必须的，Appender对象的输出类型 |

支持的子元素：

| appender-ref | 0个或多个，允许此appender引用其他appender，并不是所以appender类型都支持。 |
| ------------ | ------------------------------------------------------------ |
| filter       | 0个或多个，定义此app使用的过滤器。                           |
| layout       | 最多一个。定义appender使用的输出格式。                       |
| param        | 0个或多个， 设置Appender类中对应的属性的值。                 |

实际上<appender>所能包含的子元素远不止上面4个。

 

### 4.1.5 <layout>

布局，只能作为<appender>的子元素。

支持的属性：

| type | 必须的，Layout的类型 |
| ---- | -------------------- |
|      |                      |

支持的子元素：

| param | 0个或多个， 设置一些参数。 |
| ----- | -------------------------- |
|       |                            |

 

### 4.1.6 <filter>

过滤器，只能作为<appender>的子元素。

支持的属性：

| type | 必须的，Filter的类型 |
| ---- | -------------------- |
|      |                      |

支持的子元素：

| param | 0个或多个， 设置一些参数。 |
| ----- | -------------------------- |
|       |                            |

 

### 4.1.7 <param>

<param>元素可以是任何元素的子元素。

支持的属性：

| name  | 必须的，取值是父对象的参数名。                               |
| ----- | ------------------------------------------------------------ |
| value | 可选的，value和type中，必须有一个属性被指定。value是一个能被转化为参数值的字符串。 |
| type  | 可选的，value和type中，必须有一个属性被指定。type是一个类型名，如果type不是在log4net程序集中定义的，就需要使用全名。 |

支持的子元素：

| param | 0个或多个， 设置一些参数。 |
| ----- | -------------------------- |
|       |                            |

 

## 4.2 <appender>配置

  <appender>在配置文件中至少有一个，也可以有多个，有些<appender>类型还可以引用其他<appender>类型，具体参数可参见上表。

下面只对写入回滚文件与输出到数据库（这里使用SQL数据库）配置体会说一下，其他配置可参考官方网站：http://logging.apache.org/log4net/release/config-examples.html

### 4.2.1写入回滚文件

 

```xml
  1  <appender name="ReflectionLayout" type="log4net.Appender.RollingFileAppender,log4net">
  2 
  3 <!--日志文件路径，“/”与“/”作用相同，到达的目录相同，文件夹不存在则新建 -->
  4 
  5 <!--按文件大小方式输出时在这里指定文件名，并且当天的日志在下一天时在文件名后自动追加当天日期形成新文件。-->
  6 
  7 <!—按照日期形式输出时，直接连接元素DatePattern的value形成文件路径。此处使用这种方式 -->
  8 
  9 <!--param的名称,可以直接查对应的appender类的属性名即可,这里要查的就是RollingFileAppender类的属性 -->
 10 
 11       <param name="File" value="D:/Log/" />
 12 
 13  
 14 
 15       <!--是否追加到文件-->
 16 
 17       <param name="AppendToFile" value="true" />
 18 
 19  
 20 
 21       <!--记录日志写入文件时，不锁定文本文件，防止多线程时不能写Log,官方说线程非安全-->
 22 
 23       <lockingModel type="log4net.Appender.FileAppender+MinimalLock" />
 24 
 25  
 26 
 27       <!—使用Unicode编码-->
 28 
 29       <Encoding value="UTF-8" />
 30 
 31  
 32 
 33       <!--最多产生的日志文件数，超过则只保留最新的n个。设定值value="－1"为不限文件数-->
 34 
 35       <param name="MaxSizeRollBackups" value="10" />
 36 
 37  
 38 
 39       <!--是否只写到一个文件中-->
 40 
 41       <param name="StaticLogFileName" value="false" />
 42 
 43  
 44 
 45       <!--按照何种方式产生多个日志文件(日期[Date],文件大小[Size],混合[Composite])-->
 46 
 47       <param name="RollingStyle" value="Composite" />
 48 
 49  
 50 
 51       <!--按日期产生文件夹和文件名［在日期方式与混合方式下使用］-->
 52 
 53 <!—此处按日期产生文件夹，文件名固定。注意&quot; 的位置-->
 54 
 55       <param name="DatePattern" value="yyyy-MM-dd/&quot;ReflectionLayout.log&quot;"  />
 56 
 57 <!—这是按日期产生文件夹，并在文件名前也加上日期-->
 58 
 59       <param name="DatePattern" value="yyyyMMdd/yyyyMMdd&quot;-TimerServer.log&quot;"  />
 60 
 61 <!—这是先按日期产生文件夹，再形成下一级固定的文件夹—>
 62 
 63       <param name="DatePattern" value="yyyyMMdd/&quot;TimerServer/TimerServer.log&quot;"  />
 64 
 65  
 66 
 67       <!--每个文件的大小。只在混合方式与文件大小方式下使用。
 68 
 69 超出大小后在所有文件名后自动增加正整数重新命名，数字最大的最早写入。
 70 
 71 可用的单位:KB|MB|GB。不要使用小数,否则会一直写入当前日志-->
 72 
 73       <param name="maximumFileSize" value="500KB" />
 74 
 75  
 76 
 77 <!--计数类型为1，2，3…-->
 78       <param name="CountDirection" value="1"/>
 79 
 80  
 81 
 82 <!—过滤设置，LevelRangeFilter为使用的过滤器。 -->
 83 
 84       <filter type="log4net.Filter.LevelRangeFilter">
 85 
 86         <param name="LevelMin" value="DEBUG" />
 87 
 88         <param name="LevelMax" value="WARN" />
 89 
 90       </filter>
 91 
 92  
 93 
 94       <!--记录的格式。一般用log4net.Layout.PatternLayout布局-->
 95 
 96 <!—此处用继承了log4net.Layout.PatternLayout的自定义布局，TGLog.ExpandLayout2
 97 
 98 为命名空间。%property{Operator}、%property{Action}是自定义的输出-－>
 99 
100       <layout type="TGLog.ExpandLayout2.ReflectionLayout,TGLog">
101 
102         <param name="ConversionPattern"
103 
104  value="记录时间：%date 线程ID:[%thread] 日志级别：%-5level 记录类：%logger     操作者ID：%property{Operator} 操作类型：%property{Action}%n             当前机器名:%property%n当前机器名及登录用户：%username %n               记录位置：%location%n 消息描述：%property{Message}%n                    异常：%exception%n 消息：%message%newline%n%n" />
105 
106       </layout>
107 
108 </appender>
```

 

### 4.2.1写入SQL数据库

需要在相应的数据库中准备好一张表，创建语句如下：

 

```C#
 1 CREATE TABLE [Log] (
 2 
 3 [ID] [int] IDENTITY (1, 1) NOT NULL ,
 4 
 5 [Date] [datetime] NOT NULL ,
 6 
 7 [Thread] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
 8 
 9 [Level] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
10 
11 [Logger] [varchar] (200) COLLATE Chinese_PRC_CI_AS NULL ,
12 
13 [Operator] [int] NULL ,
14 
15 [Message] [text] COLLATE Chinese_PRC_CI_AS NULL ,
16 
17 [ActionType] [int] NULL ,
18 
19 [Operand] [varchar] (300) COLLATE Chinese_PRC_CI_AS NULL ,
20 
21 [IP] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
22 
23 [MachineName] [varchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
24 
25 [Browser] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
26 
27 [Location] [text] COLLATE Chinese_PRC_CI_AS NULL ,
28 
29 [Exception] [text] COLLATE Chinese_PRC_CI_AS NULL
30 
31 )
```

 

 

```xml
  1 <appender name="ADONetAppender" type="log4net.Appender.ADONetAppender,log4net">
  2 
  3 <!--BufferSize为缓冲区大小，只有日志记录超设定值才会一块写入到数据库-->
  4 
  5 <bufferSize value="10" /><!—或写为<param name="BufferSize" value="10" />-->
  6 
  7  
  8 
  9 <!--引用-->
 10 
 11 <connectionType value="System.Data.SqlClient.SqlConnection, System.Data, Version=1.0.3300.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" />
 12 
 13  
 14 
 15 <!--连接数据库字符串-->
 16 
 17 <connectionString value="data source=.;initial catalog=Test;integrated security=false;persist security info=True;User ID=sa;Password=;" />
 18 
 19  
 20 
 21 <!--插入到表Log-->
 22 
 23 <commandText value="INSERT INTO Log ([Date],[Thread],[Level],[Logger],[Operator],[Message],[ActionType],[Operand],[IP],[MachineName],[Browser],[Location],[Exception]) VALUES (@log_date, @thread, @log_level, @logger,@operator, @message,@action_type,@operand,@ip,@machineName,@browser,@location,@exception)" />
 24 
 25  
 26 
 27 <!—日志记录时间，RawTimeStampLayout为默认的时间输出格式 -->
 28 
 29       <parameter>
 30 
 31         <parameterName value="@log_date" />
 32 
 33         <dbType value="DateTime" />
 34 
 35         <layout type="log4net.Layout.RawTimeStampLayout" />
 36 
 37       </parameter>
 38 
 39  
 40 
 41       <!--线程号-->
 42 
 43       <parameter>
 44 
 45         <parameterName value="@thread" />
 46 
 47         <dbType value="String" />
 48 
 49 <!—长度不可以省略，否则不会输出-->
 50 
 51         <size value="100" />
 52 
 53         <layout type="log4net.Layout.PatternLayout">
 54 
 55           <conversionPattern value="%thread" />
 56 
 57         </layout>
 58 
 59       </parameter>
 60 
 61  
 62 
 63       <!--日志等级-->
 64 
 65       <parameter>
 66 
 67         <parameterName value="@log_level" />
 68 
 69         <dbType value="String" />
 70 
 71         <size value="100" />
 72 
 73         <layout type="log4net.Layout.PatternLayout">
 74 
 75           <conversionPattern value="%level" />
 76 
 77         </layout>
 78 
 79       </parameter>
 80 
 81  
 82 
 83       <!--日志记录类名称-->
 84 
 85       <parameter>
 86 
 87         <parameterName value="@logger" />
 88 
 89         <dbType value="String" />
 90 
 91         <size value="200" />
 92 
 93         <layout type="log4net.Layout.PatternLayout">
 94 
 95           <conversionPattern value="%logger" />
 96 
 97         </layout>
 98 
 99       </parameter>
100 
101      
102 
103       <!--操作者。这个是自定义的输出字段，使用重新实现的布局器ReflectionLayout -->
104 
105       <parameter>
106 
107         <parameterName value="@operator" />
108 
109 <!—设置为Int32时只有bufferSize的 value<="1"才正确输出，没有找出原因。-->
110 
111         <dbType value="Int16" />
112 
113         <layout type="TGLog.ExpandLayout2.ReflectionLayout,TGLog">
114 
115           <conversionPattern value="%property{Operator}" />
116 
117         </layout>
118 
119       </parameter>
120 
121  
122 
123       <!--操作对象-->
124 
125       <parameter>
126 
127         <parameterName value="@operand" />
128 
129         <dbType value="String" />
130 
131         <size value="300" />
132 
133         <layout type="TGLog.ExpandLayout2.ReflectionLayout,TGLog">
134 
135           <conversionPattern value="%property{Operand}" />
136 
137         </layout>
138 
139       </parameter>
140 
141  
142 
143       <!—IP地址-->
144 
145       <parameter>
146 
147         <parameterName value="@ip" />
148 
149         <dbType value="String" />
150 
151         <size value="20" />
152 
153         <layout type="TGLog.ExpandLayout2.ReflectionLayout,TGLog">
154 
155           <conversionPattern value="%property{IP}" />
156 
157         </layout>
158 
159       </parameter>
160 
161  
162 
163       <!--机器名-->
164 
165       <parameter>
166 
167         <parameterName value="@machineName" />
168 
169         <dbType value="String" />
170 
171         <size value="100" />
172 
173         <layout type="TGLog.ExpandLayout2.ReflectionLayout,TGLog">
174 
175           <conversionPattern value="%property{MachineName}" />
176 
177         </layout>
178 
179       </parameter>
180 
181  
182 
183       <!--浏览器-->
184 
185       <parameter>
186 
187         <parameterName value="@browser" />
188 
189         <dbType value="String" />
190 
191         <size value="50" />
192 
193         <layout type="TGLog.ExpandLayout2.ReflectionLayout,TGLog">
194 
195           <conversionPattern value="%property{Browser}" />
196 
197         </layout>
198 
199       </parameter>
200 
201      
202 
203       <!—日志消息-->
204 
205       <parameter>
206 
207         <parameterName value="@message" />
208 
209         <dbType value="String" />
210 
211         <size value="3000" />
212 
213         <layout type="TGLog.ExpandLayout2.ReflectionLayout,TGLog">
214 
215           <conversionPattern value="%property{Message}" />
216 
217         </layout>
218 
219       </parameter>
220 
221  
222 
223       <!--动作类型-->
224 
225       <parameter>
226 
227         <parameterName value="@action_type" />
228 
229         <dbType value="Int16" />
230 
231         <layout type="TGLog.ExpandLayout2.ReflectionLayout,TGLog">
232 
233           <conversionPattern value="%property{ActionType}" />
234 
235         </layout>
236 
237       </parameter>
238 
239  
240 
241       <!—记录日志的位置-->
242 
243       <parameter>
244 
245         <parameterName value="@location" />
246 
247         <dbType value="String" />
248 
249         <size value="2000" />
250 
251         <layout type="log4net.Layout.PatternLayout">
252 
253           <conversionPattern value="%location" />
254 
255         </layout>
256 
257       </parameter>
258 
259      
260 
261       <!—异常信息。ExceptionLayout 为异常输出的默认格式-->
262 
263       <parameter>
264 
265         <parameterName value="@exception" />
266 
267         <dbType value="String" />
268 
269         <size value="4000" />
270 
271         <layout type="log4net.Layout.ExceptionLayout" />
272 
273       </parameter>
274 
275 </appender>
```

 

注意：

向表中输出的字段不能多于数据表本身字段，而反之则可以，但这些多余字段一定使其可以为空，否则便写不到数据库；

输出字段的类型一定是对应数据表字段数据类型可以隐式转换的，而且长度也不能超过，否则也不能写入；

数据表字段设置尽量可以为空，这样可以避免一条日志记录存在空数据导致后面的日志都记录不了。

## 4.3<logger>的配置

在配置文件<appender>中的配置好了输出的介质，格式，过滤方式，还要定义日志对象<logger>。

在框架的体系里，所有的日志对象都是根日志(root logger)的后代。 因此如果一个日志对象没有在配置文件里显式定义，则框架使用根日志中定义的属性。在<root>标签里，可以定义level级别值和Appender的列表。如果没有定义LEVEL的值，则缺省为DEBUG。可以通过<appender-ref>标签定义日志对象使用的Appender对象。<appender-ref>声明了在其他地方定义的Appender对象的一个引用。在一个logger对象中的设置会覆盖根日志的设置。而对Appender属性来说，子日志对象则会继承父日志对象的Appender列表。这种缺省的行为方式也可以通过显式地设定<logger>标签的additivity属性为false而改变。

<root>不显式申明时使用默认的配置。我觉得在使用时不定义<root>,自定义多个<logger>,在程序中记录日志时直接使用<logger>的name来查找相应的<logger>，这样更灵活一些。例如：

<!--同时写两个文件和数据库-->

 

```xml
 1 <logger name="ReflectionLayout">
 2 
 3       <level value="DEBUG"/>
 4 
 5       <appender-ref ref="HashtableLayout"/>
 6 
 7       <appender-ref ref="ReflectionLayout"/>
 8 
 9       <appender-ref ref="ADONetAppender"/>
10 
11 </logger>
```

 

## 4.4关联配置文件

log4net默认关联的是应用程序的配置文件App.config(BS程序是Web.config)，可以使用程序集自定义属性来进行设置。下面来介绍一下这个自定义属性：

log4net.Config.XmlConifguratorAttribute。 

XmlConfiguratorAttribute有3个属性：

ConfigFile： 配置文件的名字，文件路径相对于应用程序目录

(AppDomain.CurrentDomain.BaseDirectory)。ConfigFile属性不能和ConfigFileExtension属性一起使用。

ConfigFileExtension： 配置文件的扩展名，文件路径相对于应用程序的目录。ConfigFileExtension属性不能和ConfigFile属性一起使用。

Watch： 如果将Watch属性设置为true，就会监视配置文件。当配置文件发生变化的时候，就会重新加载。

如果ConfigFile和ConfigFileExtension都没有设置，则使用应用程序的配置文件App.config（Web.config）。

可以在项目的AssemblyInfo.cs文件里添加以下的语句：

 

```
 1  //监视默认的配置文件，App.exe.config   
 2 
 3 [assembly: log4net.Config.XmlConfigurator(Watch = true)]
 4 
 5  
 6 
 7 //监视配置文件，App.exe.log4net。
 8 
 9 [assembly: log4net. Config.XmlConfigurator(ConfigFileExtension = "log4net", Watch = true)]
10 
11  
12 
13 //使用配置文件log4net.config，不监视改变。注意log4net.config文件的目录，BS程序在站点目录//下，CS则在应用程序启动目录下，如调试时在/bin/Debug下，一般将文件属性的文件输出目录调为//始终复制即可
14 
15 [assembly: log4net. Config.XmlConfigurator(ConfigFile = "log4net.config")]
16 
17  
18 
19 //使用配置文件log4net.config，不监视改变
20 
21 [assembly: log4net. Config.XmlConfigurator()]
```

 

也可以在Global.asax的Application_Start里或者是Program.cs中的Main方法中添加，注意这里一定是绝对路径，如下所示：

 

```C#
 1 //这是在BS程序下，使用自定义的配置文件log4net.xml，使用Server.MapPath("~") + //@"/log4net.xml”来取得路径。/log4net.xml为相对于站点的路径
 2 
 3 // ConfigureAndWatch()相当于Configure(Watch = true)
 4 
 5 log4net.Config.XmlConfigurator.ConfigureAndWatch(
 6 
 7 new System.IO.FileInfo(Server.MapPath("~") + @"/log4net.xml"));
 8 
 9 //这是在CS程序下，可以用以下方法获得：
10 
11 string assemblyFilePath = Assembly.GetExecutingAssembly().Location;
12 
13 string assemblyDirPath = Path.GetDirectoryName(assemblyFilePath);
14 
15 string configFilePath = assemblyDirPath + " //log4net.xml";
16 
17 log4net.Config.XmlConfigurator.ConfigureAndWatch(
18 
19 new FileInfo(configFilePath));
```

 

或直接使用绝对路径：

```
1 //使用自定义的配置文件，直接绝对路径为：c:/log4net.config
2 
3 log4net.Config.XmlConfigurator.Configure(new System.IO.FileInfo(@"c:/log4net.config"));
```

# 5、如何记录日志

Log4net使用很方便，先申明一个封装类ILog 的对象，如下：

log4net.ILog log = log4net.LogManager.GetLogger("ReflectionLayout");

其中"ReflectionLayout"便是我们自定义的日志对象<logger>的name的值。

对应5个日志输出级别，log有5 个方法，每个方法都有两个重载，使用如下：

 

```C#
 1         try
 2 
 3             {
 4 
 5                 log.Debug("这是一个测试！");
 6 
 7             }
 8 
 9             catch(Exception ec)
10 
11             {
12 
13                 log.Error("出现错误！", ec);
14 
15          }
```

 

如果我们需要输出的消息是要区别开来，不按一个字符串全部输出，就需要进行一些扩展了。

# 6、Log4net的简单扩展

## 6.1通过重写布局Layout输出传入的 message对象的属性

### 6.1.1重写Layout类

通过继承log4net.Layout.**PatternLayout**类，使用log4net.Core.LoggingEvent类的方法得到了要输出的message类的名称，然后通过反射得到各个属性的值，使用**PatternLayout**类AddConverter方法传入得到的值。这里注意要引用用到的类的命名空间。

代码见附注8.2。

 

### 6.1.2配置相应的配置文件

配置文件其他地方不用改动，只是需要改动<appender>中的<layout>。例如：

 

```xml
1 <layout type="TGLog.ExpandLayout2.ReflectionLayout,TGLog">
2 
3         <param name="ConversionPattern"
4 
5  value="记录时间：%date    操作者ID：%property{Operator}             
6 
7 操作类型：%property{Action}%n  消息描述：%property{Message}%n                    异常：%exception%n " />
8 
9       </layout>
```

 

其中<layout>的type由原来的log4net.Layout.**PatternLayout**换为自定义的TGLog.ExpandLayout2.ReflectionLayout（TGLog.ExpandLayout2为命名空间）。%property{Operator}输出的即为message类对象的属性Operator的值。数据库配置同样，相应的字段如果是自定义的，则输出选用自定义的<layout>。例：

 

```xml
 1 <!--动作类型-->
 2 
 3   <parameter>
 4 
 5       <parameterName value="@action_type" />
 6 
 7       <dbType value="Int16" />
 8 
 9       <layout type="TGLog.ExpandLayout2.ReflectionLayout,TGLog">
10 
11          <conversionPattern value="%property{ActionType}" />
12 
13       </layout>
14 
15   </parameter>
```

 

### 6.1.3程序中如何使用

和一般使用方法基本相同，只是传入的参数是一个自定义的类，类的属性和配置文件中<layout>所有的%property{属性}是一致的，即%property{属性}在输出的时候就查找传入message类中有无对应的属性，如果有就输出值，没有则输出null。例：

 

```C#
 1 log4net.ILog log = log4net.LogManager.GetLogger("ReflectionLayout");
 2 
 3 try
 4 
 5             {
 6 
 7                 log.Debug(new LogMessage(
 8 
 9 1,
10 
11 "操作对象：0",
12 
13  (int)TGLog.ActionType.Other,
14 
15  "这是四个参数测试")
16 
17 );
18 
19             }
20 
21             catch(Exception ec)
22 
23             {
24 
25                 log.Error(new LogMessage(
26 
27                                     1,
28 
29                                     "操作对象：0",
30 
31                                     (int)TGLog.ActionType.Other,
32 
33                                     "这是全部参数测试",
34 
35                                     "192.168.1.1",
36 
37                                     "MyComputer",
38 
39                                     "Maxthon(MyIE2)Fans"),
40 
41                          ec
42 
43 );
44 
45       }
```

 

LogMessage的全部属性的构造方法如下：

 

```C#
 1 public LogMessage(
 2 
 3             int operatorID,
 4 
 5             string operand,
 6 
 7             int ActionType,
 8 
 9             string message,
10 
11             string ip,
12 
13             string machineName,
14 
15             string browser
16 
17             )
18 
19      {
20 
21             this.ActionType = ActionType;
22 
23             this.Operator = operatorID;
24 
25             this.Message = message;
26 
27             this.Operand = operand;
28 
29             this.IP = ip;
30 
31             this.Browser = browser;
32 
33             this.MachineName = machineName;
34 
35 }
```

 

## 6.2通过重新实现ILog接口来增加输入的参数

### 6.2.1重写LogImpl，LogManager类及实现ILog接口

这种方式是通过构造一个名为**IMyLog**接口，是继承**Ilog**接口而来，然后分别在**MyLogImpl****，MyLogManager**重新实现**IMyLog**接口，增加了每种方法的参数。**MyLogImpl****，MyLogManager**分别继承**LogImpl****，LogManager**而来。

代码分别见8.3、8.4、8.5：

### 6.2.2配置相应的配置文件

配置文件其他地方不用改动，只是需要改动<appender>中的<layout>元素name为ConversionPattern的value中输出格式。例如：

 

```C#
1 <layout type=" log4net.Layout.PatternLayout ">
2 
3         <param name="ConversionPattern"
4 
5  value="记录时间：%date    操作者ID：%property{Operator}             
6 
7 操作类型：%property{Action}%n  消息描述：%property{Message}%n                    异常：%exception%n " />
8 
9       </layout>
```

 

%property{参数}中的参数在**MyLogImpl**类中定义，如语句：

loggingEvent.Properties["Operator"] = operatorID;

就定义了Operator输出参数，即%property{Operator}输出的即为**IMyLog**中的参数operatorID的值。

数据库配置同样。例：

 

```C#
 1 <!--动作类型-->
 2 
 3   <parameter>
 4 
 5       <parameterName value="@action_type" />
 6 
 7       <dbType value="Int16" />
 8 
 9       <layout type=" log4net.Layout.PatternLayout ">
10 
11          <conversionPattern value="%property{ActionType}" />
12 
13       </layout>
14 
15   </parameter>
```

 

### 6.2.3程序中如何使用

先引用IMyLog ，MyLogManager所在的命名空间，创建一个IMyLog对象，myLog的5 个方法，每个方法都有四个重载，增加了多参数的重载。例：

 

```C#
 1 IMyLog myLog = MyLogManager.GetLogger("ExpandILog");
 2 
 3 try
 4 
 5             {
 6 
 7 myLog.Debug("这是一个参数重载测试!");          
 8 
 9 }
10 
11             catch(Exception ec)
12 
13             {
14 
15                 log.Error(
16 
17                           1,
18 
19                           "操作对象：0",
20 
21                           (int)TGLog.ActionType.Other,
22 
23                           "这是全部参数测试",
24 
25                           "192.168.1.1",
26 
27                           "MyComputer",
28 
29                           "Maxthon(MyIE2)Fans",
30 
31                           ec
32 
33 );
34 
35       }
```

 

# 7、总结

Log4net 功能很多，这里只是对已经尝试用过的功能总结一下，普通写日志已经足够。需要注意的是：

\1.      Log4net本身也有一些缺陷，比如一个记录引起了log4net本身的异常，就会使后面的日志无法记录下来，尤其是在写入数据库时。例如使用6.1扩展后，int型的属性在<appender >的元素<bufferSize>设置不为1时，<dbType value="Int32" />时，就不能输出到数据库，而<dbType value="Int16" />则没任何问题。

\2.      Log4net本身出现了异常，比如配置文件出现错误，有些日志输出方式会记录下这些异常，例如应用程序控制台；有些则不会输出这些错误，如数据库与文件。

\3.      扩展时也会留下一些问题。例如在使用6.1扩展输出字段时就会出现，在log.debug(object message)中，如果message是一个自定义的类，属性与配置文件中输出设置也一致，构造函数时也只构造一个参数的实例，写文件与写数据库都成功，而将message按没有扩展的方式直接传入一个字符串，即log.debug(“信息内容”)使用则只能写入文件，而数据库则没写入。自定义的Layout 就是继承默认的**PatternLayout**，本来不应该出错，但出现了问题。原因分析是自定义的message类有类型为int的属性，作为一个对象传入时在默认值0，而直接使用字符串则int型的字段得不到默认值，引发异常。所以建议在有扩展存在时，最好多设几个<logger>,区分清楚，按照统一的形式记录日志，不要混合使用。

\4.      配置文件的设置一定要准确，在一点不正确就会导致日志不能正常输出，所以在配置时先从最简单的开始，同时输出方式选择一种能输出log4net本身异常的方式，成功后一点一点加在新配置，这样出错了也容易找到那个地方配置有问题。

\5.      log4net扩展性很强，几乎所有的组件都可以重写，在配置文件中配置好就可以使用。

# 8、附注：

### 8.1PatterLayout格式化字符表

| **转换字符** | **效果**                                                     |
| ------------ | ------------------------------------------------------------ |
| a            | 等价于appdomain                                              |
| appdomain    | 引发日志事件的应用程序域的友好名称。（使用中一般是可执行文件的名字。） |
| c            | 等价于 logger                                                |
| C            | 等价于 type                                                  |
| class        | 等价于 type                                                  |
| d            | 等价于 date                                                  |
| date         | 发生日志事件的本地时间。 使用 DE>%utcdate 输出UTC时间。date后面还可以跟一个日期格式，用大括号括起来。DE>例如：%date{HH:mm:ss,fff}或者%date{dd MMM yyyy HH:mm:ss,fff}。如果date后面什么也不跟，将使用ISO8601 格式 。日期格式和.Net中DateTime类的ToString方法中使用的格式是一样。另外log4net还有3个自己的格式Formatter。 它们是 "ABSOLUTE", "DATE"和"ISO8601"分别代表 AbsoluteTimeDateFormatter, DateTimeDateFormatter和Iso8601DateFormatter。例如：%date{ISO8601}或%date{ABSOLUTE}。它们的性能要好于ToString。 |
| exception    | 异常信息日志事件中必须存了一个异常对象，如果日志事件不包含没有异常对象，将什么也不输出。异常输出完毕后会跟一个换行。一般会在输出异常前加一个换行，并将异常放在最后。 |
| F            | 等价于 file                                                  |
| file         | 发生日志请求的源代码文件的名字。警告：只在调试的时候有效。调用本地信息会影响性能。 |
| identity     | 当前活动用户的名字(Principal.Identity.Name).警告：会影响性能。（我测试的时候%identity返回都是空的。） |
| l            | 等价于 location                                              |
| L            | 等价于 line                                                  |
| location     | 引发日志事件的方法（包括命名空间和类名），以及所在的源文件和行号。警告：会影响性能。没有pdb文件的话，只有方法名，没有源文件名和行号。 |
| level        | 日志事件等级                                                 |
| line         | 引发日志事件的行号警告：会影响性能。                         |
| logger       | 记录日志事件的Logger对象的名字。可以使用精度说明符控制Logger的名字的输出层级，默认输出全名。注意，精度符的控制是从右开始的。例如：logger 名为 "a.b.c"， 输出模型为%logger{2} ，将输出"b.c"。 |
| m            | 等价于 message                                               |
| M            | 等价于 method                                                |
| message      | 由应用程序提供给日志事件的消息。                             |
| mdc          | MDC (旧为：ThreadContext.Properties) 现在是事件属性的一部分。 保留它是为了兼容性，它等价于 property。 |
| method       | 发生日志请求的方法名（只有方法名而已）。警告：会影响性能。   |
| n            | 等价于 newline                                               |
| newline      | 换行符                                                       |
| ndc          | NDC (nested diagnostic context)                              |
| p            | 等价于 level                                                 |
| P            | 等价于 property                                              |
| properties   | 等价于 property                                              |
| property     | 输出事件的特殊属性。例如： %property{user} 输出user属性。属性是由loggers或appenders添加到时间中的。 有一个默认的属性"DE>log4net:HostName"总是会有。DE>%property将输出所有的属性 。（扩展后可以使用） |
| r            | 等价于 timestamp                                             |
| t            | 等价于 thread                                                |
| timestamp    | 从程序启动到事件发生所经过的毫秒数。                         |
| thread       | 引发日志事件的线程，如果没有线程名就使用线程号。             |
| type         | 引发日志请求的类的全名。.可以使用精度控制符。例如： 类名是 "log4net.Layout.**PatternLayout**", 格式模型是%type{1} 将输出"**PatternLayout**"。（也是从右开始的。）警告：会影响性能。 |
| u            | 等价于 identity                                              |
| username     | 当前用户的WindowsIdentity。（类似：HostName/Username）警告：会影响性能。 |
| utcdate      | 发生日志事件的UTC时间。DE>后面还可以跟一个日期格式，用大括号括起来。DE>例如：%utcdate{HH:mm:ss,fff}或者%utcdate{dd MMM yyyy HH:mm:ss,fff}。如果utcdate后面什么也不跟，将使用ISO8601 格式 。日期格式和.Net中DateTime类的ToString方法中使用的格式是一样。另外log4net还有3个自己的格式Formatter。 它们是 "ABSOLUTE", "DATE"和"ISO8601"分别代表 AbsoluteTimeDateFormatter, DateTimeDateFormatter和Iso8601DateFormatter。例如：%date{ISO8601}或%date{ABSOLUTE}。它们的性能要好于ToString。 |
| w            | 等价于 username                                              |
| x            | 等价于 ndc                                                   |
| X            | 等价于 mdc                                                   |
| %            | %%输出一个百分号                                             |

关于调用本地信息（caller location information）的说明：

%type %file %line %method %location %class %C %F %L %l %M 都会调用本地信息。这样做会影响性能。本地信息使用System.Diagnostics.StackTrace得到。.Net 1.0 不支持System.Diagnostics.StackTrace 类。

本地信息在调试模式下可以正常获取，在非调试模式下可能获取不到，或只能获取一部分。（根据我的测试，其实是需要有一个程序数据库（.pdb）文件。）

%property属性要用代码来设置才能使用（也就是扩展一下），

默认属性log4net:HostName不用设置。

转义字符的修饰符：

| Format modifier | left justify | minimum width | maximum width | comment                                              |
| --------------- | ------------ | ------------- | ------------- | ---------------------------------------------------- |
| %20logger       | false        | 20            | none          | 如果logger名不足20个字符，就在左边补空格。           |
| %-20logger      | true         | 20            | none          | 如果logger名不足20个字符，就在右边补空格。           |
| %.30logger      | NA           | none          | 30            | 超过30个字符将截断。                                 |
| %20.30logger    | false        | 20            | 30            | logger名要在20到30之间，少了在左边补空格，多了截断。 |
| %-20.30logger   | true         | 20            | 30            | logger名要在20到30之间，少了在右边补空格，多了截断。 |

### 8.2Layout类代码

 

```C#
  1 using System;
  2 
  3 using System.Collections.Generic;
  4 
  5 using System.Linq;
  6 
  7 using System.Text;
  8 
  9 using log4net.Layout;
 10 
 11 using log4net.Layout.Pattern;
 12 
 13 using System.Reflection;
 14 
 15 using System.Collections;
 16 
 17 using FastReflectionLib;
 18 
 19  
 20 
 21 namespace TGLog.ExpandLayout2
 22 
 23 {
 24 
 25     public class ReflectionLayout : PatternLayout
 26 
 27     {
 28 
 29         public ReflectionLayout()
 30 
 31         {
 32 
 33             this.AddConverter("property", typeof(ReflectionPatternConverter));
 34 
 35         }
 36 
 37     }
 38 
 39  
 40 
 41     public class ReflectionPatternConverter : PatternLayoutConverter
 42 
 43     {
 44 
 45         protected override void Convert(
 46 
 47 System.IO.TextWriter writer,
 48 
 49  log4net.Core.LoggingEvent loggingEvent
 50 
 51 )
 52 
 53         {
 54 
 55             if (Option != null)
 56 
 57             {
 58 
 59                 // 写入指定键的值
 60 
 61                 WriteObject(
 62 
 63 writer,
 64 
 65  loggingEvent.Repository,
 66 
 67  LookupProperty(Option,
 68 
 69  loggingEvent)
 70 
 71 );
 72 
 73             }
 74 
 75             else
 76 
 77             {
 78 
 79                 // 写入所有关键值对
 80 
 81                 WriteDictionary(
 82 
 83 writer,
 84 
 85 loggingEvent.Repository,
 86 
 87  loggingEvent.GetProperties()
 88 
 89 );
 90 
 91             }
 92 
 93         }
 94 
 95  
 96 
 97         /// <summary>
 98 
 99         /// 通过反射获取传入的日志对象的某个属性的值
100 
101         /// </summary>
102 
103         /// <param name="property"></param>
104 
105         /// <returns></returns>
106 
107         private object LookupProperty(
108 
109 string property,
110 
111  log4net.Core.LoggingEvent loggingEvent)
112 
113         {
114 
115             object propertyValue = string.Empty;
116 
117  
118 
119             PropertyInfo propertyInfo =
120 
121 loggingEvent.MessageObject.GetType().GetProperty(property);
122 
123             if (propertyInfo != null)
124 
125             {
126 
127                 propertyValue =
128 
129 propertyInfo.GetValue(loggingEvent.MessageObject, null);
130 
131             }
132 
133             return propertyValue;
134 
135         }
136 
137     }
138 
139 }
```

 

### 8.3 MyLogImpl类代码

 

```C#
  1 using System;
  2 
  3 using System.Collections.Generic;
  4 
  5 using System.Linq;
  6 
  7 using System.Text;
  8 
  9 using log4net.Core;
 10 
 11  
 12 
 13 namespace TGLog.ExpandILog
 14 
 15 {
 16 
 17     public class MyLogImpl : LogImpl, IMyLog
 18 
 19     {
 20 
 21         /// <summary>
 22 
 23         /// The fully qualified name of this declaring type not the type of any subclass.
 24 
 25         /// </summary>
 26 
 27         private readonly static Type ThisDeclaringType = typeof(MyLogImpl);
 28 
 29  
 30 
 31         public MyLogImpl(ILogger logger)
 32 
 33             : base(logger)
 34 
 35         {       
 36 
 37         }
 38 
 39  
 40 
 41         #region Implementation of IMyLog
 42 
 43  
 44 
 45         public void Debug(int operatorID, string operand, int actionType,object message,
 46 
 47  string ip, string browser, string machineName)
 48 
 49         {
 50 
 51             Debug(operatorID,  operand,  actionType, message,
 52 
 53   ip,  browser, machineName, null);
 54 
 55         }
 56 
 57  
 58 
 59         public void Debug(int operatorID, string operand, int actionType,object message,
 60 
 61 string ip, string browser, string machineName, System.Exception t)
 62 
 63         {
 64 
 65             if (this.IsDebugEnabled)
 66 
 67             {
 68 
 69                 LoggingEvent loggingEvent =
 70 
 71 new LoggingEvent(ThisDeclaringType, Logger.Repository,
 72 
 73                                        Logger.Name, Level.Info, message, t);
 74 
 75                 loggingEvent.Properties["Operator"] = operatorID;
 76 
 77                 loggingEvent.Properties["Operand"] = operand;
 78 
 79                 loggingEvent.Properties["ActionType"] = actionType;
 80 
 81                 loggingEvent.Properties["IP"] = ip;
 82 
 83                 loggingEvent.Properties["Browser"] = browser;
 84 
 85                 loggingEvent.Properties["MachineName"] = machineName;
 86 
 87                 Logger.Log(loggingEvent);
 88 
 89             }
 90 
 91         }
 92 
 93  
 94 
 95         public void Info(int operatorID, string operand, int actionType, object message,
 96 
 97 string ip, string browser, string machineName)
 98 
 99         {
100 
101             Info(operatorID, operand, actionType, message, ip, browser, machineName, null);
102 
103         }
104 
105  
106 
107         public void Info(int operatorID, string operand, int actionType, object message,
108 
109  string ip, string browser, string machineName, System.Exception t)
110 
111         {
112 
113             if (this.IsInfoEnabled)
114 
115             {
116 
117                 LoggingEvent loggingEvent =
118 
119  new LoggingEvent(ThisDeclaringType, Logger.Repository,
120 
121  Logger.Name, Level.Info, message, t);
122 
123                 loggingEvent.Properties["Operator"] = operatorID;
124 
125                 loggingEvent.Properties["Operand"] = operand;
126 
127                 loggingEvent.Properties["ActionType"] = actionType;
128 
129                 loggingEvent.Properties["IP"] = ip;
130 
131                 loggingEvent.Properties["Browser"] = browser;
132 
133                 loggingEvent.Properties["MachineName"] = machineName;
134 
135                 Logger.Log(loggingEvent);
136 
137             }
138 
139         }
140 
141  
142 
143         public void Warn(int operatorID, string operand, int actionType, object message,
144 
145 string ip, string browser, string machineName)
146 
147         {
148 
149             Warn(operatorID, operand, actionType, message, ip, browser, machineName, null);
150 
151         }
152 
153  
154 
155         public void Warn(int operatorID, string operand, int actionType, object message,
156 
157  string ip, string browser, string machineName, System.Exception t)
158 
159         {
160 
161             if (this.IsWarnEnabled)
162 
163             {
164 
165                 LoggingEvent loggingEvent =
166 
167  new LoggingEvent(ThisDeclaringType, Logger.Repository,
168 
169 Logger.Name, Level.Info, message, t);
170 
171                 loggingEvent.Properties["Operator"] = operatorID;
172 
173                 loggingEvent.Properties["Operand"] = operand;
174 
175                 loggingEvent.Properties["ActionType"] = actionType;
176 
177                 loggingEvent.Properties["IP"] = ip;
178 
179                 loggingEvent.Properties["Browser"] = browser;
180 
181                 loggingEvent.Properties["MachineName"] = machineName;
182 
183                 Logger.Log(loggingEvent);
184 
185             }
186 
187         }
188 
189  
190 
191         public void Error(int operatorID, string operand, int actionType, object message,
192 
193 string ip, string browser, string machineName)
194 
195         {
196 
197             Error(operatorID, operand, actionType, message, ip, browser, machineName, null);
198 
199         }
200 
201  
202 
203         public void Error(int operatorID, string operand, int actionType, object message,
204 
205  string ip, string browser, string machineName, System.Exception t)
206 
207         {
208 
209             if (this.IsErrorEnabled)
210 
211             {
212 
213                 LoggingEvent loggingEvent =
214 
215  new LoggingEvent(ThisDeclaringType, Logger.Repository,
216 
217  Logger.Name, Level.Info, message, t);
218 
219                 loggingEvent.Properties["Operator"] = operatorID;
220 
221                 loggingEvent.Properties["Operand"] = operand;
222 
223                 loggingEvent.Properties["ActionType"] = actionType;
224 
225                 loggingEvent.Properties["IP"] = ip;
226 
227                 loggingEvent.Properties["Browser"] = browser;
228 
229                 loggingEvent.Properties["MachineName"] = machineName;
230 
231                 Logger.Log(loggingEvent);
232 
233             }
234 
235         }
236 
237  
238 
239         public void Fatal(int operatorID, string operand, int actionType, object message,
240 
241  string ip, string browser, string machineName)
242 
243         {
244 
245             Fatal(operatorID, operand, actionType, message, ip, browser, machineName, null);
246 
247         }
248 
249  
250 
251         public void Fatal(int operatorID, string operand, int actionType, object message,
252 
253  string ip, string browser, string machineName, System.Exception t)
254 
255         {
256 
257             if (this.IsFatalEnabled)
258 
259             {
260 
261                 LoggingEvent loggingEvent =
262 
263  new LoggingEvent(ThisDeclaringType, Logger.Repository,
264 
265                                        Logger.Name, Level.Info, message, t);
266 
267                 loggingEvent.Properties["Operator"] = operatorID;
268 
269                 loggingEvent.Properties["Operand"] = operand;
270 
271                 loggingEvent.Properties["ActionType"] = actionType;
272 
273                 loggingEvent.Properties["IP"] = ip;
274 
275                 loggingEvent.Properties["Browser"] = browser;
276 
277                 loggingEvent.Properties["MachineName"] = machineName;
278 
279                 Logger.Log(loggingEvent);
280 
281             }
282 
283         }
284 
285         #endregion Implementation of IMyLog
286 
287     }
288 
289 }
```

 

### 8.4 MyLogManager类代码

 

```C#
  1 #region Copyright & License
  2 
  3 //
  4 
  5 // Copyright 2001-2005 The Apache Software Foundation
  6 
  7 //
  8 
  9 // Licensed under the Apache License, Version 2.0 (the "License");
 10 
 11 // you may not use this file except in compliance with the License.
 12 
 13 // You may obtain a copy of the License at
 14 
 15 //
 16 
 17 // http://www.apache.org/licenses/LICENSE-2.0
 18 
 19 //
 20 
 21 // Unless required by applicable law or agreed to in writing, software
 22 
 23 // distributed under the License is distributed on an "AS IS" BASIS,
 24 
 25 // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 26 
 27 // See the License for the specific language governing permissions and
 28 
 29 // limitations under the License.
 30 
 31 //
 32 
 33 #endregion
 34 
 35  
 36 
 37 using System;
 38 
 39 using System.Reflection;
 40 
 41 using System.Collections;
 42 
 43 using log4net;
 44 
 45 using log4net.Core;
 46 
 47 using log4net.Repository;
 48 
 49 using log4net.Repository.Hierarchy;
 50 
 51  
 52 
 53 namespace TGLog.ExpandILog
 54 
 55 {
 56 
 57     public class MyLogManager
 58 
 59     {
 60 
 61         #region Static Member Variables
 62 
 63  
 64 
 65         /// <summary>
 66 
 67         /// The wrapper map to use to hold the <see cref="EventIDLogImpl"/> objects
 68 
 69         /// </summary>
 70 
 71         private static readonly WrapperMap s_wrapperMap = new WrapperMap(newWrapperCreationHandler(WrapperCreationHandler));
 72 
 73  
 74 
 75         #endregion
 76 
 77  
 78 
 79         #region Constructor
 80 
 81  
 82 
 83         /// <summary>
 84 
 85         /// Private constructor to prevent object creation
 86 
 87         /// </summary>
 88 
 89         private MyLogManager() { }
 90 
 91  
 92 
 93         #endregion
 94 
 95  
 96 
 97         #region Type Specific Manager Methods
 98 
 99  
100 
101         /// <summary>
102 
103         /// Returns the named logger if it exists
104 
105         /// </summary>
106 
107         /// <remarks>
108 
109         /// <para>If the named logger exists (in the default hierarchy) then it
110 
111         /// returns a reference to the logger, otherwise it returns
112 
113         /// <c>null</c>.</para>
114 
115         /// </remarks>
116 
117         /// <param name="name">The fully qualified logger name to look for</param>
118 
119         /// <returns>The logger found, or null</returns>
120 
121         public static IMyLog Exists(string name)
122 
123         {
124 
125             return Exists(Assembly.GetCallingAssembly(), name);
126 
127         }
128 
129  
130 
131         /// <summary>
132 
133         /// Returns the named logger if it exists
134 
135         /// </summary>
136 
137         /// <remarks>
138 
139         /// <para>If the named logger exists (in the specified domain) then it
140 
141         /// returns a reference to the logger, otherwise it returns
142 
143         /// <c>null</c>.</para>
144 
145         /// </remarks>
146 
147         /// <param name="domain">the domain to lookup in</param>
148 
149         /// <param name="name">The fully qualified logger name to look for</param>
150 
151         /// <returns>The logger found, or null</returns>
152 
153         public static IMyLog Exists(string domain, string name)
154 
155         {
156 
157             return WrapLogger(LoggerManager.Exists(domain, name));
158 
159         }
160 
161  
162 
163         /// <summary>
164 
165         /// Returns the named logger if it exists
166 
167         /// </summary>
168 
169         /// <remarks>
170 
171         /// <para>If the named logger exists (in the specified assembly's domain) then it
172 
173         /// returns a reference to the logger, otherwise it returns
174 
175         /// <c>null</c>.</para>
176 
177         /// </remarks>
178 
179         /// <param name="assembly">the assembly to use to lookup the domain</param>
180 
181         /// <param name="name">The fully qualified logger name to look for</param>
182 
183         /// <returns>The logger found, or null</returns>
184 
185         public static IMyLog Exists(Assembly assembly, string name)
186 
187         {
188 
189             return WrapLogger(LoggerManager.Exists(assembly, name));
190 
191         }
192 
193  
194 
195         /// <summary>
196 
197         /// Returns all the currently defined loggers in the default domain.
198 
199         /// </summary>
200 
201         /// <remarks>
202 
203         /// <para>The root logger is <b>not</b> included in the returned array.</para>
204 
205         /// </remarks>
206 
207         /// <returns>All the defined loggers</returns>
208 
209         public static IMyLog[] GetCurrentLoggers()
210 
211         {
212 
213             return GetCurrentLoggers(Assembly.GetCallingAssembly());
214 
215         }
216 
217  
218 
219         /// <summary>
220 
221         /// Returns all the currently defined loggers in the specified domain.
222 
223         /// </summary>
224 
225         /// <param name="domain">the domain to lookup in</param>
226 
227         /// <remarks>
228 
229         /// The root logger is <b>not</b> included in the returned array.
230 
231         /// </remarks>
232 
233         /// <returns>All the defined loggers</returns>
234 
235         public static IMyLog[] GetCurrentLoggers(string domain)
236 
237         {
238 
239             return WrapLoggers(LoggerManager.GetCurrentLoggers(domain));
240 
241         }
242 
243  
244 
245         /// <summary>
246 
247         /// Returns all the currently defined loggers in the specified assembly's domain.
248 
249         /// </summary>
250 
251         /// <param name="assembly">the assembly to use to lookup the domain</param>
252 
253         /// <remarks>
254 
255         /// The root logger is <b>not</b> included in the returned array.
256 
257         /// </remarks>
258 
259         /// <returns>All the defined loggers</returns>
260 
261         public static IMyLog[] GetCurrentLoggers(Assembly assembly)
262 
263         {
264 
265             return WrapLoggers(LoggerManager.GetCurrentLoggers(assembly));
266 
267         }
268 
269  
270 
271         /// <summary>
272 
273         /// Retrieve or create a named logger.
274 
275         /// </summary>
276 
277         /// <remarks>
278 
279         /// <para>Retrieve a logger named as the <paramref name="name"/>
280 
281         /// parameter. If the named logger already exists, then the
282 
283         /// existing instance will be returned. Otherwise, a new instance is
284 
285         /// created.</para>
286 
287         ///
288 
289         /// <para>By default, loggers do not have a set level but inherit
290 
291         /// it from the hierarchy. This is one of the central features of
292 
293         /// log4net.</para>
294 
295         /// </remarks>
296 
297         /// <param name="name">The name of the logger to retrieve.</param>
298 
299         /// <returns>the logger with the name specified</returns>
300 
301         public static IMyLog GetLogger(string name)
302 
303         {
304 
305             return GetLogger(Assembly.GetCallingAssembly(), name);
306 
307         }
308 
309  
310 
311         /// <summary>
312 
313         /// Retrieve or create a named logger.
314 
315         /// </summary>
316 
317         /// <remarks>
318 
319         /// <para>Retrieve a logger named as the <paramref name="name"/>
320 
321         /// parameter. If the named logger already exists, then the
322 
323         /// existing instance will be returned. Otherwise, a new instance is
324 
325         /// created.</para>
326 
327         ///
328 
329         /// <para>By default, loggers do not have a set level but inherit
330 
331         /// it from the hierarchy. This is one of the central features of
332 
333         /// log4net.</para>
334 
335         /// </remarks>
336 
337         /// <param name="domain">the domain to lookup in</param>
338 
339         /// <param name="name">The name of the logger to retrieve.</param>
340 
341         /// <returns>the logger with the name specified</returns>
342 
343         public static IMyLog GetLogger(string domain, string name)
344 
345         {
346 
347             return WrapLogger(LoggerManager.GetLogger(domain, name));
348 
349         }
350 
351  
352 
353         /// <summary>
354 
355         /// Retrieve or create a named logger.
356 
357         /// </summary>
358 
359         /// <remarks>
360 
361         /// <para>Retrieve a logger named as the <paramref name="name"/>
362 
363         /// parameter. If the named logger already exists, then the
364 
365         /// existing instance will be returned. Otherwise, a new instance is
366 
367         /// created.</para>
368 
369         ///
370 
371         /// <para>By default, loggers do not have a set level but inherit
372 
373         /// it from the hierarchy. This is one of the central features of
374 
375         /// log4net.</para>
376 
377         /// </remarks>
378 
379         /// <param name="assembly">the assembly to use to lookup the domain</param>
380 
381         /// <param name="name">The name of the logger to retrieve.</param>
382 
383         /// <returns>the logger with the name specified</returns>
384 
385         public static IMyLog GetLogger(Assembly assembly, string name)
386 
387         {
388 
389             return WrapLogger(LoggerManager.GetLogger(assembly, name));
390 
391         }
392 
393  
394 
395         /// <summary>
396 
397         /// Shorthand for <see cref="LogManager.GetLogger(string)"/>.
398 
399         /// </summary>
400 
401         /// <remarks>
402 
403         /// Get the logger for the fully qualified name of the type specified.
404 
405         /// </remarks>
406 
407         /// <param name="type">The full name of <paramref name="type"/> will
408 
409         /// be used as the name of the logger to retrieve.</param>
410 
411         /// <returns>the logger with the name specified</returns>
412 
413         public static IMyLog GetLogger(Type type)
414 
415         {
416 
417             return GetLogger(Assembly.GetCallingAssembly(), type.FullName);
418 
419         }
420 
421  
422 
423         /// <summary>
424 
425         /// Shorthand for <see cref="LogManager.GetLogger(string)"/>.
426 
427         /// </summary>
428 
429         /// <remarks>
430 
431         /// Get the logger for the fully qualified name of the type specified.
432 
433         /// </remarks>
434 
435         /// <param name="domain">the domain to lookup in</param>
436 
437         /// <param name="type">The full name of <paramref name="type"/> will
438 
439         /// be used as the name of the logger to retrieve.</param>
440 
441         /// <returns>the logger with the name specified</returns>
442 
443         public static IMyLog GetLogger(string domain, Type type)
444 
445         {
446 
447             return WrapLogger(LoggerManager.GetLogger(domain, type));
448 
449         }
450 
451  
452 
453         /// <summary>
454 
455         /// Shorthand for <see cref="LogManager.GetLogger(string)"/>.
456 
457         /// </summary>
458 
459         /// <remarks>
460 
461         /// Get the logger for the fully qualified name of the type specified.
462 
463         /// </remarks>
464 
465         /// <param name="assembly">the assembly to use to lookup the domain</param>
466 
467         /// <param name="type">The full name of <paramref name="type"/> will
468 
469         /// be used as the name of the logger to retrieve.</param>
470 
471         /// <returns>the logger with the name specified</returns>
472 
473         public static IMyLog GetLogger(Assembly assembly, Type type)
474 
475         {
476 
477             return WrapLogger(LoggerManager.GetLogger(assembly, type));
478 
479         }
480 
481  
482 
483         #endregion
484 
485  
486 
487         #region Extension Handlers
488 
489  
490 
491         /// <summary>
492 
493         /// Lookup the wrapper object for the logger specified
494 
495         /// </summary>
496 
497         /// <param name="logger">the logger to get the wrapper for</param>
498 
499         /// <returns>the wrapper for the logger specified</returns>
500 
501         private static IMyLog WrapLogger(ILogger logger)
502 
503         {
504 
505             return (IMyLog)s_wrapperMap.GetWrapper(logger);
506 
507         }
508 
509  
510 
511         /// <summary>
512 
513         /// Lookup the wrapper objects for the loggers specified
514 
515         /// </summary>
516 
517         /// <param name="loggers">the loggers to get the wrappers for</param>
518 
519         /// <returns>Lookup the wrapper objects for the loggers specified</returns>
520 
521         private static IMyLog[] WrapLoggers(ILogger[] loggers)
522 
523         {
524 
525             IMyLog[] results = new IMyLog[loggers.Length];
526 
527             for (int i = 0; i < loggers.Length; i++)
528 
529             {
530 
531                 results[i] = WrapLogger(loggers[i]);
532 
533             }
534 
535             return results;
536 
537         }
538 
539  
540 
541         /// <summary>
542 
543         /// Method to create the <see cref="ILoggerWrapper"/> objects used by
544 
545         /// this manager.
546 
547         /// </summary>
548 
549         /// <param name="logger">The logger to wrap</param>
550 
551         /// <returns>The wrapper for the logger specified</returns>
552 
553         private static ILoggerWrapper WrapperCreationHandler(ILogger logger)
554 
555         {
556 
557             return new MyLogImpl(logger);
558 
559         }
560 
561         #endregion
562 
563     }
564 
565 }
```

 

### 8.5 IMyLog类代码

 

```C#
 1 using System;
 2 
 3 using System.Collections.Generic;
 4 
 5 using System.Linq;
 6 
 7 using System.Text;
 8 
 9 using log4net;
10 
11  
12 
13 namespace TGLog.ExpandILog
14 
15 {
16 
17     public interface IMyLog : ILog
18 
19     {
20 
21         void Debug(int operatorID, string operand, int actionType, object message,
22 
23 string ip, string browser, string machineName);
24 
25         void Debug(int operatorID, string operand, int actionType,object message,
26 
27 string ip, string browser, string machineName, Exception t);
28 
29  
30 
31         void Info(int operatorID, string operand, int actionType, object message,
32 
33 string ip, string browser, string machineName);
34 
35         void Info(int operatorID, string operand, int actionType, object message,
36 
37 string ip, string browser, string machineName, Exception t);
38 
39  
40 
41         void Warn(int operatorID, string operand, int actionType, object message,
42 
43 string ip, string browser, string machineName);
44 
45         void Warn(int operatorID, string operand, int actionType, object message,
46 
47  string ip, string browser, string machineName, Exception t);
48 
49  
50 
51         void Error(int operatorID, string operand, int actionType, object message,
52 
53 string ip, string browser, string machineName);
54 
55         void Error(int operatorID, string operand, int actionType, object message,
56 
57 string ip, string browser, string machineName, Exception t);
58 
59  
60 
61         void Fatal(int operatorID, string operand, int actionType, object message,
62 
63 string ip, string browser, string machineName);
64 
65         void Fatal(int operatorID, string operand, int actionType, object message,
66 
67 string ip, string browser, string machineName, Exception t);
68 
69     }
70 
71 }
```

 

### 8.6附件

[log4net记录日志.exe](https://files.cnblogs.com/longshizhong/使用log4net记录日志.rar)

 

[转载-Log4net使用详细说明](https://www.cnblogs.com/yswenli/p/7363501.html)
