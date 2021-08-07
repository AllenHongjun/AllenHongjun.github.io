---
title: Docker 入门学习
date: 2021-08-07 22:05:39
tags:
categories:
- 开发工具
---

> docker 是什么，个人感觉是类似一个虚拟机，可以运行在各个操作系统之上。方便部署各种运行环境。
>
> 这个其实不是什么教程，只是我学习过程中，整理的一点笔记。如果你也在学习，然后能对你有一点帮助，那我也是很开心的。

## 为什么使用docker

- 当前非常流行和热门的技术。

- 开发部署，非常方便，在一个容器当中配置好各种部署的环境之后，非常时候集群和分布式部署。

- 小巧灵活，比如下载一个centos7.6的镜像包有4个G,但是同样centos的docker 镜像只有200Mb,只有核心运行环境的代码

- 更高效的利用系统资源,保持一致的运行环境,持续交付和部署更加方便,更轻松的迁移,更轻松的维护和扩展



##  如何来使用docker

### 学习资源

- [官网](https://www.docker.com/)--官方网站，学习一个公共或者技术，最好的资料肯定是官方网站了。

 <img src="http://blogimg.hongjy.cn/docker-1.png" style="zoom:70%;" />

- [https://hub.docker.com/](https://hub.docker.com/)--hub,有点类似git和github的关系，这里可以上传和下载一个一个的docker镜像。

- [docker中文](https://www.docker.org.cn/index.html)-- 学习docker的中文网站

<!-- more -->

### 学习教程

- [docker入门教程](https://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html)

- [docker win10 使用](https://www.jianshu.com/p/c70756bf49e4) 在windows系统安装了一下，算是有一个了解。
    - [安装内核更新包](https://docs.microsoft.com/zh-cn/windows/wsl/install-win10#step-4---download-the-linux-kernel-update-package)
    - [使用 .wslconfig 配置全局选项](https://docs.microsoft.com/zh-cn/windows/wsl/wsl-config#configure-global-options-with-wslconfig)
    - [阿里云-容器-镜像服务-免费镜像加速器](https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors)


- [使用docker来部署项目](https://how2j.cn/k/docker/docker-docker/2005.html)-- 这个操作是使用centos7.2 在虚拟机中部署的。

     > how2j的这个教程还是比较喜欢的，讲解的比较细致，配合之前的，[如何安装虚拟机](https://how2j.cn/k/vmware/vmware-vmware/1997.html)，[如何在linux系统中部署j2ee项目](https://how2j.cn/k/deploy2linux/deploy2linux-breif/1591.html)，一步一步，就像我这种重来没有用过的小白，也能按照流程完整的操作下来。最后在制作一个自己的docker 镜像，也算是有

<img src="http://blogimg.hongjy.cn/docker-9.png"  />



- 如何使用 centos 7.6 来撸一个自己的 j2ee 项目部署的镜像。

  ```c
    // 1. 将pull下来的cetons镜像 取一个名字运行起来
    docker run -dit --privileged -p21:21 -p80:80 -p8080:8080 -p30000-30010:30000-30010 --name tmall centos:7.6.1810 /usr/sbin/init
    // 2. 运行起来的镜像就是一个容器了，执行命令进入容器当中就可以想在linux当中一样来执行操作
    docker exec -it tmall /bin/bash  // 将images 运行起来 执行这个容器。。然后进入容器当中操作
    // 3. 按照 将java 项目部署到linux 中的方法，将 环境部署起来, 安装常用工具,配置 ftp,安装jdk,mysql,tomcat等等步骤
    // 4. 因为 启动的时候 就是讲虚拟机中的端口一样映射到容器当中，所以ftp连上后，会直接连接到容器内容，就可以上传文件了。 
    // 5. 提交 完成这个docker image的制作。然后上传到自己的 仓库当中。
  ```




### 踩过的一些坑

- [Win10中Vmmem程序资源占用过高解决办法](https://zhuanlan.zhihu.com/p/277825426)
- [VMware Workstation 与 Device/Credential Guard 不兼容!](https://blog.csdn.net/luckysign/article/details/101915064)-- 因为一开始windows下安装docker开启了hype-V，导致VMware不兼容，就直接把他关掉了。
- [VM ware无法关机 虚拟机繁忙](https://blog.csdn.net/qq_34646546/article/details/86561183)--这个就直接找到进程结束就ok了
- [docker当中的端口与外部的端口冲突](https://blog.csdn.net/qq_17623363/article/details/106436394)--这个是因为之前的虚拟中linux因为已经部署过一场 j2ee的环境，安装了ftp,mysql 等，如果服务开启的话，就会无法将端口映射到docker容器中的linux系统，比较简单的办法就是关闭linux系统的中的服务。
- [docker 已经创建重名之后怎么解决](https://blog.csdn.net/iw1210/article/details/84674936)
- [**使用docker pull 下载的镜像为什么只有几百兆？**](https://blog.51cto.com/liuleis/2298633) -- 因为运行系统的代码没有那么多，很多都没有必要的。小白刚开始使用的好奇心吧。
- [vi编辑器中如何来使用查找命令](https://blog.csdn.net/ghj1976/article/details/6066069)
- [docker- 容器进入退出基本操作是什么](https://blog.csdn.net/dongdong9223/article/details/52998375)
- docker run命令这么长代表的时候意思 -- 其实看起来长，了解一下概念，其实很好理解。

```c
docker run -dit --privileged -p22:21 -p81:80 -p8081:8080 -p30020-30030:30000-30010 --name how2jtmall how2j/tmall:latest /usr/sbin/init

/*
    docker run 表示运行一个镜像
    -dit 是 -d -i -t 的缩写。 -d ，表示 detach，即在后台运行。 -i 表示提供交互接口，这样才可以通过 docker 和 跑起来的操作系统交互。 -t 表示提供一个 tty (伪终端)，与 -i 配合就可以通过 ssh 工具连接到 这个容器里面去了
    --privileged 启动容器的时候，把权限带进去。 这样才可以在容器里进行完整的操作
    -p21:21 第一个21，表示在CentOS 上开放21端口。 第二个21 表示在容器里开放21端口。 这样当访问CentOS 的21端口的时候，就会间接地访问到容器里了
    -p80:80 和 21一个道理
    -p8080:8080 和21 一个道理，在本例里，访问的地址是 http://192.168.84.128:8080/tmall/， 这个 192.168.84.128 是CentOS 的ip地址，8080是 CentOS 的端口，但是通过-p8080:8080 这么一映射，就访问到容器里的8080端口上的 tomcat了
    -p30000-30010 和21也是一个道理，这个是ftp用来传输数据的
    --name how2jtmall 给容器取了个名字，叫做 how2jtmall，方便后续管理
    how2j/tmall:latest how2j/tmall就是镜像的名称， latest是版本号，即最新版本
    /usr/sbin/init: 表示启动后运行的程序，即通过这个命令做初始化
*/

```



## 部署过程中截图

> windows系统安装docker,pull hello-world

![windows系统安装docker,pull hello-world](http://blogimg.hongjy.cn/docker-2.png)

> linux 安装docker,启动服务

![linux 安装docker,启动服务](http://blogimg.hongjy.cn/docker-4.png)

> 配置阿里云加速网站后，拉起要测试tmall镜像

![配置阿里云加速网站后，拉起要测试tmall镜像](http://blogimg.hongjy.cn/docker-5.png)

> 成功运行docker中项目的时候

![成功运行docker中项目的时候](http://blogimg.hongjy.cn/docker-6.png)

### 后续任务

- 熟练docker ，linux下部署操作的命令，多操作，多练习几次
- 使用docker 部署一个asp.net core的项目
- 熟悉一些其他的功能，发现docker其他有意思的功能。



<!-- ![](http://blogimg.hongjy.cn/docker-docker-5.png)
![](http://blogimg.hongjy.cn/docker-docker-docker-6.png)
![](http://blogimg.hongjy.cn/docker-docker-docker-7.png)
![](http://blogimg.hongjy.cn/docker-docker-docker-8.png)
![](http://blogimg.hongjy.cn/docker-docker-docker-9.png)
![](http://blogimg.hongjy.cn/docker-docker-1.png)
![](http://blogimg.hongjy.cn/docker-docker-2.png)
![](http://blogimg.hongjy.cn/docker-docker-3.png)
![](http://blogimg.hongjy.cn/docker-docker-4.png) -->
