---
title: jwt入门
date: 2021-11-13 16:38:19
tags:
categories:
- 组件
---



# [【JWT学习之一】JWT入门](https://www.cnblogs.com/cac2020/p/13750502.html)

<!-- more -->



##  一、传统的session认证
要说起JWT的起源需要先来谈谈基于token的认证和传统session认证的区别。

1. 基于session认证机制

![img](http://blogimg.hongjy.cn/650365-20200929165154160-1810066118.png)

我们知道，http协议本身是一种无状态的协议，而这就意味着如果用户向我们的应用提供了用户名和密码来进行用户认证，那么下一次请求时，用户还要再一次进行用户认证才行，因为根据http协议，我们并不能知道是哪个用户发出的请求，所以为了让我们的应用能识别是哪个用户发出的请求，我们只能在服务器存储一份用户登录的信息，这份登录信息会在响应时传递给浏览器，告诉其保存为cookie,以便下次请求时发送给我们的应用，这样我们的应用就能识别请求来自哪个用户了,这就是传统的基于session认证。
但是这种基于session的认证使应用本身很难得到扩展，随着不同客户端用户的增加，独立的服务器已无法承载更多的用户，而这时候基于session认证应用的问题就会暴露出来.

2. 基于session认证所显露的问题
   Session: 每个用户经过我们的应用认证之后，我们的应用都要在服务端做一次记录，以方便用户下次请求的鉴别，通常而言session都是保存在内存中，而随着认证用户的增多，服务端的开销会明显增大。
   扩展性: 用户认证之后，服务端做认证记录，如果认证的记录被保存在内存中的话，这意味着用户下次请求还必须要请求在这台服务器上,这样才能拿到授权的资源，这样在分布式的应用上，相应的限制了负载均衡器的能力。这也意味着限制了应用的扩展能力。
   CSRF: 因为是基于cookie来进行用户识别的, cookie如果被截获，用户就会很容易受到跨站请求伪造的攻击

## 二、什么是JWT？
Json web token (JWT), 是为了在网络应用环境间传递声明而执行的一种基于JSON的开放标准(RFC 7519).该token被设计为紧凑且安全的，特别适用于分布式站点的单点登录（SSO）场景。JWT的声明一般被用来在身份提供者和服务提供者间传递被认证的用户身份信息，以便于从资源服务器获取资源，也可以增加一些额外的其它业务逻辑所必须的声明信息，该token也可直接被用于认证，也可被加密。

1. 应用场景
   Authorization (授权) : 这是使用JWT的最常见场景。一旦用户登录，后续每个请求都将包含JWT，允许用户访问该令牌允许的路由、服务和资源。单点登录是现在广泛使用的JWT的一个特性，因为它的开销很小，并且可以轻松地跨域使用。
   Information Exchange (信息交换) : 对于安全的在各方之间传输信息而言，JSON Web Tokens无疑是一种很好的方式。因为JWT可以被签名，例如，用公钥/私钥对，你可以确定发送人就是它们所说的那个人。另外，由于签名是使用头和有效负载计算的，您还可以验证内容没有被篡改。

2. JWT优缺点
   优点
   (1)因为json的通用性，所以JWT是可以进行跨语言支持的，像JAVA,JavaScript,NodeJS,PHP等很多语言都可以使用。
   (2)因为有了payload部分，所以JWT可以在自身存储一些其他业务逻辑所必要的非敏感信息。
   (3)便于传输，jwt的构成非常简单，字节占用很小，所以它是非常便于传输的。
   (4)它不需要在服务端保存会话信息, 所以它易于应用的扩展

​		缺点
​		(1)JWT的最大缺点是服务器不保存会话状态，所以在使用期间不可能取消令牌或更改令牌的权限。也就是说，一旦JWT签发，在有效期内将会一直有效。
​		(2)JWT本身包含认证信息，因此一旦信息泄露，任何人都可以获得令牌的所有权限。为了减少盗用，JWT的有效期不宜设置太长。对于某些重要操作，用户在使用时应该每次都进行进行身份验证。
​		(3)为了减少盗用和窃取，JWT不建议使用HTTP协议来传输代码，而是使用加密的HTTPS协议进行传输。

## 三、基于JWT token的鉴权机制
基于token的鉴权机制类似于http协议也是无状态的，它不需要在服务端去保留用户的认证信息或者会话信息。这就意味着基于token认证机制的应用不需要去考虑用户在哪一台服务器登录了，这就为应用的扩展提供了便利。

1、JWT登录认证鉴权流程

![img](http://blogimg.hongjy.cn/650365-20200930090643811-2012264997.png)

```
(1)用户未登录，直接访问应用ClientA(或ClientB);
(2)Client过滤器Filter拦截校验是否含有JWT以及是否过期;
(3)如果有JWT,则直接转向Client应用,并返回Client资源;如果没有JWT或者JWT过期就会转向SSO认证中心,SSO将登录页面返回给用户;
(4)用户填写用户名和密码，加密传输提交到SSO，SSO查询数据库比对用户资料认证通过后，使用user_id生成JWT返回给用户，JWT存储到Cookies或者localstorage，此时携带JWT并重定向到用户原先访问的Client应用地址;
(5)在Cookie失效或者被删除前，用户每次请求都会将含有JWT的Cookie发送给Client;
(6)Client应用将JWT从请求中提取出来,将JWT进行Base64解码，检查JWT的有效性:例如检查签名是否正确；检查Token是否过期；检查Token的接收方是否是自己（可选）。
```

注意：
(1)建议用户名和密码通过SSL加密的传输（https协议），避免敏感信息被嗅探；
(2)JWT放置到Cookie中，设置HttpOnly属性来防止Cookie被JavaScript读取，从而避免跨站脚本攻击（XSS攻击）;
(3)服务端要支持CORS(跨域资源共享)策略，一般我们在服务端这么做就可以了Access-Control-Allow-Origin: *   参考：[CORS](https://www.jianshu.com/p/89a377c52b48)。

流程可以参考：

[基于JWT的单点登录](https://www.pianshen.com/article/62963869/)

2、JWT结构
![img](http://blogimg.hongjy.cn/650365-20200930090829260-746400117.jpg)

第一部分我们称它为头部（header),第二部分我们称其为载荷（payload, 类似于飞机上承载的物品)，第三部分是签证（signature).
(1)JWT头部-header

```
{
  "alg": "HS256", //声明加密的算法 通常直接使用 HMAC SHA256,简写HS256；
  "typ": "JWT"  //声明类型，这里是jwt
}
```

然后将头部进行base64加密（该加密是可以对称解密的),构成了第一部分：eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9

(2)JWT中部-playload
载荷就是存放有效信息的地方。这个名字像是特指飞机上承载的货品，这些有效信息包含三个部分：标准中注册的声明、公共的声明、私有的声明。
(2.1)标准中注册的声明 (建议但不强制使用)

[![复制代码](http://blogimg.hongjy.cn/copycode.gif)](javascript:void(0);)

```
iss: jwt签发者
sub: jwt所面向的用户
aud: 接收jwt的一方
exp: jwt的过期时间，这个过期时间必须要大于签发时间
nbf: 定义在什么时间之前，该jwt都是不可用的.
iat: jwt的签发时间
jti: jwt的唯一身份标识，主要用来作为一次性token,从而回避重放攻击。
```

[![复制代码](http://blogimg.hongjy.cn/copycode.gif)](javascript:void(0);)

(2.2)公共的声明 ：
公共的声明可以添加任何的信息，一般添加用户的相关信息或其他业务需要的必要信息.但不建议添加敏感信息，因为该部分在客户端可解密.

(2.3)私有的声明 ：
私有声明是提供者和消费者所共同定义的声明，一般不建议存放敏感信息，因为base64是对称解密的，意味着该部分信息可以归类为明文信息。

示例：

```
{
  "sub": "1234567890",
  "name": "John Doe",
  "admin": true
}
```

然后将其进行base64加密，得到Jwt的第二部分:eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9

(3)JWT尾部-signature
这是一个签证信息，这个部分需要base64加密后的header和base64加密后的payload使用.连接组成的字符串，然后通过header中声明的加密方式进行加盐secret组合加密，然后就构成了jwt的第三部分。

```
// js示例
var encodedString = base64UrlEncode(header) + '.' + base64UrlEncode(payload);
var signature = HMACSHA256(encodedString, 'secret'); // TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ
```

注意：secret是保存在服务器端的，jwt的签发生成也是在服务器端的，secret就是用来进行jwt的签发和jwt的验证，所以，它就是你服务端的私钥，在任何场景都不应该流露出去。一旦客户端得知这个secret, 那就意味着客户端是可以自我签发jwt了。

3、JWT使用
JWT传送给客户端后可以保存在Cookie或者localStorage里，然后再次请求的时候取出来，放进Http Header请求头里，服务端先Cookie里获取，如果没有获取到再从请求头里获取JWT Token。

[![复制代码](http://blogimg.hongjy.cn/copycode.gif)](javascript:void(0);)

```
//客户端伪代码，一般是在请求头里加入Authorization，并加上Bearer标注：
fetch('api/user/1', {
  headers: {
    'Authorization': 'Bearer ' + token
  }
})

//服务端伪代码
String token = request.getCooke("token").value();
if(token == ""){
    token = request.getHeader("Authorization")
}
```

[![复制代码](http://blogimg.hongjy.cn/copycode.gif)](javascript:void(0);)

参考：
[jwt官网](https://jwt.io/introduction/)
[源码Java版GITHub地址](https://github.com/auth0/java-jwt)

[什么是 JWT -- JSON WEB TOKEN](https://www.jianshu.com/p/576dbf44b2ae)
