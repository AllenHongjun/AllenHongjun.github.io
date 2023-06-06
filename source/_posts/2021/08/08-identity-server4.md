---
title: Identity Server 学习笔记
date: 2021-08-08 11:34:28
tags: 安全
categories:
- 框架
---

> 花了两天时间学习，对相关的资料和问题做一点整理。Identity Server 是一个框架或者组件或者技术，包含了身份认证，接口鉴权，单点登录等功能，是一套完整的框架，而且也比较流行，比如ABP v next 框架就集成了这个。项目中使用更加安全可靠，也同时提升开发效率。

![](http://blogimg.hongjy.cn/identity-server4-1-0.png)
<!-- more -->
## 为什么使用identity server

- 我觉得这个类似的java框架是 Spring Security，也是一个认证与授权的框架，同时具备很高的可扩展和可定制的特性。
- 比自己开发一套登录授权的功能更加的省事，毕竟他是开源免费。而且是微软的亲儿子。
- 基于 oauth2.0,集成了JWT,OPIC等，就是比较流行的功能，容易使用。
- 保护您的资源，提供会话管理和单点登录，管理和认证客户，向客户端发布身份和访问令牌，整合的第三方登录服务也很多。



## 如何来使用identity server

### 官方资料

- [官方文档](https://identityserver4.readthedocs.io/en/latest/)-- 咋一看全英文，密密麻麻有点不好理解，其实不太难。 quick-start 里面的有详细的一步一步的操作解释，配合官方的demo,还是蛮好理解的。
- [github仓库](https://github.com/IdentityServer)--主要看了里面的demo,至于具体identity server它是如何来实现，就以后有时间再来研究吧。先整明白是个什么东东，如何来使用它。
  - [demo下载地址](https://github.com/IdentityServer/IdentityServer4/tree/main/samples/Quickstarts)--具体的demo 下载的地方。就在上面的仓库里面
- [identityserver4中文文档](http://www.identityserver.com.cn/Home/Detail/javascriptclient)--翻译的中文文档，虽然不是最新版，也还是不错。
- [IdentityServer4 中文文档与实战-博客资料](https://www.cnblogs.com/stulzq/p/8119928.html)--博客内容很详细，值得推荐学习，但是demo 还是建议直接调试官方的。比较新，也不用设置项目端口。
- 相关技术（了解）
  - [jwt-解析网站](https://jwt.ms/)--这个小网站干净简洁，直接能解析token ，还是蛮好用的。
  - [jwt](https://jwt.io/)
  - [oauth2.0](https://oauth.net/2/)



### 博客教程

> 官方的文档资料demo,还是最推荐的学习资料。其他的博客文章可以作为一个参考。

-  [mall整合SpringSecurity和JWT实现认证和授权（一）](http://www.macrozheng.com/#/architect/mall_arch_04?id=mall整合springsecurity和jwt实现认证和授权（一）)
-  [单点登录概念](https://baike.baidu.com/item/%E5%8D%95%E7%82%B9%E7%99%BB%E5%BD%95/4940767)- 一次登录成功之后，服务端下的所有客户端都是登录状态，避免重复登录。
-  [从零搭建一个IdentityServer——项目搭建](https://www.cnblogs.com/selimsong/p/14328840.html)
-  [[ASP.NET Core3.1使用Identity Server4建立Authorization Server-1](https://www.cnblogs.com/jellydong/p/13295225.html)](https://www.cnblogs.com/jellydong/p/13295225.html)
-  [identity server 数据表结构分析](https://www.cnblogs.com/laozhang-is-phi/p/10660403.html)



### demo调试过程截图


>运行 identity server 服务命令行图片

<img src="http://blogimg.hongjy.cn/identity-server4-7.png" style="zoom:80%;" />

>identity server 部分表结构。

<img src="http://blogimg.hongjy.cn/identity-server4-10.png" style="zoom:80%;" />

>demo 中api项目访问404其实是正常情况，因为访问限制，需要token

<img src="http://blogimg.hongjy.cn/identity-server4-8.png" style="zoom:80%;" />


### 遇到的坑

- demo quick-start1 成功无法访问api的接口。

  - demo中 api的接口因为设置了访问限制，需要token,所以浏览器中直接不能访问，返回404是正常现象。

- [sign 签名在客户端怎么保证安全（ios，android，web）](https://segmentfault.com/q/1010000015738229)

  - 很多接口通过将请求md5加密，但是key只能保持在客户端，这个不安全，所以会有这个疑惑？ 查了资料，发现，这个加密主要还是保证保证数据的完整性，防止在网络传输的过程中篡改数据。token的安全主要是通过https,来加大难度。也就是sign是无法避免，如果真的用户的手机中了木马，那也没有什么办法了。
  - [基于 HTTP 连接下 token 安全问题？](https://www.zhihu.com/question/265033797)
  - 权限限制。 用户 防止 有越权漏洞。。以最大的恶意来怀疑用户的输入

- 官方下载的sample 无法还原包？

  > 一开始下载的demo无法运行，调试了半天，搞得一度怀疑是官方的包有问题。后面发现是vs里面包的源路径设置有问题， vs->nuget包设置->本地源取消就可以还原了。

  - [NUGET源不存在，安装Nuget包提示“本地源不存在”](https://blog.csdn.net/weixin_34148340/article/details/93188162)

  - ```csharp
    // 错误描述c
    严重性	代码	说明	项目	文件	行	禁止显示状态
    错误	NETSDK1004	找不到资产文件“D:\data\code-demo\csharp\IdentityServer4-main\samples\Quickstarts\1_ClientCredentials\src\IdentityServer\obj\project.assets.json”。运行 NuGet 包还原以生成此文件。	IdentityServer	C:\Program Files\dotnet\sdk\3.1.403\Sdks\Microsoft.NET.Sdk\targets\Microsoft.PackageDependencyResolution.targets	241	
    ```

    

### To do list

- identity server 集成使用在项目中。实现步骤。
- identity server 客户端 安卓请求,ios请求。 spa 单页面请求。如何实现。提供API接口，说明请求方式
- 整合权限角色功能，开发后台权限管理。



