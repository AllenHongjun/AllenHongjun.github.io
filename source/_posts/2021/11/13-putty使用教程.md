---
title: putty使用教程
date: 2021-11-13 10:23:55
tags:
categories:
- 开发工具
---



最近开始使用putty，在网络上看到一份很不错的教程，共享一下：putty使用方法，中文教程序言

<!-- more -->

大致内容罗列如下：

- 最简单的使用，登录 SSH 主机
- 中文乱码的处理
- PuTTY 常用配置的说明
  - 复制、粘贴
  - 保存会话
  - 注销
  - 自动登录用户名
  - 自动设置环境变量
  - 设置代理服务器
  - 自动执行命令
  - 备份、删除 PuTTY 的设置
- PuTTY 的 X11 转发
- 如何用 PuTTY 建立 SSH 隧道
- 如何用 PuTTY 建立反向的 SSH 隧道，像个特洛伊木马一样突破防火墙
- 把 PuTTY 作为一个安全的代理服务器
  - 安全的上网不被嗅探
  - 避免 MSN 等聊天工具被监听
- 怎样用 PSCP、PSFTP 安全的传输文件
  - 功能强大的 SFTP 客户端 WinSCP
- 用 PuTTYgen 生成密钥，登录 SSH 主机不再需要口令
- Pagent 代理密钥，每次开机只需要输入一次密钥口令
- Plink 简单而又迅速的执行 SSH 主机上的程序
- 常见问题

除了上面的这些，还夹杂了一些 PuTTY 使用上的技巧、服务器配置的一些安全建议。说起来这是一些有关 PuTTY 的使用教程，其实也就是 SSH 的参考教程，绝大多数的内容在其他系统或软件上也都是一样的。不同的是参数、配置、命令行之类的，只要会了一个，其他也就触类旁通了。

一些基本知识

如果你已经知道 SSH、Telnet、Rlogin 这是什么，就跳过这一部分，看下面的吧。

(以后补充，暂时空下)

 

**简介**

PuTTY 的官方网站：http://www.chiark.greenend.org.uk/~sgtatham/putty/，截止到 2007年6月，发布的最高稳定版本是 0.6。
PuTTY 是一个跨平台的远程登录工具，包含了一组程序，包括：

- PuTTY (Telnet 和 SSH 客户端)
- PSCP (SCP 客户端, 命令行下通过 SSH 拷贝文件，类似于 Unix/Linux 下的 scp 命令)
- PSFTP (SFTP 的命令行客户端，类似于 FTP 的文件传输，只不过使用的是 SSH 的 22 端口，而非 FTP 的 21 端口，类似于 Unix/Linux 下的 sftp 命令)
- PuTTYtel (仅仅是一个 Telnet 客户端)
- Plink (命令行工具，执行远程服务器上的命令)
- Pageant (PuTTY、PSCP、Plink 的 SSH 认证代理，用这个可以不用每次都输入口令了)
- PuTTYgen (用来生成 RSA 和 DSA 密钥的工具).

虽然包含了这么多，但平时经常见到只是用 PuTTY 登录服务器，完全没有发挥出 PuTTY 的强大功能。 PuTTY 作为一个组件也存在于很多的软件中，比如 FileZilla、WinSCP 在后面的文字中，如非特别说明，默认的登录的协议是 SSH。毕竟用 PuTTY 主要就是登录 SSH 主机，用 Telnet、RLogin 没法体现出 PuTTY 的强大功能。

**安装**

下载页面在这里：http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html PuTTY 需要安装么？需要么？需要么？真的需要么？不需要。PuTTY 是一个准绿色软件，说它绿色是因为直接就能使用，完全没有任何的安装程序。准绿色是指 PuTTY 的所有配置都保存到了注册表，如果不记得备份注册表中的相关内容，下次重装机器所有配置就没了，而且配置也不方便用闪存盘随身携带。但是 PuTTY 的配置删除还是蛮方便的，运行时指定个参数 -cleanup 就可以清除 PuTTY 的所有配置信息。

第一印象，开始登录一台远程主机

