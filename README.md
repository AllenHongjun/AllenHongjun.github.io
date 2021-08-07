---
title: hexo-next 博客安装使用之个人体验
date: 2020-10-17 22:46:08
categories:
- 前端
- 工具
tags:
--- 
- 工具 
- hexo
## Quick Start

### Create a new post

``` bash
$ hexo new "My New Post"
```

More info: [Writing](https://hexo.io/docs/writing.html)

### Run server

``` bash
$ hexo server
```

More info: [Server](https://hexo.io/docs/server.html)

### Generate static files

``` bash
$ hexo generate
```

More info: [Generating](https://hexo.io/docs/generating.html)

### Deploy to remote sites

``` bash
$ hexo deploy
```

More info: [Deployment](https://hexo.io/docs/one-command-deployment.html)


### 安装教程
1. [hexo-文档](https://hexo.io/zh-cn/docs/)
2. [them-bext-使用文档](https://theme-next.iissnan.com/getting-started.html)
3. [GitHub+Hexo 搭建个人网站详细教程](https://zhuanlan.zhihu.com/p/26625249)

<!--more-->
### 常用命令
- hexo init 博客名   #新建一个博客
- hexo new 文章名   #新建一片文章
- hexo g             #生成博客
- hexo d            #发布到github page
- hexo server -p 5000 #在指定的端口本地浏览

### 工具
- [node]
- [git]
- [hexo]
- [next]
- [域名-github]

### 问题
- hexo官网访问速度慢？
    - 查了 hexo.io 的域名解析是在新加坡。不挂代理的话速度奇慢
- hexo d 发布404？
    - source 文件夹 CNAME 文件要大写没有任何后缀。
    - CNAME 里面的域名 要和配置文件中的 url保持一致。

- [用 Hexo-Console-Rename 修改文件名](https://roro4ever.github.io/2019/11/28/%E7%94%A8-hexo-console-rename-%E4%BF%AE%E6%94%B9%E6%96%87%E4%BB%B6%E5%90%8D/%E7%94%A8-hexo-console-rename-%E4%BF%AE%E6%94%B9%E6%96%87%E4%BB%B6%E5%90%8D/)