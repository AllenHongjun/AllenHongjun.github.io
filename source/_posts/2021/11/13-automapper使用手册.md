---
title: automapper使用手册
date: 2021-11-13 16:29:39
tags:
categories:
- 组件
---



# [【C#】AutoMapper 使用手册](https://www.cnblogs.com/gl1573/p/13098031.html)



<!-- more -->



目录

- [1 入门例子](https://www.cnblogs.com/gl1573/p/13098031.html#1-入门例子)
- 2 注册
  - [2.1 Profile](https://www.cnblogs.com/gl1573/p/13098031.html#21-profile)
- 3 配置
  - [3.1 命名约定](https://www.cnblogs.com/gl1573/p/13098031.html#31-命名约定)
  - [3.2 配置可见性](https://www.cnblogs.com/gl1573/p/13098031.html#32-配置可见性)
  - [3.3 全局属性/字段过滤](https://www.cnblogs.com/gl1573/p/13098031.html#33-全局属性字段过滤)
  - [3.4 识别前缀和后缀](https://www.cnblogs.com/gl1573/p/13098031.html#34-识别前缀和后缀)
  - [3.5 替换字符](https://www.cnblogs.com/gl1573/p/13098031.html#35-替换字符)
- [4 调用构造函数](https://www.cnblogs.com/gl1573/p/13098031.html#4-调用构造函数)
- 5 数组和列表映射
  - [5.1 处理空集合](https://www.cnblogs.com/gl1573/p/13098031.html#51-处理空集合)
  - [5.2 集合中的多态](https://www.cnblogs.com/gl1573/p/13098031.html#52-集合中的多态)
- [6 方法到属性映射](https://www.cnblogs.com/gl1573/p/13098031.html#6-方法到属性映射)
- [7 自定义映射](https://www.cnblogs.com/gl1573/p/13098031.html#7-自定义映射)
- 8 扁平化映射
  - [8.1 IncludeMembers](https://www.cnblogs.com/gl1573/p/13098031.html#81-includemembers)
- [9 嵌套映射](https://www.cnblogs.com/gl1573/p/13098031.html#9-嵌套映射)



> 本文基于 AutoMapper 9.0.0

AutoMapper 是一个对象-对象映射器，可以将一个对象映射到另一个对象。

官网地址：http://automapper.org/

官方文档：https://docs.automapper.org/en/latest/

### 1 入门例子

```csharp
public class Foo
{
    public int ID { get; set; }

    public string Name { get; set; }
}

public class FooDto
{
    public int ID { get; set; }

    public string Name { get; set; }
}

public void Map()
{
    var config = new MapperConfiguration(cfg => cfg.CreateMap<Foo, FooDto>());

    var mapper = config.CreateMapper();

    Foo foo = new Foo { ID = 1, Name = "Tom" };

    FooDto dto = mapper.Map<FooDto>(foo);
}
```

### 2 注册

在使用 `Map` 方法之前，首先要告诉 AutoMapper 什么类可以映射到什么类。

```csharp
var config = new MapperConfiguration(cfg => cfg.CreateMap<Foo, FooDto>());
```

每个 AppDomain 只能进行一次配置。这意味着放置配置代码的最佳位置是在应用程序启动中，例如 ASP.NET 应用程序的 Global.asax 文件。

从 9.0 开始 `Mapper.Initialize` 方法就不可用了。

#### 2.1 Profile

`Profile` 是组织映射的另一种方式。新建一个类，继承 `Profile`，并在构造函数中配置映射。

```csharp
public class EmployeeProfile : Profile
{
    public EmployeeProfile()
    {
        CreateMap<Employee, EmployeeDto>();
    }
}

var config = new MapperConfiguration(cfg =>
{
    cfg.AddProfile<EmployeeProfile>();
});
```

`Profile` 内部的配置仅适用于 `Profile` 内部的映射。应用于根配置的配置适用于所有创建的映射。

AutoMapper 也可以在指定的程序集中扫描从 `Profile` 继承的类，并将其添加到配置中。

```csharp
var config = new MapperConfiguration(cfg =>
{
    // 扫描当前程序集
    cfg.AddMaps(System.AppDomain.CurrentDomain.GetAssemblies());
    
    // 也可以传程序集名称（dll 名称）
    cfg.AddMaps("LibCoreTest");
});
```

### 3 配置

#### 3.1 命名约定

默认情况下，AutoMapper 基于相同的字段名映射，并且是 **不区分大小写** 的。

但有时，我们需要处理一些特殊的情况。

- `SourceMemberNamingConvention` 表示源类型命名规则
- `DestinationMemberNamingConvention` 表示目标类型命名规则

`LL4NePSetGN7sTtb75bSFLze8R4BXh3QfW` 和 `PascalCaseNamingConvention` 是 AutoMapper 提供的两个命名规则。前者命名是小写并包含下划线，后者就是帕斯卡命名规则（每个单词的首字母大写）。

我的理解，如果源类型和目标类型分别采用了 **蛇形命名法** 和 **驼峰命名法**，那么就需要指定命名规则，使其能正确映射。

```csharp
public class Foo
{
    public int Id { get; set; }

    public string MyName { get; set; }
}

public class FooDto
{
    public int ID { get; set; }

    public string My_Name { get; set; }
}

public void Map()
{
    var config = new MapperConfiguration(cfg =>
    {
        cfg.CreateMap<Foo, FooDto>();

        cfg.SourceMemberNamingConvention = new PascalCaseNamingConvention();
        cfg.DestinationMemberNamingConvention = new LL4NePSetGN7sTtb75bSFLze8R4BXh3QfW();
    });

    var mapper = config.CreateMapper();

    Foo foo = new Foo { Id = 2, MyName = "Tom" };

    FooDto dto = mapper.Map<FooDto>(foo);
}
```

#### 3.2 配置可见性

默认情况下，AutoMapper 仅映射 `public` 成员，但其实它是可以映射到 `private` 属性的。

```csharp
var config = new MapperConfiguration(cfg =>
{
    cfg.ShouldMapProperty = p => p.GetMethod.IsPublic || p.SetMethod.IsPrivate;
    cfg.CreateMap<Source, Destination>();
});
```

需要注意的是，这里属性必须添加 `private set`，省略 `set` 是不行的。

#### 3.3 全局属性/字段过滤

默认情况下，AutoMapper 尝试映射每个公共属性/字段。以下配置将忽略字段映射。

```csharp
var config = new MapperConfiguration(cfg =>
{
	cfg.ShouldMapField = fi => false;
});
```

#### 3.4 识别前缀和后缀

```csharp
var config = new MapperConfiguration(cfg =>
{
    cfg.RecognizePrefixes("My");
    cfg.RecognizePostfixes("My");
}
```

#### 3.5 替换字符

```csharp
var config = new MapperConfiguration(cfg =>
{
    cfg.ReplaceMemberName("Ä", "A");
});
```

这功能我们基本上用不上。

### 4 调用构造函数

有些类，属性的 `set` 方法是私有的。

```csharp
public class Commodity
{
    public string Name { get; set; }

    public int Price { get; set; }
}

public class CommodityDto
{
    public string Name { get; }

    public int Price { get; }

    public CommodityDto(string name, int price)
    {
        Name = name;
        Price = price * 2;
    }
}
```

AutoMapper 会自动找到相应的构造函数调用。如果在构造函数中对参数做一些改变的话，其改变会反应在映射结果中。如上例，映射后 `Price` 会乘 2。

禁用构造函数映射：

```csharp
var config = new MapperConfiguration(cfg => cfg.DisableConstructorMapping());
```

禁用构造函数映射的话，目标类要有一个无参构造函数。

### 5 数组和列表映射

数组和列表的映射比较简单，仅需配置元素类型，定义简单类型如下：

```csharp
public class Source
{
    public int Value { get; set; }
}

public class Destination
{
    public int Value { get; set; }
}
```

映射：

```csharp
var config = new MapperConfiguration(cfg =>
{
    cfg.CreateMap<Source, Destination>();
});
IMapper mapper = config.CreateMapper();

var sources = new[]
{
    new Source { Value = 5 },
    new Source { Value = 6 },
    new Source { Value = 7 }
};

IEnumerable<Destination> ienumerableDest = mapper.Map<Source[], IEnumerable<Destination>>(sources);
ICollection<Destination> icollectionDest = mapper.Map<Source[], ICollection<Destination>>(sources);
IList<Destination> ilistDest = mapper.Map<Source[], IList<Destination>>(sources);
List<Destination> listDest = mapper.Map<Source[], List<Destination>>(sources);
Destination[] arrayDest = mapper.Map<Source[], Destination[]>(sources);
```

具体来说，支持的源集合类型包括：

- IEnumerable
- IEnumerable
- ICollection
- ICollection
- IList
- IList
- List
- Arrays

> 映射到现有集合时，将首先清除目标集合。如果这不是你想要的，请查看AutoMapper.Collection。

#### 5.1 处理空集合

映射集合属性时，如果源值为 `null`，则 AutoMapper 会将目标字段映射为空集合，而不是 `null`。这与 Entity Framework 和 Framework Design Guidelines 的行为一致，认为 C＃ 引用，数组，List，Collection，Dictionary 和 IEnumerables 永远不应该为 `null`。

#### 5.2 集合中的多态

这个官方的文档不是很好理解。我重新举个例子。实体类如下：

```csharp
public class Employee
{
    public int ID { get; set; }

    public string Name { get; set; }
}

public class Employee2 : Employee
{
    public string DeptName { get; set; }
}

public class EmployeeDto
{
    public int ID { get; set; }

    public string Name { get; set; }
}

public class EmployeeDto2 : EmployeeDto
{
    public string DeptName { get; set; }
}
```

数组映射代码如下：

```csharp
var config = new MapperConfiguration(cfg =>
{
    cfg.CreateMap<Employee, EmployeeDto>().Include<Employee2, EmployeeDto2>();
    cfg.CreateMap<Employee2, EmployeeDto2>();
});
IMapper mapper = config.CreateMapper();

var employees = new[]
{
    new Employee { ID = 1, Name = "Tom" },
    new Employee2 { ID = 2, Name = "Jerry", DeptName = "R & D" }
};

var dto = mapper.Map<Employee[], EmployeeDto[]>(employees);
```

可以看到，映射后，`dto` 中两个元素的类型，一个是 `EmployeeDto`，一个是 `EmployeeDto2`，即实现了父类映射到父类，子类映射到子类。

如果去掉 `Include` 方法，则映射后 `dto` 中两个元素的类型均为 `EmployeeDto`。

### 6 方法到属性映射

AutoMapper 不仅能实现属性到属性映射，还可以实现方法到属性的映射，并且不需要任何配置，方法名可以和属性名一致，也可以带有 `Get` 前缀。

例如下例的 `Employee.GetFullName()` 方法，可以映射到 `EmployeeDto.FullName` 属性。

```csharp
public class Employee
{
    public int ID { get; set; }

    public string FirstName { get; set; }

    public string LastName { get; set; }

    public string GetFullName()
    {
        return $"{FirstName} {LastName}";
    }
}

public class EmployeeDto
{
    public int ID { get; set; }

    public string FirstName { get; set; }

    public string LastName { get; set; }

    public string FullName { get; set; }
}
```

### 7 自定义映射

当源类型与目标类型名称不一致时，或者需要对源数据做一些转换时，可以用自定义映射。

```csharp
public class Employee
{
    public int ID { get; set; }

    public string Name { get; set; }

    public DateTime JoinTime { get; set; }
}

public class EmployeeDto
{
    public int EmployeeID { get; set; }

    public string EmployeeName { get; set; }

    public int JoinYear { get; set; }
}
```

如上例，`ID` 和 `EmployeeID` 属性名不同，`JoinTime` 和 `JoinYear` 不仅属性名不同，属性类型也不同。

```csharp
var config = new MapperConfiguration(cfg =>
{
    cfg.CreateMap<Employee, EmployeeDto>()
        .ForMember("EmployeeID", opt => opt.MapFrom(src => src.ID))
        .ForMember(dest => dest.EmployeeName, opt => opt.MapFrom(src => src.Name))
        .ForMember(dest => dest.JoinYear, opt => opt.MapFrom(src => src.JoinTime.Year));
});
```

### 8 扁平化映射

对象-对象映射的常见用法之一是将复杂的对象模型并将其展平为更简单的模型。

```csharp
public class Employee
{
    public int ID { get; set; }

    public string Name { get; set; }

    public Department Department { get; set; }
}

public class Department
{
    public int ID { get; set; }

    public string Name { get; set; }
}

public class EmployeeDto
{
    public int ID { get; set; }

    public string Name { get; set; }

    public int DepartmentID { get; set; }

    public string DepartmentName { get; set; }
}
```

如果目标类型上的属性，与源类型的属性、方法都对应不上，则 AutoMapper 会将目标成员名按驼峰法拆解成单个单词，再进行匹配。例如上例中，`EmployeeDto.DepartmentID` 就对应到了 `Employee.Department.ID`。

#### 8.1 IncludeMembers

如果属性命名不符合上述的规则，而是像下面这样：

```csharp
public class Employee
{
    public int ID { get; set; }

    public string Name { get; set; }

    public Department Department { get; set; }
}

public class Department
{
    public int DepartmentID { get; set; }

    public string DepartmentName { get; set; }
}

public class EmployeeDto
{
    public int ID { get; set; }

    public string Name { get; set; }

    public int DepartmentID { get; set; }

    public string DepartmentName { get; set; }
}
```

`Department` 类中的属性名，直接跟 `EmployeeDto` 类中的属性名一致，则可以使用 `IncludeMembers` 方法指定。

```csharp
var config = new MapperConfiguration(cfg =>
{
    cfg.CreateMap<Employee, EmployeeDto>().IncludeMembers(e => e.Department);
    cfg.CreateMap<Department, EmployeeDto>();
});
```

### 9 嵌套映射

有时，我们可能不需要展平。看如下例子：

```csharp
public class Employee
{
    public int ID { get; set; }

    public string Name { get; set; }

    public int Age { get; set; }

    public Department Department { get; set; }
}

public class Department
{
    public int ID { get; set; }

    public string Name { get; set; }

    public string Heads { get; set; }
}

public class EmployeeDto
{
    public int ID { get; set; }

    public string Name { get; set; }

    public DepartmentDto Department { get; set; }
}

public class DepartmentDto
{
    public int ID { get; set; }

    public string Name { get; set; }
}
```

我们要将 `Employee` 映射到 `EmployeeDto`，并且将 `Department` 映射到 `DepartmentDto`。

```csharp
var config = new MapperConfiguration(cfg =>
{
    cfg.CreateMap<Employee, EmployeeDto>();
    cfg.CreateMap<Department, DepartmentDto>();
});
```
