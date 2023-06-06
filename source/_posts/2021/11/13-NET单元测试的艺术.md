---
title: NET单元测试的艺术-nunit
date: 2021-11-13 16:56:48
tags:
categories:
- 组件
---



**开篇：**最近在看Roy Osherove的《**单元测试的艺术**》一书，颇有收获。因此，将其记录下来，并分为四个部分分享成文，与各位Share。本篇作为入门，介绍了单元测试的基础知识，例如：如何使用一个测试框架，基本的自动化测试属性等等，还有对应的三种测试类型。相信你可以对编写单元测试从一无所知到及格水平，这也是原书作者的目标。



<!-- more -->



# **系列目录：**

> 1.入门
>
> 2.[核心技术](http://www.cnblogs.com/edisonchou/p/5447812.html)
>
> 3.[测试代码](http://www.cnblogs.com/edisonchou/p/5467573.html)

# 一、单元测试基础

## 1.1 什么是单元测试

　　一个单元测试是一段**自动化的代码**，这段代码**调用被测试的工作单元**，之后对这个单元的单个最终结果的某些假设**进行检验**。

　　单元测试几乎都是用单元测试框架编写的。单元测试容易编写，能够快速运行。单元测试可靠、可读，并且可维护。

　　只要产品代码不发生变化，单元测试的结果是稳定的。

## 1.2 与集成测试的区别

![img](http://blogimg.hongjy.cn/381412-20160427000815048-1809458915.jpg)

> 集成测试是对一个工作单元进行的测试，这个测试对被测试的工作单元没有完全的控制，并使用该单元的一个或多个真实依赖物，例如时间、网络、数据库、线程或随机数产生器等。

　　总的来说，**集成测试会使用真实依赖物，而单元测试则把被测试单元和其依赖物隔离开，以保证单元测试结果高度稳定**，还可以轻易控制和模拟被测试单元行为的任何方面。                 

# 二、测试驱动开发基础

## 2.1 传统的单元测试流程

![img](http://blogimg.hongjy.cn/381412-20160427001938142-1688215773.png)

## 2.2 测试驱动开发的概要流程

![img](http://blogimg.hongjy.cn/381412-20160427002722345-115411213.png)

　　如上图所示，TDD和传统开发方式不同，我们首先会编写一个会失败的测试，然后创建产品代码，并确保这个测试通过，接下来就是重构代码或者创建另一个会失败的测试。

# 三、第一个单元测试

## 3.1 NUnit 单元测试框架

　　NUnit 是从流行的Java单元测试框架JUnit直接移植过来的，之后NUnit在设计和可用性上做了极大地改进，和JUnit有了很大的区别，给日新月异的测试框架生态系统注入了新的活力。

　　作为一名.NET程序员，如何在VS中安装NUnit并能够在VS中直接运行测试呢？

　　Step1.在NuGet中找到NUnit并安装

![img](http://blogimg.hongjy.cn/381412-20160428001258283-1124221592.jpg)

　　Step2.在NuGet中找到NUnit Test Adapter并安装

![img](http://blogimg.hongjy.cn/381412-20160428001345095-1453299421.jpg)

## 3.2 LogAn 项目介绍

　　**LogAn （Log And Notificaition）**

　　场景：公司有很多内部产品，用于在客户场地监控公司的应用程序。所有这些监控产品都会写日志文件，日志文件存放在一个特定的目录中。日志文件的格式是你们公司自己制定的，无法用现有的第三方软件进行解析。你的任务是：实现一个产品，对这些日志文件进行分析，在其中搜索特定的情况和事件，这个产品就是LogAn。找到特定的情况和事件后，这个产品应该通知相关的人员。

　　在本次的单元测试实践中，我们会一步一步编写测试来验证LogAn的解析、事件识别以及通知功能。首先，我们需要了解使用NUnit来编写单元测试。

## 3.3 编写第一个测试

　　（1）我们的测试从以下这个LogAnalyzer类开始，这个类暂时只有一个方法IsValidLogFileName：

 

```C#
    public class LogAnalyzer
    {
        public bool IsValidLogFileName(string fileName)
        {
            if (fileName.EndsWith(".SLF"))
            {
                return false;
            }
            return true;
        }
    }
```

 

　　这个方法检查文件扩展名，据此判断一个文件是不是有效的日志文件。

　　这里在if中故意去掉了一个!运算符，因此这个方法就包含了一个Bug-当文件名以.SLF结尾时会返回false，而不是返回true。这样，我们就能看到测试失败时在测试运行期中显示什么内容。

　　（2）新建一个类库项目，命名为Manulife.LogAn.UnitTests（被测试项目项目名为Manulife.LogAn.Lib）。添加一个类，取名为LogAnalyzerTests.cs。

　　（3）在LogAnalyzerTests类中新增一个测试方法，取名为IsValidFileName_BadExtension_ReturnsFalse()。

　　首先，我们要明确如何编写测试代码，一般来说，一个单元测试通常包含三个行为：

![img](http://blogimg.hongjy.cn/381412-20160428003304814-1962400302.png)

　　因此，根据以上三个行为，我们可以编写出以下的测试方法：（其中断言部分使用了NUnit框架提供的Assert类）

 

```C#
    [TestFixture]
    public class LogAnalyzerTests
    {
        [Test]
        public void IsValidFileName_BadExtension_ReturnsFalse()
        {
            LogAnalyzer analyzer = new LogAnalyzer();
            bool result = analyzer.IsValidLogFileName("filewithbadextension.foo");
            Assert.AreEqual(false, result);
        }
    }
```

 

　　其中，属性[TestFixture]和[Test]是NUnit的特有属性，NUnit用属性机制来识别和加载测试。这些属性就像一本书里的书签，帮助测试框架识别记载程序集里面的重要部分，以及哪些部分是需要调用的测试。

> 1.[TestFixture]加载一个类上，标识这个类是一个包含自动化NUnit测试的类；
>
> 2.[Test]加在一个方法上，标识这个方法是一个需要调用的自动化测试；

　　另外，再说一下测试方法名称的规范，一般包含三个部分：[UnitOfWorkName]_[ScenarioUnderTest]_[ExpectedBehavior]

> 1.UnitOfWorkName　　被测试的方法、一组方法或者一组类
>
> 2.Scenario　　测试进行的假设条件，例如“登入失败”，“无效用户”或“密码正确”等
>
> 3.ExpectedBehavior　　在测试场景指定的条件下，你对被测试方法行为的预期　　

## 3.4 运行第一个测试

　　（1）编写好测试代码之后，点击"测试"->"运行"->"所有测试"

　　（2）然后，点击"测试"->"窗口"->"测试窗口管理器"，你会看到以下场景

![img](http://blogimg.hongjy.cn/381412-20160428003820908-1009770008.jpg)

　　从上图可以看出，我们得测试方法并没有通过，我们期望（Expected）的结果是False，而实际（Actual）的结果却是True。

## 3.5 继续添加测试方法

　　（1）通常在进行单元测试时我们会考虑到代码覆盖率，点击"测试"->"分析代码覆盖率"->"所有测试"，你可以看到以下结果：**80%**

![img](http://blogimg.hongjy.cn/381412-20160428004400830-1366190143.jpg)

　　（2）这时，我们需要想出完善的测试策略来覆盖所有的情况，因此我们添加一些测试方法来提高我们的代码覆盖率。这里我们添加两个方法，一个测试大写文件扩展名，一个测试小写文件扩展名：

 

```C#
    [Test]
    public void IsValidFileName_GoodExtensionLowercase_ReturnsTrue()
    {
        LogAnalyzer analyzer = new LogAnalyzer();
        bool result = analyzer.IsValidLogFileName("filewithgoodextension.slf");
        Assert.AreEqual(true, result);
    }

    [Test]
    public void IsValidFileName_GoodExtensionUppercase_ReturnsTrue()
    {
        LogAnalyzer analyzer = new LogAnalyzer();
        bool result = analyzer.IsValidLogFileName("filewithgoodextension.SLF");
        Assert.AreEqual(true, result);
    }
```

 

　　这时测试结果如下图所示：

![img](http://blogimg.hongjy.cn/381412-20160428004725486-1296481096.jpg)

　　这时再来看看代码覆盖率：**100%**

![img](http://blogimg.hongjy.cn/381412-20160428004830064-1790451133.jpg)

　　（3）为了让所有的测试都能通过，这时我们需要修改源代码，改用大小写不敏感的字符串匹配：

 

```C#
    public bool IsValidLogFileName(string fileName)
    {
        if (!fileName.EndsWith(".SLF", StringComparison.CurrentCultureIgnoreCase))
        {
            return false;
        }
        return true;
    }
```

 

　　这时，我们再来运行一下所有的测试（也可以选择 运行未通过的测试）来看下**由红到绿**的快感。单元测试的理念很简单：只有所有的测试都通过，继续前行的绿灯才会亮起。哪怕只有一个测试失败了，进度条上都会亮起红灯，显示你的系统（或者测试）出现了问题。

![img](http://blogimg.hongjy.cn/381412-20160428005457064-818833458.jpg)

# 四、更多的NUnit

## 4.1 参数化重构单元测试

　　NUnit中有个叫做 参数化测试（Parameterized Tests）的功能，我们可以借助[TestCase]标签特性来重构我们的单元测试：

 

```C#
    [TestCase("filewithgoodextension.slf")]
    [TestCase("filewithgoodextension.SLF")]
    public void IsValidFileName_ValidExtensions_ReturnsTrue(string fileName)
    {
        LogAnalyzer analyzer = new LogAnalyzer();
        bool result = analyzer.IsValidLogFileName(fileName);
        Assert.AreEqual(true, result);
    }
```

 

　　可以看到，借助TestCase特性，测试数目没有改变，但是测试代码却变得更易维护，更加易读。

![img](http://blogimg.hongjy.cn/381412-20160428221241595-961890312.jpg)

## 4.2 SetUp和TearDown

　　NUnit还有一些特别的标签特性，可以很方便地控制测试前后的设置和清理状态工作，他们就是[SetUp]和[TearDown]。

> 1.[SetUp] 这个标签加在一个方法上，NUnit每次在运行测试类里的任何一个测试时都会先运行这个setup方法；
>
> 2.[TearDown] 这个标签标识一个方法应该在测试类里的每个测试运行完成之后执行；

 

```C#
    [TestFixture]
    public class LogAnalyzerTests
    {
        private LogAnalyzer analyzer = null;
        [SetUp]
        public void Setup()
        {
            analyzer = new LogAnalyzer();
        }

        [Test]
        public void IsValidFileName_ValidFileLowerCased_ReturnsTrue()
        {
            bool result = analyzer.IsValidLogFileName("whatever.slf");
            Assert.IsTrue(result, "filename should be valid!");
        }

        [Test]
        public void IsValidFileName_ValidFileUpperCased_ReturnsTrue()
        {
            bool result = analyzer.IsValidLogFileName("whatever.SLF");
            Assert.IsTrue(result, "filename should be valid!");
        }

        [TearDown]
        public void TearDown()
        {
            analyzer = null;
        }
    }
```

 

　　我们可以把setup和teardown方法想象成测试类中测试的构造函数和析构函数，在每个测试类中只能有一个setup和teardown方法，这两个方法对测试类中的每个方法只执行一次。

　　不过，使用[Setup]越多，测试代码可读性就越差。原书作者推荐采用工厂方法（Factory Method）初始化被测试的实例。

 

```C#
    /// <summary>
    /// 工厂方法初始化 LogAnalyzer 
    /// 既节省编写代码的时间，又使每个测试内的代码更简洁易读
    /// 同时保证 LogAnalyzer 总是用同样的方式初始化
    /// </summary>
    private static LogAnalyzer MakeAnalyzer()
    {
        return new LogAnalyzer();
    }
```

 

　　在测试方法中可以直接使用：

 

```C#
    [Test]
    public void IsValidFileName_BadExtension_ReturnsFalse()
    {
        LogAnalyzer analyzer = MakeAnalyzer();
        bool result = analyzer.IsValidLogFileName("filewithbadextension.foo");
        Assert.AreEqual(false, result);
    }
```

 

## 4.3 检验预期的异常

　　很多时候，我们的方法中会抛出一些异常，这时如果我们的测试也应该做一些修改。在NUnit中，提供了一个API : Assert.Catch<T>(delegate)

　　首先，我们修改一下被测试的方法，增加一行判断文件名是否为空的代码：

 

```C#
    public bool IsValidLogFileName(string fileName)
    {
        if(string.IsNullOrEmpty(fileName))
        {
            throw new ArgumentException("filename has to be provided");
        }

        if (!fileName.EndsWith(".SLF", StringComparison.CurrentCultureIgnoreCase))
        {
            return false;
        }
        return true;
    }
```

 

　　然后，我们新增一个测试方法，使用Assert.Catch来检测异常是否一致：

 

```C#
    [Test]
    public void IsValidFileName_EmptyName_Throws()
    {
        LogAnalyzer analyzer = new LogAnalyzer();
        // 使用Assert.Catch
        var ex = Assert.Catch<Exception>(() => analyzer.IsValidLogFileName(string.Empty));
        // 使用Assert.Catch返回的Exception对象
        StringAssert.Contains("filename has to be provided", ex.Message);
    }
```

 

![img](http://blogimg.hongjy.cn/381412-20160428231628877-1355320652.jpg)

## 4.4 忽略测试

　　有时候测试代码有问题，但是我们又需要把代码签入到主代码树中。在这种罕见的情况下（虽然确实非常少），可以给那些测试代码自身有问题的测试加一个[Ignore]标签特性。

 

```C#
    [Test]
    [Ignore("there is a problem with this test!")]
    public void IsValidFileName_ValidFile_ReturnsTrue()
    {
        // ...
    }
```

 

　　可以看到，这个测试确实被忽略了：

![img](http://blogimg.hongjy.cn/381412-20160428232214080-254840853.jpg)

## 4.5 设置测试的类别

　　我们可以把测试按照指定的测试类别运行，使用[Category]标签特性就可以实现这个功能：

 

```C#
    [Test]
    [Category("Fast Tests")]
    public void IsValidFileName_BadExtension_ReturnsFalse()
    {
        LogAnalyzer analyzer = new LogAnalyzer();
        bool result = analyzer.IsValidLogFileName("filewithbadextension.foo");
        Assert.AreEqual(false, result);
    }
```

 

## 4.6 测试系统状态的改变

　　此前我们得测试都有返回值，而很多要测试的方法都没有返回值，而只是改变对象中的某些状态，我们又该如何测试呢？

　　首先，我们修改IsValidLogFileName方法，增加一个状态属性：

 

```C#
    public class LogAnalyzer
    {
        public bool WasLastFileNameValid { get; set; }
        public bool IsValidLogFileName(string fileName)
        {
            // 改变系统状态
            WasLastFileNameValid = false;

            if(string.IsNullOrEmpty(fileName))
            {
                throw new ArgumentException("filename has to be provided");
            }

            if (!fileName.EndsWith(".SLF", StringComparison.CurrentCultureIgnoreCase))
            {
                return false;
            }

            // 改变系统状态
            WasLastFileNameValid = true;

            return true;
        }
    }
```

 

　　其次，我们编写一个测试，对系统状态进行断言：

 

```C#
    [TestCase("badfile.foo", false)]
    [TestCase("goodfile.slf", true)]
    public void IsValidFileName_WhenCalled_ChangesWasLastFileNameValid(string fileName, bool expected)
    {
        LogAnalyzer analyzer = new LogAnalyzer();
        analyzer.IsValidLogFileName(fileName);
        Assert.AreEqual(expected, analyzer.WasLastFileNameValid);
    }
```

 

![img](http://blogimg.hongjy.cn/381412-20160428233954377-2028928149.jpg)

# 五、小结

　　这一篇作为入门，带领大家领略了一下单元测试的概念，如何编写单元测试，如何在VS中应用NUnit进行单元测试。相信大家以前都用过MSTest，而我们这里却使用了NUnit。所以，下面我们来总结一下MSTest与NUnit在特性标签上的一些区别：

| **MS Test Attribute**  | **NUnit Attribute**   | **用途**                                                     |
| ---------------------- | --------------------- | ------------------------------------------------------------ |
| [TestClass]            | [TestFixture]         | 定义一个测试类，里面可以包含很多测试函数和初始化、销毁函数（以下所有标签和其他断言）。 |
| [TestMethod]           | [Test]                | 定义一个独立的测试函数。                                     |
| [ClassInitialize]      | [TestFixtureSetUp]    | 定义一个测试类初始化函数，每当运行测试类中的一个或多个测试函数时，这个函数将会在测试函数被调用前被调用一次（在第一个测试函数运行前会被调用）。 |
| [ClassCleanup]         | [TestFixtureTearDown] | 定义一个测试类销毁函数，每当测试类中的选中的测试函数全部运行结束后运行（在最后一个测试函数运行结束后运行）。 |
| [TestInitialize]       | [SetUp]               | 定义测试函数初始化函数，每个测试函数运行前都会被调用一次。   |
| [TestCleanup]          | [TearDown]            | 定义测试函数销毁函数，每个测试函数执行完后都会被调用一次。   |
| [AssemblyInitialize]   | --                    | 定义测试Assembly初始化函数，每当这个Assembly中的有测试函数被运行前，会被调用一次（在Assembly中第一个测试函数运行前会被调用）。 |
| [AssemblyCleanup]      | --                    | 定义测试Assembly销毁函数，当Assembly中所有测试函数运行结束后，运行一次。（在Assembly中所有测试函数运行结束后被调用） |
| [DescriptionAttribute] | [Category]            | 定义标识分组。                                               |

 　目前为止，我们的单元测试都还很简单也还比较顺利。但是，如果我们要测试的方法依赖于一个外部资源，如文件系统、数据库、Web服务或者其他难以控制的东西，那又该如何编写测试呢？为了解决这些问题，我们需要创建**测试存根**、**伪对象**及**模拟对象**，下一篇核心技术将会介绍这些内容，让我们跟随Roy Osherove的《单元测试的艺术》一起去探寻吧。

![img](http://blogimg.hongjy.cn/381412-20160428220339423-171469134.jpg)

# 参考资料 

   ![The Art of Unit Testing](http://blogimg.hongjy.cn/381412-20160420002608320-2141033603.jpg)

　　（1）Roy Osherove 著，金迎 译，《单元测试的艺术（第2版）》

　　（2）Aileer，《[对比MS Test与NUnit Test框架](http://www.cnblogs.com/kangqq/articles/4738746.html)》





[转载 - NET单元测试的艺术-1.入门](https://www.cnblogs.com/edisonchou/p/5437205.html)