---
title: Window如何设置防火墙开放端口
date: 2021-11-13 20:56:21
tags:
categories:
- 计算机基础
- 操作系统
- windows
---



#### 一、设置的目的

> 在开发过程中，有时别人需要访问你本地的网址，可以通过远程桌面控制的方式，但是那样会影响你本人的使用，因此有一种方式就是在本地通过设置防火墙开放本地的端口，之后别人就可以直接拿网址在自己的电脑进行访问了，当然防火墙默认情况下是会阻止外界的访问，因此需要设置一下，打开本地的一个访问端口



<!-- more -->



#### 二、具体操作步骤

1、打开控制面板

![img](http://blogimg.hongjy.cn/webp.webp)

2、点击防火墙

![img](http://blogimg.hongjy.cn/webp-1636808193837267.webp)

3、打开启用或关闭windows防火墙，保证防火墙在启用状态下

![img](http://blogimg.hongjy.cn/webp-1636808193837268.webp)

4、打开高级设置

![img](http://blogimg.hongjy.cn/webp-1636808193837269.webp)

5、选择入站规则----》新建规则

![img](http://blogimg.hongjy.cn/webp-1636808193837270.webp)

6、弹出新建入站规则向导，选择端口，下一步

![img](http://blogimg.hongjy.cn/webp-1636808193837271.webp)

7、协议和端口：选择相应的协议，如添加8080端口，选择TCP，特定本地端口输入8080，下一步

![img](http://blogimg.hongjy.cn/webp-1636808193837272.webp)

8、操作：选择“允许连接”，下一步

![img](http://blogimg.hongjy.cn/webp-1636808193838273.webp)

9、配置文件：勾选“域”，“专用”，“公司”，点击下一步

![img](http://blogimg.hongjy.cn/webp-1636808193838274.webp)

10、名称：输入端口名称和描述信息，点击完成

![img](http://blogimg.hongjy.cn/webp-1636808193838275.webp)
