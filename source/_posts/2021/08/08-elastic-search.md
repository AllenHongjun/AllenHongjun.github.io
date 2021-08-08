---
title: Elastic Search 入门学习笔记
date: 2021-08-08 11:09:34
tags:
categories:
- 中间件
---

>Elastic Search 是一个搜索分析引擎，这个是我刚接触学习整理的一点资料和笔记，因为这个在开放中肯定为遇到，然后之前也一直都没有这么重视，这次就花了一点时间学习了一下。

![](http://blogimg.hongjy.cn/elastic-search-1-1.png)
<!-- more -->
## 为什么使用 Elastic Search

- [分词搜索功能](http://www.woshipm.com/pd/3422975.html)  分析分词搜索在业务具体一些实现是什么，有什么样子的需求。
- 业务中有需求，比如搜素商品的时候，需要能够分词，提升用户体验。



## 如何来使用Elastic Search



### 官方资料

- [kibana](https://www.elastic.co/kibana/)  搜索的客户端管理网页，也是一个功能丰富的管理工具
- [kibana使用手册-中文](https://www.elastic.co/guide/cn/kibana/current/index.html)
- [elasticsearch-net](https://github.com/elastic/elasticsearch-net)    Elastic Search.Net & NEST  dot net的搜索sdk
- [elasticsearch-analysis-ik](https://github.com/medcl/elasticsearch-analysis-ik)   The IK Analysis plugin integrates Lucene IK analyzer into elasticsearch, support customized dictionary. 中文词库插件
- [elastic](https://www.elastic.co/)  Elasticsearch 是一个分布式的、开源的搜索分析引擎，支持各种数据类型，包括文本、数字、地理、结构化、非结构化。
- [Elasticsearch 相关官方文档 中文](https://www.elastic.co/guide/cn/index.html)



### 教程文章

- [ElasticSearch入门 附.Net Core例子](https://www.cnblogs.com/CoderAyu/p/9601991.html) 这个例子感觉还蛮不错的，简单对照着实现了一遍。对 入门的使用步骤就大概有一些了解。

- [.NetCore项目中使用Elastic Search](https://blog.csdn.net/ao123056/article/details/115079313)

- [net core 3.1使用ElasticSearch 全文搜索引擎](https://www.cnblogs.com/netlock/p/13899368.html)

- [[mall整合Elasticsearch实现商品搜索](http://www.macrozheng.com/#/architect/mall_arch_07?id=mall整合elasticsearch实现商品搜索)](http://www.macrozheng.com/#/architect/mall_arch_07) --安装教程



### 遇到的坑

- 注意安装的版本工具组件必须一致不然无法运行。

- 运行bin目录下的elasticsearch.bat启动Elasticsearch
- [nest版本不一致的问题](https://github.com/elastic/elasticsearch-net/issues/3791)

- 如何添加中文分词插件？
  - [ES常用插件安装](https://blog.csdn.net/Anumbrella/article/details/89435017)
  - 中文分词插件: https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v6.2.2/elasticsearch-analysis-ik-6.2.2.zip
  - 通过URL来安装。 根据自己的需要来修改版本
    - elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.6.2/elasticsearch-analysis-ik-7.6.2.zip
  - 离线安装的防范
  - bin\elasticsearch-plugin install file:///C:/path/to/plugin.zip
- ES 整合实现商品搜索 思路
  - 开发功能 实现。从数据中将 商品关键词 副标题。描述导入到ES中
  - 开发增删改的修改。修改商品的时候。同步修改 ES当中的数据。
  - 修改查询分页查询的接口。从ES分页查询商品的索引。然后更加商品的id 来到数据库中查询的信息。
- NEST使用教程？
  - 如何来配置 ES分词搜索服务器。？url 端口等
  - [NEST](https://www.cnblogs.com/taylorshi/p/13676564.html)-使用。
  - [Asp.Net Core 中使用Nest:6.5.1框架查询ElasticSearch数据,使用小结。](https://blog.csdn.net/qq_38261174/article/details/97911363)
  - [Elasticsearch .net client NEST使用说明 2.x](https://www.cnblogs.com/huhangfei/p/5726650.html)
- ES如果从导入的关键词中 根据分词来搜索 接口是什么？
- ES分词搜索商品信息。如何来分页？
  - [ElasticSearch查询实战之电商商城商品搜索](https://blog.csdn.net/qq_38011415/article/details/112237718)- 有些文档的内容 还是java的要详细和多很多





### 使用效果

> 运行elstics search 服务端

![](http://blogimg.hongjy.cn/elastic-search-1.png)

> 分词搜索成功运行

![](http://blogimg.hongjy.cn/elastic-search-2.png)



> 查看kibana 看板

![](http://blogimg.hongjy.cn/elastic-search-3.png)





> 安装中文分词搜索插件

![](http://blogimg.hongjy.cn/elastic-search-7-success.png)



> 测试中文分词的功能。

![](http://blogimg.hongjy.cn/elastic-search-8.png)

### to do list

1. 将es 整合到项目，导入的商品信息，实现 es中要搜索商品的 crud接口，完成总es中分页搜索商品的功能。
2. 深入学习 es分词搜索的相关知识点。