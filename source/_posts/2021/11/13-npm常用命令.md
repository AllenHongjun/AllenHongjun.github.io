---
title: npm常用命令
date: 2021-11-13 23:17:59
tags:
categories:
- 开发工具
---



它是一个事件驱动异步I/O单进程的服务端JS环境，基于Google的V8引擎，V8引擎执行Javascript的速度非常快，性能非常好。

- 浏览器是JS的前端运行环境。
- Node.js是JS的后端运行环境，在后端中运行无法调用 DOM 和 BOM 等浏览器内置 API。
- nodejs调用服务查看服务器相关api gulp基础node环境

<!-- more -->

# node应用场景

```
创建应用服务，web开发，接口开发，客户端应用工具  gulp webpack vue脚手架 react脚手架 小程序
```

# 一、node相关工具

## 1. nvm npm版本管理工具

下载地址：https://github.com/coreybutler/nvm-windows/releases

1. 安装前卸载本地 node

2. 常见命令

   |         命令         | 功能                   |
   | :------------------: | ---------------------- |
   |   nvm list/nvm ls    | 查看安装的所有node版本 |
   |  nvm list available  | 查看所有node版本       |
   |  nvm install latest  | 安装最新node           |
   |  nvm install 版本号  | 安装指定版本           |
   |    nvm use 版本号    | 使用当前版本           |
   | nvm uninstall 版本号 | 卸载指定版本           |

## 2. npm(node package manager)

### 1、常用命令

```
如果装了git和node的，可以直接在有node_modules目录的文件夹中，右键，Git Bash Here，然后输入
```

|           功能           | 命令                                                         |
| :----------------------: | ------------------------------------------------------------ |
|     初始化package包      | npm init -y                                                  |
|           查看           |                                                              |
|      查看当前镜像源      | npm config get registry                                      |
|         查看路径         | pwd                                                          |
| 查看当前文件下的所有文件 | ls                                                           |
|      查看package包       | cat package.json                                             |
|    查看当前依赖包信息    | npm info 依赖名称                                            |
|  查看当前依赖版所有本号  | npm view 依赖名称 versions                                   |
|           下载           |                                                              |
|       下载某个依赖       | npm install 依赖名称 --save                                  |
|    下载依赖的某个版本    | npm install 依赖名称@版本号                                  |
|   下载package中的依赖    | npm install                                                  |
|           删除           |                                                              |
|     删除node_modules     | rm -rf node_modules                                          |
|        删除依赖包        | npm uninstall 依赖名称 --save                                |
|           其他           |                                                              |
|         切换镜像         | npm config set registry [https://registry.npm.taobao.org](https://registry.npm.taobao.org/) |
|           更新           | npm update                                                   |
|         清除缓存         | npm cache clean --force                                      |

### 2、npm 安装 git 上发布的包

- 这样适合安装公司内部的git服务器上的项目

  > npm install git+https://git@github.com:lurongtao/gp-project.git

- 或者以ssh的方式

  > npm install git+ssh://git@github.com:lurongtao/gp-project.git

### 3、上传自己的依赖包

1. 编写一个js自定义模块并导出

   ```
   exports.myComputed=()=>{
       return '123'
   }
   ```

2. 初始化包描述文件

   - npm init package.json

   ```
   { 
   "name": "包名", 
   "version": "版本", 
   "description": "module模块名", 
   "main": "文件（xx.js）",
   "scripts": { 
       "test": "make test" 
   }, 
   "repository": { 
       "type": "Git", 
       "url": "git+git地址" 
   }, 
   "keywords": [ 
       "demo" 
   ], 
   "author": "作者", 
   "license": "ISC", 
   "bugs": { 
       "url": "git地址" 
   }, 
   "homepage": "git地址", 
   }
   ```

3. 登陆npm 账号

   - [https://www.npmjs.com](https://www.npmjs.com/) 上面的账号
   - npm adduser 之后会要求登录账号密码，邮箱
   - npm publish 发布包到npm里

- 坑：403 Forbidden

  ```
  查看npm源：npm config get registry
  切换npm源方法一：npm config set registry http://registry.npmjs.org
  切换npm源方法二：nrm use npm
  ```

### 4、cross-env

运行跨平台设置 & 使用环境变量脚本
NODE_ENV环境变量将由 cross-env 设置 打印 process.env.NODE_ENV === 'production'

1. 安装

   > npm i cross-env -D

2. 使用package.json

   ```
       {
       "scripts": {
           "build": "cross-env NODE_ENV=production webpack --config build/webpack.config.js"
       }
       }
   ```

## 3. NRM：镜像源管理工具

nrm是npm的镜像源管理工具，有时候国外资源太慢，使用这个就可以快速地在 npm 源间切换。

- 全局安装： npm install -g nrm
- 查看原： nrm ls
- 切换源： nrm use 名称
- 测试速度：nrm test

## 4.npx:npm package extention

npm 从5.2版开始，增加了 npx 命令。它有很多用处，本文介绍该命令的主要使用场景。
Node 自带 npm 模块，所以可以直接使用 npx 命令。万一不能用，就要手动安装一下npm install -g npx

1. 解决的问题

   调用项目内部安装的模块。比如，项目内部安装了Mocha。

   只能在项目脚本和 package.json 的scripts字段里面，如果想在命令行下调用，必须像下面这样

   ```
   项目的根目录下执行
   $ node-modules/.bin/mocha --version
   ```

   npx 就是想解决这个问题，让项目内部安装的模块用起来更方便，只要像下面这样调用就行了。

   > npx mocha --version
   > 运行的时候，会到node_modules/.bin路径和环境变量$PATH里面，检查命令是否存在。

   - 避免全局安装
