---
title: Postman使用完全指南
date: 2021-11-13 23:46:17
tags:
categories:
- 开发工具
---

## Postman

Postman是一个可扩展的API开发和测试协同平台工具，可以快速集成到CI/CD管道中。旨在简化测试和开发中的API工作流。

Postman 工具有 Chrome 扩展和独立客户端，推荐安装独立客户端。

Postman 有个 workspace 的概念，workspace 分 personal 和 team 类型。Personal workspace 只能自己查看的 API，Team workspace 可添加成员和设置成员权限，成员之间可共同管理 API。

当然我个人使用一般是不登录的，因为登录之后会自动将你的测试历史数据保存到账户里，你可以登陆网页端进行查看。
因为API的很多数据是很敏感的，有的含有Token，或者就是一些私密信息，虽然Postman自己也强调说这样很安全，不会私下窥探用户的信息之类的，但是呢还是至少做一点有效的防范吧，自己不上传，因为网络并没有绝对的安全。
所以我每次测试之后会将数据(Case)保存在本地，下次使用或者换设备的情况下将数据拷贝过来又可以继续使用了。

下面正式开始介绍如何使用Postman吧。

<!-- more -->



## 为什么选择Postman?

如今，Postman的开发者已超过1000万(来自官网)，选择使用Postman的原因如下:
**简单易用** - 要使用Postman，你只需登录自己的账户，只要在电脑上安装了Postman应用程序，就可以方便地随时随地访问文件。
**使用集合** - Postman允许用户为他们的API调用创建集合。每个集合可以创建子文件夹和多个请求。这有助于组织测试结构。
**多人协作** - 可以导入或导出集合和环境，从而方便共享文件。直接使用链接还可以用于共享集合。
**创建环境** - 创建多个环境有助于减少测试重复(DEV/QA/STG/UAT/PROD)，因为可以为不同的环境使用相同的集合。这是参数化发生的地方，将在后续介绍。
**创建测试** - 测试检查点(如验证HTTP响应状态是否成功)可以添加到每个API调用中，这有助于确保测试覆盖率。
**自动化测试** - 通过使用集合Runner或Newman，可以在多个迭代中运行测试，节省了重复测试的时间。
**调试** - Postman控制台有助于检查已检索到的数据，从而易于调试测试。
**持续集成**——通过其支持持续集成的能力，可以维护开发实践。

## 如何下载安装Postman？

Step 1） 官网主页：https://www.postman.com/downloads/， 下载所需版本进行安装即可。
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_1,color_FFFFFF,t_70.png)
Step2）安装完成之后会要求你必须登录才能使用，没有账号可以进行注册，注册是免费的。(也可使用Google账号，不过基本不能登录，你懂的)

Step3）在Workspace选择你要使用的工具并点击“Save My Preferences”保存。
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_1,color_FFFFFF,t_70-163681840891962.png)
Step4）你将看到启动后的页面如下
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_1,color_FFFFFF,t_70-163681840891963.png)

## 如何使用Postman?

下图是Postman的工作区间，各个模块功能的介绍如下：

1、New，在这里创建新的请求、集合或环境；还可以创建更高级的文档、Mock Server 和 Monitor以及API。
2、Import，这用于导入集合或环境。有一些选项，例如从文件，文件夹导入，链接或粘贴原始文本。
3、Runner，可以通过Collection Runner执行自动化测试。后续介绍。
4、Open New，打开一个新的标签，Postman窗口或Runner窗口。
5、My Workspace - 可以单独或以团队的形式创建新的工作区。
6、Invite - 通过邀请团队成员在工作空间上进行协同工作。
7、History - 所有秦秋的历史记录，这样可以很容易地跟踪你所做的操作。
8、Collections - 通过创建集合来组织你的测试套件。每个集合可能有子文件夹和多个请求。请求或文件夹也可以被复制。
9、Request tab - 这将显示您正在处理的请求的标题。默认对于没有标题的请求会显示“Untitled Request”。
10、HTTP Request - 单击它将显示不同请求的下拉列表，例如 GET, POST, COPY, DELETE, etc. 在测试中，最常用的请求是GET和POST。
11、Request URL - 也称为端点，显示API的URL。.
12、Save - 如果对请求进行了更改，必须单击save，这样新更改才不会丢失或覆盖。
13、Params - 在这里将编写请求所需的参数，比如Key - Value。
14、Authorization - 为了访问api，需要适当的授权。它可以是Username、Password、Token等形式。
15、Headers - 请求头信息
16、Body - 请求体信息，一般在POST中才会使用到
17、Pre-request Script - 请求之前 先执行脚本，使用设置环境的预请求脚本来确保在正确的环境中运行测试。
18、Tests - 这些脚本是在请求期间执行的。进行测试非常重要，因为它设置检查点来验证响应状态是否正常、检索的数据是否符合预期以及其他测试。
19、Settings - 最新版本的有设置，一般用不到。
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_16,color_FFFFFF,t_70.png)

