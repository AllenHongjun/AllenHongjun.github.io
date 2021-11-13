---
title: window如何设置防火墙开放端口
date: 2021-11-12 22:26:15
tags:
categories:
- 计算机基础
- windows
---


# window如何设置防火墙开放端口



#### 一、设置的目的

​    在开发过程中，有时别人需要访问你本地的网址，可以通过远程桌面控制的方式，但是那样会影响你本人的使用，因此有一种方式就是在本地通过设置防火墙开放本地的端口，之后别人就可以直接拿网址在自己的电脑进行访问了，当然防火墙默认情况下是会阻止外界的访问，因此需要设置一下，打开本地的一个访问端口

#### 二、具体操作步骤

1、打开控制面板

![img](https://upload-images.jianshu.io/upload_images/15937175-170e0ad2ff3368c2.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

<!-- more -->

2、点击防火墙

![img](https://upload-images.jianshu.io/upload_images/15937175-28ac0f97d131b16d.png?imageMogr2/auto-orient/strip|imageView2/2/w/989/format/webp)

3、打开启用或关闭windows防火墙，保证防火墙在启用状态下

![img](https://upload-images.jianshu.io/upload_images/15937175-337f5a49a5ff9177.png?imageMogr2/auto-orient/strip|imageView2/2/w/653/format/webp)

4、打开高级设置

![img](https://upload-images.jianshu.io/upload_images/15937175-5c74e11a4411adba.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

5、选择入站规则----》新建规则

![img](https://upload-images.jianshu.io/upload_images/15937175-7e430f1f6426ffbe.png?imageMogr2/auto-orient/strip|imageView2/2/w/1040/format/webp)

6、弹出新建入站规则向导，选择端口，下一步

![img](https://upload-images.jianshu.io/upload_images/15937175-7de673bad7215172.png?imageMogr2/auto-orient/strip|imageView2/2/w/1037/format/webp)

7、协议和端口：选择相应的协议，如添加8080端口，选择TCP，特定本地端口输入8080，下一步

![img](https://upload-images.jianshu.io/upload_images/15937175-cb39029576fe633e.png?imageMogr2/auto-orient/strip|imageView2/2/w/1051/format/webp)

8、操作：选择“允许连接”，下一步

![img](https://upload-images.jianshu.io/upload_images/15937175-c3218ee89f4a2dfd.png?imageMogr2/auto-orient/strip|imageView2/2/w/1044/format/webp)

9、配置文件：勾选“域”，“专用”，“公司”，点击下一步

![img](https://upload-images.jianshu.io/upload_images/15937175-be5df1be55fd8a44.png?imageMogr2/auto-orient/strip|imageView2/2/w/1040/format/webp)

10、名称：输入端口名称和描述信息，点击完成

![img](https://upload-images.jianshu.io/upload_images/15937175-472292e69235d9b1.png?imageMogr2/auto-orient/strip|imageView2/2/w/1024/format/webp)

