---
title:  RabbitMQ 消息队列学习笔记
date: 2021-08-08 11:25:50
tags:
categories:
- 中间件
---


![](http://blogimg.hongjy.cn/rabbit-mq3png.png)

## 为什么使用消息队列

- 异步化:提交订单->预扣库存->生成订单->消费成功消息推送->通知仓库发货->数据计入财务. 后续很多操作其实都是可以放到消息队列当中执行，下单结束之后直接返回用户成功，减少用户等待时间，提升用户体验。
- 缓解大流量的冲击: 比如秒杀系统的请求很高，这是就可以将所有请求先放到消息队列中，然后取出服务端能够处理的请求来出里，这也是流量削峰的方式。
- [消息队列](https://www.zhihu.com/question/34243607) 的使用场景

<!-- more -->

## 如何使用Rabbit MQ

## 资料

- [rabbitmq 官网](https://www.rabbitmq.com/)

- [EASY-NETQ](https://github.com/EasyNetQ/EasyNetQ)--An easy to use .NET API for RabbitMQ
- [ RabbitMQ 中文文档](https://rabbitmq.mr-ping.com/)



### 博客文章

- [.NET Core 使用RabbitMQ](https://www.cnblogs.com/stulzq/p/7551819.html)
- [Asp.NetCore轻松学-实现一个轻量级高可复用的RabbitMQ客户端](https://www.cnblogs.com/viter/p/10003185.html)
- [SpringBoot商城秒杀系统-03-整合RabbitMQ进行异步下单](https://blog.csdn.net/weixin_43125502/article/details/106544082)
- [.net core集成使用EasyNetQ来使用rabbitmq](https://www.cnblogs.com/shanfeng1000/p/13035758.html)
- [.net-core 使用说明](https://cloud.tencent.com/developer/article/1151202)
- [NetCore EasyNetQ 高级使用 RabbitMq](https://blog.csdn.net/hezhixiang/article/details/102957965)
- [.Net Core 集成 RabbitMQ 订阅与发送](https://blog.csdn.net/dz1822802785/article/details/105426636)
- [.NET Core微服务之基于EasyNetQ使用RabbitMQ消息队列](https://www.cnblogs.com/edisonchou/p/aspnetcore_easynetq_basicdemo_foundation.html)



###  整合项目思路

- 一个业务可以单独制定一个发布者和一个接受者。比如发送秒杀的消息。 秒杀业务的订阅者接受到之后单独处理

- 可以1个发布者有多个订阅者,多个发布者 对弈1个发布者。

- 整合rabitMQ 实现消息队列

  - 用户进行下单操作（会有锁定商品库存、使用优惠券、积分一系列的操作）；
  - 生成订单，获取订单的id；
  - 获取到设置的订单超时时间（假设设置的为60分钟不支付取消订单）；
  - 按订单超时时间发送一个延迟消息给RabbitMQ，让它在订单超时后触发取消订单的操作；
  - 如果用户没有支付，进行取消订单操作（释放锁定商品库存、返还优惠券、返回积分一系列操作）。

  

### 使用过程

> 使用 rabbit MQ client SDK 测试exchange 模式收发消息

![](http://blogimg.hongjy.cn/rabbit-mq1.png)

> Rabbit MQ 管理客户端

![](http://blogimg.hongjy.cn/rabbit-mq2.png)



## 什么是消息队列

> 就是一个队列可以存放消息。也是使用一种观察者的设置模式，  同时引入也会增加系统的复杂度。

```c
在计算机科学中，消息队列（英语：Message queue）是一种进程间通信或同一进程的不同线程间的通信方式，软件的贮列用来处理一系列的输入，通常是来自用户。消息队列提供了异步的通信协议，每一个贮列中的纪录包含详细说明的资料，包含发生的时间，输入设备的种类，以及特定的输入参数，也就是说：消息的发送者和接收者不需要同时与消息队列交互。消息会保存在队列中，直到接收者取回它。
																							-- 摘抄维基百科
```



### 问题

- [RabbitMQ连接报错](https://blog.csdn.net/u013938578/article/details/81591297)

### to do list

- 继续深入学习相关的知识点概念。
- 了解消息队列相关面试题
- 使用消息队列 ，整合到asp.net core 做一个小demo.