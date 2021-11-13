---
title: Json.net快速入门
date: 2021-11-13 17:10:36
tags:
categories:
- 组件
---





### 引言

有个朋友问了一个如何更方便的解析json格式字符串，之前也没怎么研究过json.net，就上网帮他查了一下，现学现卖的给他整了一个demo，这才发现json.net的强大，用着很方便。



<!-- more -->



### Json

JSON(javasrcipt Object Notation)是一种轻量级的数据交换方式。拿最常见的应用举个例子，将javascript对象中表示的一组数据转换为字符串，然后就可以在函数之间轻松的传递这个字符串，或者在异步应用程序中将字符串从web客户机传递给服务端程序。这个字符串虽然看起来比较古怪，但是javascript很容易解释它，而且json可以表示比“名称/值对”更复杂的结构。例如，可以表示数组和复杂的对象，而不仅仅是键和值的简单列表。

在.net中，DataContractJsonSerializer和JavaScriptSerializer这两个类，可以操作json。但性能上和json.net相比，差了很多。

可以借用官网的一张图看一下：

![img](http://blogimg.hongjy.cn/152010097604985.x-png)

官网地址：http://james.newtonking.com/json

将下载的压缩文件解压，Source是源码文件夹，在bin目录下，Newtonsoft.Json.dll是编译后的程序集文件，在项目中应用该dll就行了。

### Json.net

在项目中引用Newtonsoft.Json.dll。

首先从最简单的例子入手，序列化DataTable对象。

引入命名空间：

 using Newtonsoft.Json; 

测试代码：

  

```C#
 1 using Newtonsoft.Json;
 2 using System.Data;
 3 namespace Wolfy.JsonNetDemo
 4 {
 5     class Program
 6     {
 7         static void Main(string[] args)
 8         {
 9             DataTable dt = new DataTable();
10             DataColumn name = new DataColumn("Name");
11             DataColumn gender = new DataColumn("Gender");
12             DataColumn address = new DataColumn("Address");
13             dt.Columns.Add(name);
14             dt.Columns.Add(gender);
15             dt.Columns.Add(address);
16             for (int i = 0; i < 10; i++)
17             {
18                 DataRow dr = dt.NewRow();
19                 dr[0] = "Name" + i;
20                 dr[1] = i%2==0?"男":"女";
21                 dr[2] = "Address" + i;
22                 dt.Rows.Add(dr);
23             }
24             //序列化为json
25             string json = JsonConvert.SerializeObject(dt);
26             Console.WriteLine(json);
27             Console.Read();
28         }
29     }
30 }
```

  

结果：

![img](http://blogimg.hongjy.cn/152028244328256.x-png)

反序列化为Datatable

```C#
1  DataTable dt1 = JsonConvert.DeserializeObject<DataTable>(json);
2             for (int i = 0; i < dt1.Rows.Count; i++)
3             {
4                 DataRow dr = dt1.Rows[i];
5                 Console.WriteLine("{0}\t{1}\t{2}\t", dr[0], dr[1], dr[2]);
6             }
```

![img](http://blogimg.hongjy.cn/152033001351295.x-png)

**控制**

实现对Json.net序列化和反序列化的控制，需要JsonSerializerSettings类。

 1 var jsonSetting = new JsonSerializerSettings(); 2 string json=JsonConvert.SerializeObject(object,jsonSetting); 

新建一个测试类：

  

```C#
1     public class Employee
2     {
3         public string Name { get; set; }
4         public int Age { set; get; }
5         public string Gender { set; get; }
6         public string DepartmentName { set; get; }
7         public Employee Leader { set; get; }
8     }
```

  

空值处理

针对应用类型，如果为NULL时，json.net如何处理，可以通过 jsonSetting.NullValueHandling的值来控制。如：

```C#
1             var jsonSetting = new JsonSerializerSettings();
2             jsonSetting.NullValueHandling = NullValueHandling.Ignore;
3             jsonSetting.NullValueHandling = NullValueHandling.Include;
```

一个例子：

  

```C#
 1             Employee employee = new Employee();
 2             employee.Name = "Wolfy";
 3             employee.Gender = "男";
 4             employee.Age = 26;
 5             employee.DepartmentName = ".net开发";
 6             employee.Leader = null;
 7             var jsonSetting = new JsonSerializerSettings();
 8             jsonSetting.NullValueHandling = NullValueHandling.Ignore;
 9             string json = JsonConvert.SerializeObject(employee,jsonSetting);
10             Console.WriteLine(json);
11             Console.Read();
```

  

结果：

![img](http://blogimg.hongjy.cn/152051595882118.x-png)

改为NullValueHandling.Include

结果：

![img](http://blogimg.hongjy.cn/152053352443161.x-png)

默认值处理

对于值类型的处理，通过设置jsonSetting.DefaultValueHandling的值来确定。同样是枚举可取Ignore，Include等，如：

  

```C#
 1 namespace Newtonsoft.Json
 2 {
 3     [Flags]
 4     public enum DefaultValueHandling
 5     {
 6         Include = 0,
 7         Ignore = 1,
 8         Populate = 2,
 9         IgnoreAndPopulate = 3,
10     }
11 }
```

  

 jsonSetting.DefaultValueHandling = DefaultValueHandling.Ignore;//忽略默认值 

给Employee的成员使用特性  [DefaultValue(26)]设置默认值，并引入命名空间：System.ComponentModel

 1 [DefaultValue(26)] 2 public int Age { set; get; } 

忽略默认值：

  

```C#
 1             Employee employee = new Employee();
 2             employee.Name = "Wolfy";
 3             employee.Gender = "男";
 4             employee.Age = 26;
 5             employee.DepartmentName = ".net开发";
 6             employee.Leader = null;
 7             var jsonSetting = new JsonSerializerSettings();
 8             jsonSetting.NullValueHandling = NullValueHandling.Include;
 9             jsonSetting.DefaultValueHandling = DefaultValueHandling.Ignore;//忽略默认值
10             string json = JsonConvert.SerializeObject(employee,jsonSetting);
11             Console.WriteLine(json);
12             Console.Read();
```

  

结果：

![img](http://blogimg.hongjy.cn/161952175888152.x-png)

 

属性控制

 Json.net序列化的两种方式：OptOut和OptIn

OptOut默认值，类中所有公共成员会被序列化，如果不想被序列化，可以使用特性JsonIgnore

OptIn默认情况下，所有的成员不会被序列化，类中的成员只有标有特性JsonProperty的才会被序列化，当类的成员很多，但客户端仅仅需要一部分时很有帮助。

  

```C#
 1 using Newtonsoft.Json;
 2 namespace Wolfy.JsonNetDemo
 3 {
 4     [JsonObject(Newtonsoft.Json.MemberSerialization.OptIn)]
 5     public class Employee
 6     {
 7         [JsonProperty]
 8         public string Name { get; set; }
 9         
10         public int Age { set; get; }
11         public string Gender { set; get; }
12         public string DepartmentName { set; get; }
13         public Employee Leader { set; get; }
14     }
15 }
```

  

序列化：

  

```C#
1             Employee employee = new Employee();
2             employee.Name = "Wolfy";
3             employee.Gender = "男";
4             employee.Age = 26;
5             employee.DepartmentName = ".net开发";
6             employee.Leader = null;
7             string json = JsonConvert.SerializeObject(employee);
8             Console.WriteLine(json);
```

  

结果：

![img](http://blogimg.hongjy.cn/162005191357586.x-png)

 如果想忽略某个属性，比如忽略领导信息。则可以这样写：

  

```C#
 1 namespace Wolfy.JsonNetDemo
 2 {
 3     [JsonObject(Newtonsoft.Json.MemberSerialization.OptOut)]
 4     public class Employee
 5     {
 6         public string Name { get; set; }
 7         
 8         public int Age { set; get; }
 9         public string Gender { set; get; }
10         public string DepartmentName { set; get; }
11         [JsonIgnore]
12         public Employee Leader { set; get; }
13     }
14 }
```

  

 [JsonObject(Newtonsoft.Json.MemberSerialization.OptOut)]可以不写，已经默认

测试：

  

```C#
1             Employee employee = new Employee();
2             employee.Name = "Wolfy";
3             employee.Gender = "男";
4             employee.Age = 26;
5             employee.DepartmentName = ".net开发";
6             employee.Leader = new Employee() {Name = "老大",Gender = "男",Age = 29, DepartmentName = ".net开发"};
7             string json = JsonConvert.SerializeObject(employee);
8             Console.WriteLine(json);
```

  

结果：

![img](http://blogimg.hongjy.cn/162012247601055.x-png)

不忽略结果对比：

![img](http://blogimg.hongjy.cn/162013253222152.x-png)

非公共成员序列化

 Json.net序列化对象，默认只序列化公共成员，非公共成员序列互时，需加上 [JsonProperty]特性。

日期处理

两种日期格式：*IsoDateTimeConverter和JavaScriptDateTimeConverter*

这是json.net中带的2个日期类，默认是*IsoDateTimeConverter，*格式“yyyy'-'MM'-'dd'T'HH':'mm':'ss.FFFFFFFK”。另一个是JavaScriptDateTimeConverter，格式“new Date(ticks)”，返回Javascript的Date对象。

*一个例子*

  

```C#
 1     public class Employee
 2     {
 3         public string Name { get; set; }
 4         public int Age { set; get; }
 5         public string Gender { set; get; }
 6         public string DepartmentName { set; get; }
 7         //[JsonIgnore]
 8         public Employee Leader { set; get; }
 9         public DateTime BirthDay { set; get; }
10         public DateTime EmployeDate { set; get; }
11     }
```

  

序列化为Javascript格式：

  

```C#
 1             Employee employee = new Employee();
 2             employee.Name = "Wolfy";
 3             employee.Gender = "男";
 4             employee.Age = 26;
 5             employee.DepartmentName = ".net开发";
 6             employee.Leader = new Employee() {Name = "老大",Gender = "男",Age = 29, DepartmentName = ".net开发"};
 7             employee.BirthDay = new DateTime(1987,3,22);
 8             employee.EmployeDate = new DateTime(2011,6,22);
 9             string json = JsonConvert.SerializeObject(employee,new JavaScriptDateTimeConverter());
10             Console.WriteLine(json);
```

  

序列化

![img](http://blogimg.hongjy.cn/162038030885453.x-png)

如果想要不同的日期类型成员序列化后，以不同的形式显示。

则可以通过设置特性实现

  

```C#
 1     public class Employee
 2     {
 3         public string Name { get; set; }
 4         public int Age { set; get; }
 5         public string Gender { set; get; }
 6         public string DepartmentName { set; get; }
 7         //[JsonIgnore]
 8         public Employee Leader { set; get; }
 9         [JsonConverter(typeof(IsoDateTimeConverter))]
10         public DateTime BirthDay { set; get; }
11         [JsonConverter(typeof(JavaScriptDateTimeConverter))]
12         public DateTime EmployeDate { set; get; }
13     }
```

  

结果：

![img](http://blogimg.hongjy.cn/162043190725818.x-png)

自定义日期格式：

```C#
1             IsoDateTimeConverter newFormatTime = new IsoDateTimeConverter() { DateTimeFormat="yyyy年MM月dd日"};
2             string json = JsonConvert.SerializeObject(employee, newFormatTime);
3             Console.WriteLine(json);
```

结果：

![img](http://blogimg.hongjy.cn/162047478075519.x-png)

### 总结

json.net简单操作就介绍到这里，之后总结Linq to json的用法。

参考

http://james.newtonking.com/json

http://www.360doc.com/content/13/0328/22/11741424_274568478.shtml


[转载-Json.net快速入门](https://www.cnblogs.com/wolf-sun/p/3667258.html)