## 如何处理GET请求

Get请求用于从指定的URL获取信息，不会对端点进行任何更改。
在这里我们使用如下的URL作为演示：

```bash
https://jsonplaceholder.typicode.com/users	
```

在Postman的工作区中：
1、选择HTTP请求方式为GET
2、在URL区域输入 链接
3、点击 “Send”按钮
4、你将看到下方返回200状态码
5、在正文中应该有10个用户结果，表明您的测试已经成功运行。
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_1,color_FFFFFF,t_70-163681840892164.png)

> **注意：**在某些情况下，Get请求失败可能由于URL无效或需要身份验证。

## 如何处理POST请求

Post请求与Get请求不同，因为存在用户向端点添加数据的数据操作。使用之前GET 请求中相同数据，现在添加我们自己的用户。
Step 1）创建一个新请求
![在这里插入图片描述](http://blogimg.hongjy.cn/20200611181846413.png)
Step 2 ）在新请求中
1、选择HTTP请求方式为GET
2、在URL区域输入 链接：https://jsonplaceholder.typicode.com/users
3、切换到Body选项
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_5,color_FFFFFF,t_70.png)
**Step 3）** Body选项
1、选中raw选项
2、选择JSON
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70.png)
**Step 4）** 复制前面GET请求返回的json内容的第一节
更改id为11，更改name以及uesrname和email

```json
[
    {
        "id": 11,
        "name": "Krishna Rungta",
        "username": "Bret",
        "email": "Sincere@april.biz
	",
        "address": {
            "street": "Kulas Light",
            "suite": "Apt. 556",
            "city": "Gwenborough",
            "zipcode": "92998-3874",
            "geo": {
                "lat": "-37.3159",
                "lng": "81.1496"
            }
        },
        "phone": "1-770-736-8031 x56442",
        "website": "hildegard.org",
        "company": {
            "name": "Romaguera-Crona",
            "catchPhrase": "Multi-layered client-server neural-net",
            "bs": "harness real-time e-markets"
        }
    }
]
```

![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_1,color_FFFFFF,t_70-163681840892265.png)

> **注意：** 检查Body里用到的JSON格式很重要，以确保数据正确。
> 检测的工具比如：https://jsonformatter.curiousconcept.com/

![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_1,color_FFFFFF,t_70-163681840892366.png)
Step 5 ）发送请求
1、完成上述的信息输入，点击Send按钮
2、Status:应该是201，显示为创建成功
3、在Body里返回数据
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840892367.png)

## 如何将请求参数化

数据参数化是Postman最有用的特征之一。你可以将使用到的变量进行参数化，而不是使用不同的数据创建相同的请求，这样会事半功倍，简洁明了。
这些数据可以来自**数据文件**或**环境变量**。参数化有助于避免重复相同的测试，可用于自动化迭代测试。

