---
title: refus系统盘制作教程
date: 2021-11-13 15:06:33
tags:
categories:
- 开发工具
---





给大家介绍一个启动盘制作软件：rufus 大小只有1mb 功能比较全面 界面简单 制作速度快而且稳定性很好 免费无广告 完全纯净的好软件

下文 从制作到安装一条龙 我就不信还有不会的 看完不会的也可以进去询问如何使用该软件 喜欢或觉得有帮助的记得帮我点个赞



<!-- more -->



**一.准备及制作篇**

1.准备容量不小于8G的U盘一只，操作系统的iso镜像文件(下文有链接)，驱动软件，Rufus软件。

2.U盘连接电脑，做好U盘资料备份，后面会格式化U盘。

3.运行Rufus，在[设备]选项中选中U盘。

4.在[引导类型选择]-[选择]里选择操作系统iso镜像。

5.[镜像选项]选择[标准Windows安装]。

6.对于近两年新的设备：[分区类型]选GPT，[目标系统类型]选UEFI。对于三四年前的设备：[分区类型]选MBR，[目标系统类型]选BIOS。

7.卷标可以自己改，[文件系统]选ntfs比较好。[簇大小]默认即可。

8.点[开始]进行启动盘制作，这一步会格式化U盘。等待几分钟即可。

![img](http://blogimg.hongjy.cn/v2-b4685255312be053b9de7b5156d03b5d_720w.jpg)

**二.下载链接及说明**

1.windows的iso镜像推荐在 msdn下载，是官方原版镜像收录，纯净安全，不含任何广告与修改。鉴于msdn目前复杂化了，很多朋友不会下载。我挑选好了的连接 更新2021.03.10更新链接


ed2k://|file|cn_windows_10_consumer_editions_version_20h2_updated_feb_2021_x64_dvd_8ddab99d.iso|6223781888|954B729026D6E420EE46FB2DC912F256|/

（上面链接复制一下，打开迅雷点击新建任务）



2.关于GPT和MBR分区类型，MBR最多支持四个主分区，硬盘最多支持2T；GPT没有限制，是发展的趋势。如果是比较有年代的买来就是win7或者win8系统的电脑且硬盘在2T以下，选择MBR+BIOS；如果是近两年买来就是win10系统的电脑想重装系统，选GPT+UEFI。

3.现在的win10系统镜像体积一般大于4G，Rufus支持含有超过4G的单文件的ISO烧到U盘，软碟通不行。

4.软件完全免费无广告，还是在此感谢作者造福广大小白

软件官网 [https://rufus.akeo.ie/](https://link.zhihu.com/?target=https%3A//rufus.akeo.ie/) 有兴趣的可以去看一下

![img](http://blogimg.hongjy.cn/v2-b3e18e60746d77a26b6578ee03bf4772_720w.jpg)

06 下载地址

官网下载：

[https://rufus.akeo.ie/rufus.akeo.ie/](https://link.zhihu.com/?target=https%3A//rufus.akeo.ie/)

百度网盘：

[https://pan.baidu.com/s/1lxCUnnTzgtvFmNxdW2f93wpan.baidu.com/s/1lxCUnnTzgtvFmNxdW2f93w](https://link.zhihu.com/?target=https%3A//pan.baidu.com/s/1lxCUnnTzgtvFmNxdW2f93w)

提取码: rufu

按照图示做好启动盘之后下面开始安装步骤

**三、安装操作系统**

插上U盘 按下开机按钮

开机如下界面（此为技嘉）

![img](http://blogimg.hongjy.cn/v2-b879d883414122d01e4415d81710b725_720w.jpg)

按F12进入boot选项（不同主板按键不同，技嘉F12，华硕F8，微星华擎F11）选UEFI的那个（nvme磁盘只能用UEFI启动）。

![img](http://blogimg.hongjy.cn/v2-5e0aef149f5c7d155765e7422b650ea0_720w.jpg)

然后进入这个界面，点下一步

下一步

![img](http://blogimg.hongjy.cn/v2-f0e79113e49f39432f37ee66902fd806_720w.jpg)

这里是选择版本，我们就先选专业版吧

![img](http://blogimg.hongjy.cn/v2-9162b8cf3dae8eddbb4213c57a31866f_720w.jpg)

这里看字面意思就明白了，我们全新安装选择自定义

![img](http://blogimg.hongjy.cn/v2-41b3ad664828fd66c7a5e29bf1c614c5_720w.jpg)

如果你的硬盘之前是MBR分区，而你又是UEFI启动这个U盘的话，就有可能无法安装。

![img](http://blogimg.hongjy.cn/v2-484106360d456f5844adcd78fbef6e56_720w.jpg)

我们把所有分区都删除掉，（保持硬盘处于未分区状态）直接下一步就行，系统最好是安装到固态硬盘

![img](http://blogimg.hongjy.cn/v2-c359828cf72191f1d7b50b02425a0e35_720w.jpg)

其余硬盘分区暂时不用管，进入熟悉的windows操作界面以后一切都会变的简单

然后直接下一步，等完成后自动重启，记得重新开机前拔掉U盘，然后就是系统安装程序

![img](http://blogimg.hongjy.cn/v2-ca35afbafd71a382f2f6124bde2ab405_720w.jpg)

这里提醒一下，鉴于微软小霸王服务器，十分建议你们先拔掉有线网线，跳过连接无线网络，一旦连上网，安装时间就看脸了

一路点点点。。。。。

![img](http://blogimg.hongjy.cn/v2-db92066868ff4c5738ec00487015b82a_720w.jpg)

正常进入桌面以后 检查网络连接是否正常，如果没有网络的话也不用担心，复制事先下载好的驱动软件进行安装检测。安装好驱动然后就可以开始玩电脑了

![img](http://blogimg.hongjy.cn/v2-e1e02b84aa08e029a39190eaa650043c_720w.jpg)

一定要记住不要使用垃圾软件优化 好不容易安装的纯净版系统 要养成良好的使用习惯
