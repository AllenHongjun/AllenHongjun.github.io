---
title: 初识ABPvNext
date: 2021-11-13 16:08:20
tags:
categories:
- 框架
- abp
---



# [初识ABPvNext](https://www.cnblogs.com/xhznl/p/13491480.html)

Tips：本篇已加入[系列文章阅读目录](https://www.cnblogs.com/xhznl/p/13259036.html)，可点击查看更多相关文章。



<!-- more -->



目录

- [前言](https://www.cnblogs.com/xhznl/p/13491480.html#前言)
- 开始
  - [审计(Audit)](https://www.cnblogs.com/xhznl/p/13491480.html#审计audit)
  - [本地化(Localization)](https://www.cnblogs.com/xhznl/p/13491480.html#本地化localization)
  - [事件总线(Event Bus)](https://www.cnblogs.com/xhznl/p/13491480.html#事件总线event-bus)
  - [多租户(multi-tenancy technology)](https://www.cnblogs.com/xhznl/p/13491480.html#多租户multi-tenancy-technology)
  - [DDD分层](https://www.cnblogs.com/xhznl/p/13491480.html#ddd分层)
  - [实体(Entity)](https://www.cnblogs.com/xhznl/p/13491480.html#实体entity)
  - [值对象(Value Object)](https://www.cnblogs.com/xhznl/p/13491480.html#值对象value-object)
  - [聚合根(Aggregate Root)](https://www.cnblogs.com/xhznl/p/13491480.html#聚合根aggregate-root)
  - [仓储(Repository)](https://www.cnblogs.com/xhznl/p/13491480.html#仓储repository)
  - [应用服务(Application Services)](https://www.cnblogs.com/xhznl/p/13491480.html#应用服务application-services)
  - [数据传输对象(DTO)](https://www.cnblogs.com/xhznl/p/13491480.html#数据传输对象dto)
  - [工作单元(Unit Of Work)](https://www.cnblogs.com/xhznl/p/13491480.html#工作单元unit-of-work)
- [最后](https://www.cnblogs.com/xhznl/p/13491480.html#最后)



# 前言

ABP vNext（以下简称ABP）的前身是asp.net boilerplate（老版abp），它不是一个简单的版本更新，而是完全基于.NET Core的重写。之前有听说过ABP框架，但是一直没有去详细了解。最近认真学习了一下，准备记录下自己的一些心得，计划分为3部分来进行：

1. ABP基础（就是官网上一些基本的功能）
2. ABP实战（使用ABP+vue开发一个简单项目）
3. ABP模块化（微服务简单介绍）

首先，这是以一个0基础的视角去写的，所以会比较基础，适合新手。文中如果有不对的地方，大家可以帮我指出来相互学习。。。

# 开始

ABP官网：https://www.abp.io/

ABP GitHub：https://github.com/abpframework/abp

要学习ABP，首先肯定要认真看一下官方的文档，虽然目前官方文档还不完整；然后对哪一部分不理解的，可以适当的阅读一下源码。

ABP是基于DDD:Domain-Driven Design（领域驱动设计）去开发的，当然框架本身不强制你使用DDD，但是他建议把DDD作为最佳实践。如果了解DDD，并且使用过老版本abp的话，看官方文档可能就比较轻松，反之则会比较吃力。。。首先DDD理论就非常抽象和复杂，要深刻理解它并不容易；其次是ABP内部使用了很多开源组件，比如EF Core，IdentityServer4，Autofac，AutoMapper，Swagger等等，所以也需要对这些组件有所了解。

本篇简单介绍一下ABP官方文档上一些重要的关键字，先理解这些关键字，才能更好的进一步学习。

## 审计(Audit)

审计是用于追踪数据变化的过程。平时开发中，你一定经常见到类似创建时间、创建人、修改时间、修改人等属性，这些属性就是用于数据审计。ABP框架提供了一些接口和基类来标准化这些属性，并自动设置它们的值；并且ABP提供了一个可扩展的审计日志系统，自动化的根据约定记录审计日志，并提供配置来控制审计日志的级别。ABP中审计相关基类/接口有：`IAuditedObject`、`AuditedEntity`、`AuditedAggregateRoot`等等。

## 本地化(Localization)

使应用程序支持多国语言。ABP的本地化系统与ASP.NET Core的本地化兼容。

## 事件总线(Event Bus)

> 事件总线是对观察者（发布-订阅）模式的一种实现。它是一种集中式事件处理机制，允许不同的组件之间进行彼此通信而又不需要相互依赖，达到一种解耦的目的。

如果没有接触过Event Bus，可能不太好理解。一个不太恰当的例子：A需要租房，B需要把房子租出去，A想直接找到B是比较困难的，A也不想去认识B，所以才有房产中介C，C就是Event Bus；B提前跟C说我的房子需要出租，A跟C说我给你钱你帮我租一个房，那么C很容易就帮A找到B完成租房，A甚至不需要知道B是谁，这里A就是事件的发布者，B是事件的订阅者。ABP支持本地Event Bus和分布式Event Bus。

## 多租户(multi-tenancy technology)

多租户是一种软件架构技术，这种架构可以让多个租户共用相同的系统，并且可以确保各租户间数据的隔离性。相信很多人都遇到过类似需求，同一个系统中根据不同客户区分数据；通常我们会在数据库表中增加一个客户Id作为标识，或者根据不同客户读取不同的数据库，这都是多租户数据隔离的实现方式，想自己很好的实现多租户还是很繁琐的。ABP的多租户模块提供了创建多租户应用程序的基本功能，可以很轻松的帮你实现多租户。

## DDD分层

- **表示层**: 为用户提供接口，使用应用层实现与用户交互。
- **应用层**: 表示层与领域层的中介，编排业务对象执行特定的应用程序任务，使用应用程序逻辑实现用例。
- **领域层**: 包含业务对象以及业务规则，是应用程序的核心。
- **基础设施层**: 提供通用的技术功能，支持更高的层，主要使用第三方类库。

## 实体(Entity)

> 一个没有从其属性，而是通过连续性和身份的线索来定义的对象。

官方文档中这句话非常难理解。。。

简单来说，当一个对象只能由他的标识（Id）来区分，而不是从其他属性来区分时，这种对象被称为实体。比如有很多叫“张三”的男人，你不能通过姓名和性别来区分到底是哪个张三，只能通过Id。实体是可以持续变化的，我们可以对实体进行多次修改，但是无论怎么修改，实体始终拥有它唯一的标识。DDD中的实体通常都是充血模型，充血模型就是实体中不光有属性，还会包含行为（方法），反之DTO，ViewModel就是典型的贫血模型。实体通常映射到关系型数据库的表中，ABP中实体相关的基类/接口有：`Entity`、`IEntity`、`AuditedEntity`等等。

## 值对象(Value Object)

值对象和实体恰好相反，它不需要唯一标识，并且它不可以被改变。值对象通常是用来度量和描述事物，当你只关注某个对象的属性时，该对象便可以是一个值对象。比如“北京”就是“北京”，不存在Id=1或者Id=2的北京的说法。当然，值对象虽然不存在唯一标识，但是不代表它在数据库中就没有Id主键。。。

## 聚合根(Aggregate Root)

聚合是业务逻辑紧密关联的实体和值对象组合而成，聚合是数据修改和持久化的基本单元，聚合后产生的根实体称为聚合根。若一个聚合仅有一个实体，那这个实体就是聚合根。聚合根被视为一个单元，你不能单独去修改聚合根中的子实体。例如，某个业务流程中，会操作A、B、C、D四个对象（简单理解为数据库表），那么将ABCD聚合，产生一个聚合根E，对外部来说只需要操作E就可以了，领域内部会处理好ABCD。这样一方面避免了多个对象的混乱，另一方面也保证了数据的完整性，不会出现AB操作成功了，CD操作失败了，导致数据库产生脏数据。

聚合根引用聚合根：通过ID。

聚合根引用实体：通过对象（导航属性）。

聚合根引用值对象：通过对象（导航属性）。

## 仓储(Repository)

仓储用于操作领域对象（实际就是操作数据库），通常会为每个聚合根或不同的实体创建对应的仓储。ABP也提供了通用的泛型仓储：`IRepository<TEntity, TKey>`，内置了增删改查基本功能，直接注入就可以使用。

## 应用服务(Application Services)

应用层处于展示层与领域层之间，展示层通常调用应用服务，应用服务调用领域然后返回数据给展示层。展示层也可以直接调用领域。APB中应用服务相关的基类/接口有：`IApplicationService`、`ApplicationService`、`ICrudAppService`、`CrudAppService`等等。

## 数据传输对象(DTO)

通常领域对象不适合直接在应用层与展示层之间传递，比如User中的Passwod字段，这时候就需要用到DTO，DTO和ViewModel类似。ABP提供了一些DTO基类/接口：`IEntityDto`、`EntityDto`、`AuditedEntityDto`等等。

## 工作单元(Unit Of Work)

UOW模式是为了保证一次业务操作的数据完整性。ABP框架的UOW实现提供了对应用程序中的数据库连接和事务范围的抽象和控制，使用ABP的话通常你不用自己去写数据库事务相关代码。实际上工作单元不一定非要创建数据库事务，比如HTTP GET请求就不会启动事务性UOW，它们仍然启动UOW，但不创建数据库事务。这一切都由ABP框架自动完成。

# 最后

目前关于ABP的学习资源比较少，官方的文档也还没写完。。。不过ABP的作者最近开始发布自己的教学视频了，有条件的可以自行搜索一下。
