---
title: win注册表学习使用
date: 2021-11-13 20:20:50
tags:
categories:
- 计算机基础
- 操作系统
- windows


---

## 一、Win10注册表分支功能详解



![img](http://blogimg.hongjy.cn/1879824-20201129213153990-1923716097.png)

<!-- more -->

### 1.1、HKEY_CLASSES_ROOT

　　说明：该根键包括启动应用程序所需的全部信息，包括扩展名，应用程序与文档之间的关系，驱动程序名，DDE和OLE信息，类ID编号和应用程序与文档的图标等。

　　在这一个根键中记录的是WINDOWS操作系统中所有数据文件的信息内容，主要记录了不同文件的文件扩展名和与之相对应的应用程序。这就是为什么我们双击某一个文档的时候，可以由系统自动调出应用程序的所在了。这个根键的子键当大家展开时发现是非常多的，它主要分为两种：一是已经注册的各类文件的扩展名；一是各种文件类型的有关信息。

　　HKEY_CLASSES_ROOT\shell 对文件弹出的菜单项

　　HKEY_CLASSES_ROOT\folder\shell 对文件夹和驱动器弹出的菜单项

　　HKEY_CLASSES_ROOT\directory\shell 对文件夹弹出的部分内容

　　HKEY_CLASSES_ROOT\drive\shell 对驱动文件夹弹出的菜单项

我们知道，在这一个根键中记录的是WINDOWS操作系统中所有数据文件的信息内容，主要记录了不同文件的文件扩展名和与
之相对应的应用程序。这就是为什么我们双击某一个文档的时候，可以由系统自动调出应用程序的所在了。
这个根键的子键当大家展开时发现是非常多的，它主要分为两种：一是已经注册的各类文件的扩展名；一是各种文件类型的
有关信息。
下面我们以AVIFILE举例说明一下其下面的子项的含义：

1. CLSID：分类标识，系统可以用这个类标识来识别相同类型的文件
2. Compressors：它下面有两个子项：auds:用于设置音频数据压缩程序的类标识；vids:用于设置视频数据压缩程序的类标识
3. defaultlcon：用于设置默认图标，这个大家可以改一下试试
4. RIFFHandlers：在它的下面有两个类标识：AVI：用于设置AVI文件的类标识；WAVE：用于设置WAVE文件的类标识
5. protocol：包括了执行程序和编辑程序的路径和文件名：StdExecute（stdfileediting)_server：用于指定编辑程序；StdExecute（stdfileediting)_PackageObjects:用于指定后打开AVI包对象的编辑程序；StdExecute（stdfileediting)_verb：用于设置编辑程序时的工作状态，其中有0、1、2等状态
6. Shell子项：用于设置视频文件的外壳：open:用于设置打开AVI文件的程序；play：用于设置播放命令的程序
7. Shellex：包括了视频文件的外壳扩展

### 1.2、HKEY_CURRENT_USER

　　说明：该根键包括当前登录用户的配置信息，包括环境变量，个人程序以及桌面设置等

　　此根键中保存的信息（当前用户的子项信息）与HKEY_USERS_DEFAULT下面的一模一样的。任何对 HKEY_CURRENT_USER根键中的信息的修改都会导致对HKEY_USERS_DEFAULT中子项的修改。

### 1.3、HKEY_LOCAL_MACHINE

　　说明：该根键包括本地计算机的系统信息，包括硬件和操作系统信息，安全数据和计算机专用的各类软件设置信息

　　此根键中存放的是用来控制系统和软件的设置，由于这些设置是针对那些使用Windows系统的用户而设置的，是一个公共配置信息，所以它与具体的用户没多大关系。

### 1.4、HKEY_USERS

　　说明：该根键包括计算机的所有用户使用的配置数据，这些数据只有在用户登录系统时才能访问。这些信息告诉系统当前用户使用的图标，激活的程序组，开始菜单的内容以及颜色，字体。

　　此根键中保存的是默认用户（default），当前登录用户和软件（software） 的信息，其中DEFAULT子项是其中最重要的，它的配置是针对未来将会被创建的新用户的。新用户根据默认用户的配置信息来生成自己的配置文件，该配置文件包括环境、屏幕和声音等多种信息。

　　其中常用的3项有：AppEvents子项：它包括了各种应用事件的列表：EventLabels：按字母顺序列表；Schemes：按事件分类列表；

　　Control Panel子项：它包括内容与桌面、光标、键盘和鼠标等设置有关；

　　Keyboard layout子项：用于键盘的布局（如语言的加载顺序等）

### 1.5、HKEY_CURRENT_CONFIG

　　说明：该根键包括当前硬件的配置信息，其中的信息是从HKEY_LOCAL_MACHINE中映射出来的。

　　总结：看是五个分支，其实就是HKEY_LOCAL_MACHINE、HKEY_USERS这两个才是真正的注册表键，其它都是从某个分支映射出来的。

## 二、win10编辑表在哪里以及怎么打开

### 2.1、注册表编辑器在哪

1、点击C盘，打开“Windows“文件夹

![img](http://blogimg.hongjy.cn/1879824-20201129213839981-667095074.png)

 2、拖至最底部，找到”regedit.exe“，双击运行。

![img](http://blogimg.hongjy.cn/1879824-20201129214005038-1431501436.png)

##  2.2、Win10注册表怎么打开

1、首先使用【Win】+ 【R】组合快捷键，快速打开运行命令框，在打开后面键入命令：【Regedit】

![img](http://blogimg.hongjy.cn/1879824-20201129214122210-579838451.png)

 2、完后后按回车键（或点击“确定”）就可以打开Win10注册表编辑器了

![img](http://blogimg.hongjy.cn/1879824-20201129214154631-1983030575.png)

###  2.3、Win10注册表如何备份

1、按下win+R 输入 regedit 点击确定打开注册表或直接在小娜中输入regedit 按下回车键；

2、我们可以先选定需要修改的注册表路径，如果需要修改多出路径则直接点击【计算机】进行全局备份；

![img](http://blogimg.hongjy.cn/1879824-20201129214523923-78203920.png)

 3、选中需要备份的注册表项后点击【文件】-【导出】按钮；

![img](http://blogimg.hongjy.cn/1879824-20201129214643300-1755558594.png)

 4、在 导出注册表文件界面，选择一个路径简单能够轻松访问打开的位置，然后在文件夹框中输入任意名称（主要自己能记住就好）然后点击【保存】即可。

![img](http://blogimg.hongjy.cn/1879824-20201129214751882-802415826.png)

###  2.4、Win10注册表如何还原

**1、步骤一**

　　找到备份的注册表文件，单击右键，选择【合并】或直接双击打开；

　　在弹出的框中点击【是】即可进行还原

[![img](http://blogimg.hongjy.cn/4_180335_1.jpg)](https://www.jiaochengzhijia.com/uploads/190909/4_180335_1.jpg)

**2、注册表还原方法二：**

　　1、直接在小娜中输入regedit 按下回车键或按下win+R 输入 regedit 点击确定打开注册表；

　　2、在注册表菜单中点击【文件】-【导入】；

[![img](http://blogimg.hongjy.cn/4_180346_1.jpg)](https://www.jiaochengzhijia.com/uploads/190909/4_180346_1.jpg)

　　3、在导入注册表文件框中选择注册表备份文件所在目录，然后选中备份文件，点击打开即可！

[![img](http://blogimg.hongjy.cn/4_180354_1.jpg)](https://www.jiaochengzhijia.com/uploads/190909/4_180354_1.jpg)

[转载-win10系统的注册表说表](https://www.cnblogs.com/xf23554/articles/14058231.html)