运行 PuTTY 就可以看到下面这个界面

![img](http://blogimg.hongjy.cn/05233656-f32f8a4dd91b4d238c6ec7598e4ce4f1.png)

在这里输入服务器的 IP
或主机名，选择好登录协议，还有协议的端口，如果希望把这次的输入保存起来，以后就不需要再重新输入了，就在第4步输入好会话保存的名称，比如：mail-server，或者干脆就是主机的地址，点击保存就可以了。

![img](http://blogimg.hongjy.cn/05233810-f79a18779a7a48b5b8fd05ae82ef891b.png)

最后点下面的 Open 按钮，输入正确的用户名和口令，就可以登录服务器了。首次登录一台主机时

第一次登录时，会看到这个对话框

![img](http://blogimg.hongjy.cn/05234157-d4169cd8acaa46d99803fc5eaee30f0b.png)

这是要告诉你登录的主机密钥指纹，点 Yes 就保存起来，以后就不会再弹出这个窗口，然后就正常登录。点 No 不保存，下次还是要提示你，然后也可以正常登录。如果一台主机我们只是临时登录一下，当然就是点 No 了。Cancel 就是取消，也就是取消了这次登录。 如果你曾经登录过这台主机，但是又弹出来这个对话框，可能有以下几种情形：

- 主机重新安装了操作系统
- 这台主机可能有多个IP，这次用的是另外一个 IP
- 有其他不怀好意的主机来冒充，诱骗我们登录，窃取隐秘信息

前两个情形很常见，一般点 Yes 就行了。后面这个嘛……唔……唔……，点 No/Cancel，再去询问相关的主机管理人员。

又看到了中文乱码

成功登录主机后，输入命令，这……这……显示，又是乱码。唉，中文乱码是一个老生常谈的问题，提起来就头大。原因嘛，不外乎字符集、终端编码之类的，还是可以解决的。

![img](http://blogimg.hongjy.cn/05234503-34057c36ad194738b1422a1778c43511.png)

PuTTY 的默认字体和字符集并不适合中文显示， 在窗口标题上点击右键，选择 Change Settings...

![img](http://blogimg.hongjy.cn/05234556-a6dbb0fc645a44b3890765d8898f1f55.png)

在打开的配置窗口左边选择 Appearance，在右边点 Font settings 里面的 Change
按钮，选择好中文字体，比如：宋体、新宋体之类的

![img](http://blogimg.hongjy.cn/05234704-e4ef3a2be3fa49d5bb2b39d584d120ea.png)

字体选择好了，还要确定字符集。
选择配置窗口左边的 Translation，在右边的 Received data assumed to be in
which character set 下拉列表中选择最后一个“Use font encoding”，最后点下面的 Apply 按钮就生效了。

![img](http://blogimg.hongjy.cn/05234823-056a6a8edacf4c38911ae2dca966ecad.png)

 

重新执行命令 ls -l，就可以正常看到中文了

![img](http://blogimg.hongjy.cn/05234916-c786bf0c7f4f4f0ca1d7cc0a8610aa40.png)

怎么还是乱码？

如果还是乱码的话，就执行以下命令，看看系统的字符集 echo LANGLANGLANGUAGE

![img](http://blogimg.hongjy.cn/05235046-8849b6e6930840db8fb47c4baf18d13b.png)

哦，原来系统的字符集是 UTF-8 呀。重新返回上面选择字符集的那一步， 选择配置窗口左边的 Translation，在右边的 Received data
assumed to be in which character set 下拉列表中选择“UTF-8”

![img](http://blogimg.hongjy.cn/05235137-cf74ea392ad847f28224778bd5131adf.png)

 

这下99%的情形下，汉字是不会有乱码了。最后，总之一下 PuTTY 中乱码的解决办法：
先看看系统的字符集，如果是 UTF-8
的，那就简单了，选择好中文字体，然后编码选择 UTF-8 就行了。
如果编码是 GB2312、GBK、GB18030，当然也包括 BIG5这些，在
PuTTY 的编码选择中看不到这些编码，那就选择最后一个“Use font
encoding”，绝大部分情况下这样就没啥问题了，反正我是没碰到有什么例外的情况。
现在的 Linux 如果默认语言选择为中文，默认的编码就是
UTF-8 了。以前安装 Redhat AS 3 时，语言选择为中文，默认的编码是 zh_CN.gb2312, zh_CN.gb18030，好像从 AS 3
update 6 开始，包括现在的 AS4、AS5，中文的默认编码都成了 zh_CN.utf8。至于 Debian、Ubuntu 等等这些上面，好像一直都是
UTF-8。
至于是使用 UTF-8呢，还是用 GB2312、GBK 或者 GB18030呢？我个人还是倾向于
UTF-8。毕竟我们使用的大多数软件都是国外的，处理中文编码多多少少有些问题，PuTTY 自然也不例外。
下面的这个图上，我把终端编码修改为
zh_CN.utf8，然后也按照前面的所说的方法把 PuTTY 的字符集修改为 UTF-8。然后在终端中输入汉字“柴锋”，按左方向键，可以看到汉字显示很正常。

![img](http://blogimg.hongjy.cn/05235413-80e3e7a9a4e74429b67c82f2e5924c8a.png)

我重新把终端的编码修改为 zh_CN.gb2312，同样的，把 PuTTY 的字符集修改为最后一个“Use font
encoding”。还是在终端上输入汉字“柴锋”，按下左方向键以后，会看到汉字乱码了。

![img](http://blogimg.hongjy.cn/05235559-3838419941b1463d9f90f1ed6e78ba40.png)

至于用哪个编码，主要还是看领导的决定了，我们的领导就喜欢 GBK，连 GB18030 都不行。以前在用 Debian 的时候，好像默认都不支持 GBK
编码。这几年公司的开发在汉字编码问题上出过几次麻烦，还不就是在 ISO8859-1,
GB2312/GBK/GB18030和UTF-8上折腾来折腾去。
给大家看一张 emacs 的截图，看看上面的这么多语言的文字共同显示，这个会是用
GB2312/GBK/GB18030 的编码么？

![img](http://blogimg.hongjy.cn/05235646-e092f18867b745e3b9047acc80b4628c.png)

用 UTF-8 也不是为了要在一个屏幕上显示好几种不认识的文字，也不一定非要是跟国际接轨弄个外包给老外开发程序做个其他语言的界面让老外用，起码不要在那么多编码里折腾了，顶多两个 ISO8859-1 和 UTF-8。发发牢骚，下面继续……在 PuTTY 里面怎样选中，复制和粘贴？

在 PuTTY 的窗口里面复制、粘贴可不能用 Windows 里的这些 Ctrl C, Ctrl Ins, Ctrl V 这些快捷键，Ctrl C 在控制台上可是终止当前的命令执行。 PuTTY 的选择、复制、粘贴这些操作都是通过鼠标来完成的。 在 Window-〉Selection 这里可以设置复制和粘贴的方式。

![img](http://blogimg.hongjy.cn/05235744-8481da9816294baa82c95d7b50d9c2f2.png)

默认的 Action of mouse buttons （鼠标按键的功能）的选项是
Compromise，这种方式下选中有两种方式，一是直接用鼠标左键拖拉选中就可以了，二是用鼠标中键单击选中区域的开头，用滚动条拖拉到期望选中区域的末尾，再用鼠标中键单击，就可以选中了。
选中以后，单击鼠标左键就把选中部分复制到剪贴板了。粘贴也很简单，单击鼠标右键。
Action
of mouse buttons 的第一个选项是 Windows （Windows
方式的），鼠标中键的操作跟前面提到的一样。右键不是粘贴了，而是打开了右键菜单。

![img](http://blogimg.hongjy.cn/05235859-b09b661db5a9486592c655f2d467c6c5.png)

其实这个右键菜单在标题栏上点击，也都可以看得到。

![img](http://blogimg.hongjy.cn/06000033-e211ed027bba46a589f938782570cc15.png)

第三个选项是 xterm （xterm 方式），这个跟默认的 Compromise 方式相反的，中键和右键的操作调换了一下，就不多说了。
下面那个
Shift overrides application's use of mouse 是和 Shift 键有关的。有些 Rogue Like 的程序，比如
mc、links、Lynx、VIM 等等，都支持鼠标操作，想在用鼠标在上面选择或粘贴就不行了。这个选项默认是选中的，在支持鼠标操作的 Rogue Like
界面下，按住 Shift 键，就可以像前面的那样用鼠标来选择、复制、粘贴了。
看下面的这个图片，用 Links 打开了 Google 的首页，用鼠标去选中
顶部中间的 Google，我们会发现，弹出了保存的对话框。

 

![img](http://blogimg.hongjy.cn/06000427-f266f921745e4a6392883e7c68060983.png)

在 Control use of mouse 里面还有个 Default selection mode （默认的选择模式），默认是
Normal，就像文字处理工具里这样的选择

![img](http://blogimg.hongjy.cn/06000700-dc7811fc6de14b979492aafa0668cd95.png)

按住 Shift 键重新操作一次，哈哈，这次选中了。

![img](http://blogimg.hongjy.cn/06000616-f0594c1918b1430aa6b4f3dbc686ebe4.png)

在 Control use of mouse 里面还有个 Default selection mode （默认的选择模式），默认是
Normal，就像文字处理工具里这样的选择

![img](http://blogimg.hongjy.cn/06000133-ee2399a1437e470caa1d2230b6bfa1d4.png)

另外一个是 Rectangular block（块选择方式），至于用哪种方式就看自己的选择了。



**实时保存会话**

这次更改配置参数了，关闭窗口后，下次使用还是要重新选择的，麻烦。 还是回到上面修改配置的哪个地方，选择左边的 Session，在右边选择要覆盖的会话名称，或者重新输入一个新的名称，点击 Save 按钮保存。

![img](http://blogimg.hongjy.cn/06000940-2ca0158ef05c44ecb21402cf66436a73.png)

成功登录主机后，也能正常看到中文了。这样，我们就可以完成大部分的工作。最后要关闭窗口了，该怎么办呢？我见过很多人，包括我们公司负责专职维护的同事，都是直接点击窗口上的关闭按钮，完全没有理会弹出警告窗口，直接点击了
Yes。

![img](http://blogimg.hongjy.cn/06001041-b5f35748962b434e8615434562a997f8.png)

这样做是不对的，首先这不是正确的注销方式，应该输入命令 exit 来正常注销；其次直接关闭窗口后，你的登录其实还在服务器上，如果一连多次的这样强制关闭窗口，用命令 w 或者 who 命令查看时，可以看到很多的用户还在系统上登录，占用了系统的资源。最重要的是，你的这次登录可能只是为了启动一下 WebLogic 或者其他什么应用服务器，直接关闭窗口后，可能会导致你的业务在随后的几分钟内也被终止，这应该不是你所希望看到的吧。 如果上述的理由是每次要输入 exit 然后回车，比较麻烦。你可以用快捷键 Ctrl d 来注销登录，一般情况下，快捷键一按窗口都直接关闭了，还省了两次鼠标点击。 在前面说道保存会话时，大家或许也注意到，下面有个 Close window on exit 有三个选项：

- Always （不管怎样，窗口总是要关闭的）
- Never （无论是否有程序还在运行，都不要关闭窗口）
- Only on clear exit （这个是默认选中的，只有在本次登录中运行的程序都正常终止或者在后台运行，窗口才关闭）

有的程序在执行时，虽然在命令最后面加上 “&”就能放到后台运行。但是正常注销登录后，窗口没有被自动关闭，还能看到程序的输出，这时强制关闭窗口还是可以的。为了避免这种情形，可以使用 nohup 命令。 用法嘛就是： nohup 命令 命令参数，这样就可以了。

窗口保存的输出有点少，前面的都看不到了

执行了一个命令，输出了好多东西，但是默认的配置下，PuTTY只保存了最后200行的内容，满足不了我们的需求

转载: [putty使用教程(总结)](https://www.cnblogs.com/yuwentao/archive/2013/01/06/2846953.html)