参数通过使用**双花括号**创建:**{{sample}}**。
比如下面的请求：
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840892468.png)
接下来创建一个参数化get请求：
**Step 1）** 创建一个参数化get请求
1、将HTTP请求设置为GET
2、输入URL： https://jsonplaceholder.typicode.com/users；将链接的域名部分替换为参数，例如`{{url}}`。请求url现在应该是{{url}}/users。
3、点击Send按钮。
应该没有响应，因为我们没有设置参数的源，如下图：
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840892469.png)
**Step 2)** 使用环境设置所需的参数
1、点击眼睛图标
2、单击Edit将该变量设置为可在所有集合中使用的全局环境。
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840892470.png)
**Step 3）** 变量--variable
1、将名称设置为url，该url为https://jsonplaceholder.typicode.com
2、点击保存按钮
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840892471.png)
**Step 4）** 如果看到下面截图的样式，请单击Close
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840892572.png)
**Step 5 ）** 回到你的Get请求页面，然后单击发送Send按钮，Get请求应该就会返回结果了，如下图：
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_16,color_FFFFFF,t_70-163681840892573.png)

> **注意：**请确保所有的参数都有准确的源数据，不管是**环境变量**还是**数据文件**，以避免出错。

## 如何创建Postman Tests

Postman Tests在请求中添加JavaScript代码来协助验证结果，如：成功或失败状态、预期结果的比较等等。
通常从pm.test开始。它可以与断言相比较，验证其他工具中可用的命令。
接下来创建一个包含Tests的请求：
**Step 1）** 创建一个Get请求
1、切换到Tests选项，右边是代码片段选项。
2、从右边的代码片段选项里面选中 “Status code: Code is 200”
3、JS代码就自动出现在窗口中
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840892574.png)
**Step 2)** 点击发送请求按钮。测试结果就显示出来了，如下图：
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840892675.png)
**Step 3)** 回到Tests选项卡，让我们添加另一个测试。这次我们将比较预期结果和实际结果。
在右边的SNIPPETS区域选择"Response body:JSON value check"选项，我们将检查Leanne Graham是否拥有userid 1。
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_16,color_FFFFFF,t_70-163681840892976.png)
**Step 4）**
1、将代码中的“Your Test Name”替换为“Check if user with id1 is Leanne Graham”，以便测试名称确切描述我们想测试的内容。
2、使用jsonData[0].name代替jsonData.value; 获取路径，在获取结果之前检查Body。因为Leanne Graham是userid 1，所以jsonData在第一个结果中，这个结果应该从0开始。如果你想获得第二个结果，那么对后续结果使用jsonData[1] 即可。
3、在eql中，输入“Leanne Graham”

```bash
pm.test("Check if user with id1 is Leanne Graham", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData[0].name).to.eql("Leanne Graham");
});
```

![在这里插入图片描述](http://blogimg.hongjy.cn/20200622161148159.png)
**Step 5)** 点击发送请求，可以看到你的请求之后测试结果中有两项显示测试通过。
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840892977.png)

> **注意：**
> 有不同种类的测试可以在Postman中创建。尝试探索这个工具，看看哪些测试适合你实际测试。

## 如何创建测试集合

集合在组织测试套件中扮演着重要的角色。它可以被导入和导出，使得在团队之间共享集合变得很容易。在本教程中，我们将学习如何创建和执行集合。

**Step 1)** 单击页面左上角的New按钮，如下图：
![在这里插入图片描述](http://blogimg.hongjy.cn/20200622161456159.png)
**Step 2)** 选择Collection(集合). 创建collection窗口弹出，如下图.
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840893078.png)
**Step 3)** 输入所需的集合名称和描述，然后单击create。
现在已经创建了一个集合。
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840893079.png)
**Step 4 )** 和前面的Get请求一样，点击保存。
![在这里插入图片描述](http://blogimg.hongjy.cn/20200622161717819.png)
**Step5 ）**
1、选择Postman 测试集合(Test Collection)。
2、点击保存Postman Test Collection
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840893180.png)
**Step 6)** Postman test collection现在应该包含了一个请求，如下图：
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_1,color_FFFFFF,t_70-163681840893181.png)
**Step 7)** 重复上述的Step4-5，继续创建请求，这样，测试集合就应该有2个请求了，如下图。
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840893182.png)

## 如何使用Collection Runner 运行集合

