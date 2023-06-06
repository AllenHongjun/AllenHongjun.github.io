---
title: RedisDeskTopManager使用教程
date: 2021-11-13 23:06:43
tags:
categories:
- 开发工具
---

**redis desktop manager windows** 是一款能够跨平台使用的开源性redis可视化工具。

**redis desktop manager**主要针对redis开发设计，拥有直观强大的可视化界面，具有完善全面的数据操作功能，可以针对目标key执行rename，delete，addrow，reload value操作，支持通过SSH Tunnel连接，用户可以通过它对Redis进行操作管理，简化原有的命令语言，充分发挥Redis的特性。
<!--more -->

Redis Desktop Manager 简单的来讲就是Redis可视化工具，可以让我们看到Redis中存储的内容。
![redis desktop manager下载](http://blogimg.hongjy.cn/20180912151921409.jpg)



### 【基本介绍】

redis desktop manager是一款功能强大的redis数据库管理软件，可以帮助用户轻松快速的查看与操控整个数据库。redis desktop manager不仅拥有十分简洁直观的操作界面，而且所有功能信息一目了然，是广大用户必备的数据库管理神器。
redis desktop manager具有操作简单、方便快捷、功能完善、性能稳定等优点，支持用户采用可视化操作界面对数据库进行各方面工作，不管是新手用户还是专业的开发人员，该软件都是你管理数据库的最佳帮手。
Redis Desktop Manager for windows是一款可以跨平台的redis可视化工具，兼容win、mac等操作系统，该工具可以说很大程度上弥补了memcached这类key/value存储的不足，为[Java](http://www.cncrk.com/java/)、C/C++、C#、PHP、JavaScript、Perl、Object-C、Python、Ruby、Erlang等开发语言提供了便利的客户端。

### 【软件特点】

C++ 编写，响应迅速，性能好。但不支持数据库备份与恢复

### 【软件功能】

一、新建连接 
输入redis主机host，端口号port，再起个生动形象，简明达意的别名。 
二、该工具支持根据筛选条件查询key，addnewkey，reload等。 
三、支持常用redis操作 
针对目标key执行rename，delete，addrow，reloadvalue操作。 
四、命令控制台操作！

### 【安装教程】

第一步，下载RedisDesktopManager，然后双击进入安装过程，如下图所示：
![img](http://blogimg.hongjy.cn/201809121525466831.png)
第二步，由欢迎界面点击“Next”进入下一步，选择“I Agree”，如下图所示：
![img](http://blogimg.hongjy.cn/201809121525556580.png)
第三步，进入下一步，选择安装路径，默认是C盘，这里选择D盘，如下图所示：
![img](http://blogimg.hongjy.cn/201809121526022072.png)
第四步，单击“Install”进入安装进程，耐心等待一会儿，如下图所示：
![img](http://blogimg.hongjy.cn/20180912152610382.png)
第五步，安装完成后，单击“Next”，进入下一步，如下图所示：
![img](http://blogimg.hongjy.cn/20180912152617102.png)
第六步，安装成功后，勾选启动RedisDesktopManager，打开操作界面，如下图所示：
![img](http://blogimg.hongjy.cn/201809121526244183.png)

### 【配置方法】

配置 Redis DeskTop Manager
启动Redis服务端的时候会有默认端口6379，这里用默认端口配置连接。
配置如下：
1）定一个名称，随意
2）服务端地址，域名或ID，
3）Redis 端口，默认 6379
4）如果设置了连接密码，那么需要设置密码
配置好之后点击 Test Connection 按钮，看是否可以连接成功，如果失败请检查一下配置信息
![img](http://blogimg.hongjy.cn/201809121536329193.png)

### 【基本操作】

首先下载安装后，我们打开它！然后点击如图所示的地方！
![img](http://blogimg.hongjy.cn/201809121527351628.png)
点击后就会弹出一个对话框，我们在对话框中输入自己的Redis地址、
端口号、密码，然后确定后，就可以登录啦！你还可以在确定前，点击那个Test Connection 来进行连接检测。
![img](http://blogimg.hongjy.cn/201809121527443175.png)
连接之后，你会看到，在左侧有0-15个db库可以供你选择！Redis默认就会有这些数据库，你可以选择其中一个来进行查看！
![img](http://blogimg.hongjy.cn/20180912152755757.png)
![img](http://blogimg.hongjy.cn/201809121528015759.png)
我这里还没有什么数据，这时你可以选中一个数据库，双击打开！~由于我选的数据库中没有数据，所以不会看到什么。我们可以在选择的数据库上面右键单击，会弹出一个对话框。
![img](http://blogimg.hongjy.cn/201809121528071945.png)
在弹出的对话框中，我们可以选择Add new key!再弹出的对话框中添加一组Key-Value 数据进去。
![img](http://blogimg.hongjy.cn/201809121528153074.png)
点击save之后，会提示你是否从新加载这个数据库！
选择是，这时你就可以看到你选择的数据库中有刚刚添加的Key了！
![img](http://blogimg.hongjy.cn/201809121528241343.png)
然后你可以双击那个Key（nihao），它会在右侧的部分将Key 与 Value都展示出来，并且对Key有一些相应的操作。我们也可以在Key上右键单击，弹出的对话框中依然会有一些对应操作。
![img](http://blogimg.hongjy.cn/201809121528341878.png)
![img](http://blogimg.hongjy.cn/20180912152843677.png)
RedisDesktopManager这款可是化工具使用起来非常简单，让我们管理Redis数据变大更加方便了！

### 【使用教程】

**如何使用RedisDesktopManager连接redis服务**
是正确安装这个软件，安装成功之后，然后打开，点击下侧的connection to redis service
![img](http://blogimg.hongjy.cn/201809121450222290.png)
输入外地市连接的ip地址，名称，端口号，等基本信息，然后点击，保存即可，
![img](http://blogimg.hongjy.cn/201809121450356225.png)
再进行保存之前还可以进行测试，查看连接信息是否正确，如果点击测试显示测试成功，
![img](http://blogimg.hongjy.cn/201809121450414832.png)
双击刚才创建的连接就可以与redis进行连接，然后就可以对redis进行相关的操作。
![img](http://blogimg.hongjy.cn/201809121450495338.png)
展开redis内存数据库，可以看到一共有16个数据库，编号从0到15，选择某一个数据库就可以进行增删改查操作，
![img](http://blogimg.hongjy.cn/201809121450554180.png)
选择某一个数据库，然后点击右键，就可以添加某一个元素，添加完之后，这个元素就可以保存到redis内存数据库中，
![img](http://blogimg.hongjy.cn/201809121451022787.png)
添加成功之后，然后再次打开数据库，就可以看到刚才添加的元素
![img](http://blogimg.hongjy.cn/201809121451129809.png)
![img](http://blogimg.hongjy.cn/201809121451187864.png)

**如何使用RedisDesktopManager创建list列表数据**
首先启动RedisDesktopManager客户端，连接到redis服务器（连接方式这里不再详细描述）。选择其中一个db，右击选择"Add new key"
![img](http://blogimg.hongjy.cn/201809121531056031.jpg)
填写key的名称，这里注意type类型需要选择list，然后在value框里面填写值的内容
![img](http://blogimg.hongjy.cn/20180912153115795.jpg)
添加完成之后，如果没有显示，点击Reload刷新，会在列表中显示刚刚添加的key，右侧显示的是list列表值的详细信息，在这个页面右侧有3个按钮对应value值的新增、删除和重新加载
![img](http://blogimg.hongjy.cn/201809121531242413.jpg)
点击右侧Add row可以添加list中的一个元素
![img](http://blogimg.hongjy.cn/20180912153130695.jpg)
添加完成之后，如果没有立即显示，点击Reload value重新刷新加载，添加完成之后，会显示在列表详情中
![img](http://blogimg.hongjy.cn/201809121531371037.jpg)
还可以删除某个list中的元素，点击"Delete row"删除，删除完成之后，如果没有刷新，点击Reload value重新加载。
![img](http://blogimg.hongjy.cn/20180912153143339.jpg)
![img](http://blogimg.hongjy.cn/201809121531513827.jpg)



### 【问题汇总】

一、注释redis.conf文件中的：bind 127.0.0.1(在一段文字之前打#号为注释)
![img](http://blogimg.hongjy.cn/201809121539598859.png)

二、设置密码 为了安全一定要设，而且这里如果不绑定ip也不设密码的话，redis是默认保护模式，只能本虚拟机访问，不允许其他ip访问，本人刚开始图方便啥都不设，结果在这里踩坑了；
![img](http://blogimg.hongjy.cn/201809121540084769.png)

三、保存配置文件，重启redis服务,查看虚拟机ip；
![img](http://blogimg.hongjy.cn/201809121540237098.png)

四、接着又是个坑,拿到IP后，返回Windows，开启cmd，通过telnet命令，测试端口是否畅通。；
这时我返回的是“telnet不是内部或外部命令”；
原因：Windows7系统环境下，Telnet客户端默认是关闭状态。找度娘吧http://jingyan.baidu.com/article/6525d4b1377913ac7d2e94eb.html；
然后再试：
![img](http://blogimg.hongjy.cn/201809121540546303.png)
意思是：CentOS的6379端口没有开启；
去开启：
输入firewall-cmd --query-port=6379/tcp，如果返回结果为no，那么证明6379端口确实没有开启。
输入firewall-cmd --add-port=6379/tcp，将6379端口开启，返回success。
然后再执行上一条命令，返回yes，证明端口已经成功开启。
![img](http://blogimg.hongjy.cn/20180912154102415.png)
原因：
**由于linux[防火墙](http://www.cncrk.com/firewall/)默认开启，redis的服务端口6379并不在开放规则之内，所有需要将此端口开放访问或者关闭防火墙。
**关闭防火墙命令：sevice iptables stop
**如果是修改防火墙规则，可以修改：/etc/sysconfig/iptables文件
再用Telnet 测.返回的结果一片纯黑，ok了;
然后用redie desktop manager连就可以了：
![img](http://blogimg.hongjy.cn/201809121541116558.png)


 [转载-RedisDeskTopManager使用教程](https://www.cnblogs.com/Rawls/p/10574511.html)


**参考链接地址：**

官网地址：https://redisdesktop.com/download

官网github地址：https://github.com/uglide/RedisDesktopManager/releases
