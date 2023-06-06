---
title: win在IIS服务器上安装SSL证书
date: 2021-11-13 20:30:45
tags:
categories:
- 计算机基础
- 操作系统
- windows
---


您可以在IIS（Internet Information Services）服务器上安装SSL证书，确保Web服务支持HTTPS安全访问。本文以安装在Windows Server 2012 R2操作系统上的IIS 8为例，介绍如何为IIS服务器安装SSL证书。

<!--more-->

## 前提条件

- 您的Web服务器类型是IIS。

  如果您使用其他类型的Web服务器，请参见[在服务器上安装证书](https://help.aliyun.com/document_detail/109827.htm#section-ri1-ayr-evy)，根据您的Web服务器类型，选择对应的证书安装指导。

- 您要安装的证书已通过CA中心审核并签发。

  在CA中心审核前，您需要先提交申请，详细信息，请参见[提交证书申请](https://help.aliyun.com/document_detail/98574.htm#concept-wxz-3xn-yfb)。如果审核失败，请提交[工单](https://selfservice.console.aliyun.com/ticket/category/cas)咨询。

## 步骤1：将SSL证书（IIS）下载到服务器

1. 连接到装有Windows Server 2012 R2操作系统的服务器。

   如果您使用ECS云服务器，您可以通过多种方式远程连接，详细信息，请参见[连接方式概述ECS远程连接操作指南](https://help.aliyun.com/document_detail/71529.htm#concept-tmr-pgx-wdb)。

2. 将已签发的SSL证书（IIS）下载到服务器。

   **说明** 您也可以先将SSL证书（IIS）下载到任意一台计算机，然后将已下载的证书上传到服务器。

   1. 登录[SSL证书控制台](https://yundunnext.console.aliyun.com/?p=cas)。

   2. 在左侧导航栏，单击**SSL证书**。

   3. 定位到已签发的SSL证书，单击**操作**列下的**下载**。

   4. 在**证书下载**面板，单击**IIS**服务器类型后的**下载**。![证书下载页面](http://blogimg.hongjy.cn/p101231.png)

      SSL证书（IIS）压缩包将会自动下载到当前浏览器的默认下载文件保存目录。

   5. 解压缩已下载的SSL证书（IIS）压缩包。

      根据您在提交证书申请时选择的**CSR生成方式**，解压缩获得的文件不同，具体如下表所示。关于CSR（Certificate Signing Request）的更多介绍，请参见[申请证书时需要提交的信息](https://help.aliyun.com/document_detail/144672.htm#concept-2345898)。![CSR生成方式](http://blogimg.hongjy.cn/p302380.png)

      | CSR生成方式                     | 证书压缩包包含的文件                                         |
      | :------------------------------ | :----------------------------------------------------------- |
      | **系统生成**或**选择已有的CSR** | 包括以下文件（如下图所示）：证书文件（PFX格式）：以`证书ID_证书绑定域名`方式命名。私钥文件（TXT格式）：名称为pfx-password，内容为证书的密码。**注意** 每次下载证书时都会产生新的密码，该密码仅匹配本次下载的证书文件。![证书文件](http://blogimg.hongjy.cn/p33691.png) |
      | **手动填写**                    | 只包括证书文件（PEM格式），如下图所示。证书文件以`证书ID_证书绑定域名.pem`方式命名。![证书文件](http://blogimg.hongjy.cn/p302414.png) |

3. 如果您在上一步获得了PEM格式的证书文件，必须将证书文件（连同您手动生成CSR时获得的私钥文件）格式转换成PFX格式；如果您已经获得PFX格式的证书文件，请跳过该步骤。

   您可以使用OpenSSL工具转换证书格式。更多信息，请参见[证书格式转换](https://help.aliyun.com/document_detail/42214.htm#section-hf5-mbv-ydb)。

## 步骤2：导入证书

1. 在服务器按Win+R键，打开**运行**。

2. 输入mmc，单击**确定**。![mmc](http://blogimg.hongjy.cn/p313322.png)

   该操作将打开Windows服务器控制台（MMC，Microsoft Management Console）。

3. 为本地计算机添加证书管理单元。

   1. 在控制台的顶部菜单栏，选择***\*文件\** > \**添加/删除管理单元\****。

      ![添加/删除管理单元](http://blogimg.hongjy.cn/p33702.png)

   2. 在**添加或删除管理单元**对话框，从左侧**可用的管理单元**列表中选择**证书**，单击**添加**。![添加或删除管理单元界面](http://blogimg.hongjy.cn/p101260.png)

   3. 在**证书管理单元**对话框，选择**计算机账户**，单击**下一步**。![证书管理单元](http://blogimg.hongjy.cn/p313519.png)

   4. 在**选择计算机**对话框，选择**本地计算机（运行此控制台的计算机）**，单击**完成**。![选择计算机](http://blogimg.hongjy.cn/p313520.png)

   5. 在**添加或删除管理单元**对话框，单击**确定**。![添加或删除管理单元（已添加）](http://blogimg.hongjy.cn/p313525.png)

4. 在控制台左侧导航栏，展开***\*控制台根节点\** > \**证书（本地计算机）\****，然后将光标放置在**个人**上并打开右键菜单，选择***\*所有任务\** > \**导入\****。![打开证书导入向导](http://blogimg.hongjy.cn/p33706.png)

5. 完成证书导入向导。

   1. **欢迎使用证书导入向导**：单击**下一步**。![欢迎使用证书导入向导](http://blogimg.hongjy.cn/p313529.png)

   2. **要导入的文件**：单击**浏览**，打开PFX格式的证书文件，单击**下一步**。![要导入的文件](http://blogimg.hongjy.cn/p313544.png)

      **注意** 在打开文件时，您必须先将文件类型设置为**所有文件（\*）**，然后再选择证书文件。![导入证书](http://blogimg.hongjy.cn/p33837.png)

   3. **私钥保护**：打开TXT格式的私钥文件，复制文件内容，并将内容粘贴在**密码**输入框，单击**下一步**。![输入证书秘钥](http://blogimg.hongjy.cn/p33838.png)

   4. **证书存储**：选择**根据证书类型，自动选择证书存储**，单击**下一步**。![选择证书存储](http://blogimg.hongjy.cn/p33839.png)

   5. **正在完成证书导入向导**：单击**完成**。![正在完成证书导入向导](http://blogimg.hongjy.cn/p313545.png)

   6. 收到**导入成功**提示后，单击**确定**。![证书导入向导-导入成功](http://blogimg.hongjy.cn/p302342.png)

## 步骤3：为网站绑定证书

1. 打开IIS管理器。

2. 在左侧**连接**导航栏，展开主机，单击**网站**，选择对应的域名。

3. 在右侧**操作**导航栏，单击**绑定**。![绑定](http://blogimg.hongjy.cn/p302347.png)

4. 在**网站绑定**对话框，单击**添加**。![网站绑定-添加](http://blogimg.hongjy.cn/p302348.png)

5. 在**添加网站绑定**对话框，完成网站的相关配置，并单击**确定**。

   ![添加网站绑定](http://blogimg.hongjy.cn/p302350.png)网站绑定的具体配置如下：

   - **类型**：选择**https**。

   - **IP地址**：选择服务器的IP地址。

   - 端口：默认为443，无需修改。

     **说明** 如果您设置了其他端口（例如8443），则网站用户通过浏览器访问网站时，必须在网站域名后输入端口号（以8443为例，用户必须在地址栏输入`https://domain_name:8443`）才能访问网站。使用默认端口443时无该限制，用户在浏览器地址栏输入`https://domain_name`，即可访问网站。

   - **主机名**：填写网站域名。

   - SSL证书：选择已导入的证书（alias）。

     alias是阿里云SSL证书的友好名称。如果您已导入多个阿里云SSL证书，可以单击**选择**，在**选择证书**对话框，通过域名搜索对应的证书。![选择证书](http://blogimg.hongjy.cn/p302351.png)

   完成配置后，您可以在**网站绑定**列表查看已添加的**https**类型网站绑定。![网站绑定-https](http://blogimg.hongjy.cn/p302353.png)

6. 在**网站绑定**对话框，单击**关闭**。

## 步骤4：验证证书在IIS上是否安装成功

打开计算机的浏览器，在地址栏输入安装的证书所绑定的域名，验证证书在IIS服务器上是否安装成功。

如果您能够获得响应且地址栏的前部出现![锁状图标](http://blogimg.hongjy.cn/p302370.png)图标（如下图所示)，表示成功建立了HTTPS连接，证书已经安装成功。

[转载-在IIS服务器上安装SSL证书](https://help.aliyun.com/document_detail/98729.html)