有两种方式来运行一个集合，即Collection Runner和Newman。
**Collection Runner:**
**Step 1)** 单击页面顶部导入按钮旁边的**Runner**按钮，如下图。
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840893283.png)
**Step 2）**Collection Runner页面应该出现如下所示。以下是对各个字段的描述
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_16,color_FFFFFF,t_70-163681840893284.png)
**Step 3)** 做如下设置，运行你的测试集合

- 选择Postman测试集合-集合迭代次数为3

- 设置延迟为2500毫秒

- 点击Start Run按钮
  ![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840893385.png)
  
  **Step 4)** 单击Run按钮后将显示Run结果页。根据延迟的不同，你应该在测试执行的同时看到显示的结果。

1、一旦测试完成，你就可以看到测试状态是通过还是失败，以及每个迭代的结果。
2、你将看到Get请求的Pass状态；
3、由于我们没有任何Post测试，所以应该会出现请求没有任何测试的消息。
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840893386.png)
可以出在请求中进行测试是多么重要，这样你就可以验证HTTP请求状态是否成功，以及是否创建或检索了数据。

## 如何使用Newman运行集合

运行集合的另一种方式是通过Newman。Newman和Collection Runner之间的主要区别如下:
1、Newman是Postman的替代品，所以需要单独安装Newman；
2、Newman使用命令行，而Collection Runner使用UI界面；
3、Newman可以用于持续集成。

安装Newman并运行Collection，步骤如下:
**Step 1)** 下载并安装NodeJs: http://nodejs.org/download/
**Step 2)** 打开命令行窗口并输入下面命令：

```bash
npm install -g newman
```

安装后 如下图：
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_1,color_FFFFFF,t_70-163681840893387.png)
**Step 3 ）**
Newman安装好之后，让我们回到Postman的workspace。在Collections框中，单击三个点 **...** 会出现新的选择选项，可看到Export选项，如下图：
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_1,color_FFFFFF,t_70-163681840893488.png)
**Step 4 ）**
选择导出集合，默认使用推荐的集合版本，比如此处是v2.1，然后单击导出：
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840893489.png)

**Step 5 ）** 选择你想要保存的地址之后点击保存，这里建议专门新建一个文件夹来存放你的Postman tests。
**Step 6 ）** 另外还需要导出我们的环境(enviroment)。单击全局环境下拉菜单旁边的eye图标，选择JSON格式下载。选择你想要的位置，然后单击Save。最好将环境放在与Step5 导出的集合相同的文件夹中。
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_6,color_FFFFFF,t_70-163681840893590.png)

**Step 7 ）** 导出Environment 到集合文件夹后，现在回到命令行，将目录更改为保存集合和环境的位置。

```bash
cd C:\Users\Asus\Desktop\Postman Tests
```

**Step 8 ）** 使用下面的命令运行你的测试集合：

```bash
newman run PostmanTestCollection.postman_collection.json -e Testing.postman_globals.json
```

运行的结果应该如下图：
![在这里插入图片描述](http://blogimg.hongjy.cn/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3piajE4MzE0NDY5Mzk1,size_1,color_FFFFFF,t_70-163681840893591.png)

关于Newman的一些基础指导如下：
1、只运行集合（如果没有环境或测试数据文件依赖关系，则可以使用此选项。）

```bash
newman run <collection name> 
```

2、运行集合和环境（参数-e 是environment）

```bash
newman run <collection name> -e <environment name> 
```

3、使用所需的编号运行集合的迭代。

```bash
newman run <collection name> -n <no.of iterations>
```

4、运行数据文件

```bash
newman run <collection name> --data <file name>  -n <no.of iterations> -e <environment name> 
```

5、设置延迟时间。(这一点很重要，因为如果由于请求在后台服务器上，完成前一个请求时没有延迟时间直接启动下一个请求，测试可能会失败。)

```bash
newman run <collection name> -d <delay time>
```

[转载-API测试之Postman使用完全指南(Postman教程，这篇文章就够了)](https://www.cnblogs.com/softwaretesterpz/p/13205666.html)
