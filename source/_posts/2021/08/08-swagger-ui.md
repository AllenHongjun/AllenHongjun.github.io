---
title: Swagger UI  学习笔记
date: 2021-08-08 11:17:27
tags:
categories:
- 组件
---


> 开发中必须要提供接口文档，如果自己也了一遍注释，还需要另外再写一遍接口文档，就会感觉很麻烦。使用了swagger ui,就可以根据接口中的注释，自动的生成全部 API 接口文档，很香。

![](http://blogimg.hongjy.cn/swagger-ui1-2.png)

<!-- more -->

## 如何使用

### 官方资料

[swagger-ui官方网站](https://swagger.io/tools/swagger-ui/)

[swagger-ui-github](https://github.com/swagger-api/swagger-ui)    Swagger UI is a collection of HTML, JavaScript, and CSS assets that dynamically generate beautiful documentation from a Swagger-compliant API.

 **[Swashbuckle.AspNetCore](https://github.com/domaindrivendev/Swashbuckle.AspNetCore)**   Swagger tools for documenting API's built on ASP.NET Core

[NSwag](https://github.com/RicoSuter/NSwag)

[带有 Swagger/OpenAPI 的 ASP.NET Core Web API 文档](https://docs.microsoft.com/zh-cn/aspnet/core/tutorials/web-api-help-pages-using-swagger?view=aspnetcore-5.0)-- 微软官方教程



### 整合swagger UI 实现在线文档的教程



- [ASP.NET Core WebApi使用Swagger生成api说明文档看这篇就够了](https://www.cnblogs.com/yilezhu/p/9241261.html)

- 部分配置代码   

  - ```csharp
    // This method gets called by the runtime. Use this method to add services to the container.
            public void ConfigureServices(IServiceCollection services)
            {
                // 添加SwaggerUI
                services.AddSwaggerGen(c =>
                {
                    //配置操作会添加诸如作者、许可证和说明信息等：
                    c.SwaggerDoc("v1", new OpenApiInfo { 
                        Title = "TinyErp API", 
                        Version = "v1" ,
                        Description = "TinyErp 接口说明文档",
                        //TermsOfService = "None",
                        Contact = new OpenApiContact
                        {
                            Name = "hongjy",
                            Email = "hongjy1991@gmail.com",
                        },
                        License = new OpenApiLicense
                        {
                            Name = "MIT",
                        }
                    });
    
    
                    // 为 Swagger JSON and UI设置xml文档注释路径
                    //var xmlFile = AppContext.BaseDirectory;
                    var basePath = Path.GetDirectoryName(typeof(Program).Assembly.Location);//获取应用程序所在目录（绝对，不受工作目录影响，建议采用此方法获取路径）
                    var xmlPath = Path.Combine(basePath, "TinyErp.Admin.xml");
    
                    c.IncludeXmlComments(Path.Combine(basePath, "TinyErp.Service.xml"));
                    c.IncludeXmlComments(xmlPath);
                    c.EnableAnnotations();//注释
                    //c.SwaggerDoc("v2", new OpenApiInfo { Title = "TinyErp API", Version = "v2" });
                });
    
              
            }
    
    
    
            public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
            {
              
                //启用中间件服务生成Swagger作为JSON终结点
                app.UseSwagger();
                //启用中间件服务对swagger-ui，指定Swagger JSON终结点
                app.UseSwaggerUI(c =>
                {
                    c.SwaggerEndpoint("/swagger/v1/swagger.json", "TinyErp API v1");
                    // 要在应用的根 (http://localhost:<port>/) 处提供 Swagger UI，请将 RoutePrefix 属性设置为空字符串：
                    //c.RoutePrefix = string.Empty;
                });
            }
    ```

  - 





### 遇到的坑

- [响应内容添加注释](Swashbuckle.AspNetCore.Annotations)---Swashbuckle.AspNetCore.Annotations--使用这个组件

- [swagger-UI响应参数注释显示不全的问题。](https://blog.csdn.net/weixin_39934929/article/details/108275673)--返回参数不能显示问题解决。有些注释在别的项目中，也需要在对应的项目生产xml文档。

- [Asp.Net Core WebApi使用Swagger结合Versioning实现按版本分类显示与请求](https://www.jianshu.com/p/35ae5c157288)  -- 暂时列表

- 生成的接口地址 [https://localhost:44358/index.html](https://localhost:44358/index.html)

- c.RoutePrefix = string.Empty; 这个配置为空之后 默认方位地址就是 https://localhost:44358/index.html 中间没有了swagger。 配置之后，过了两天忘记这个配置，搞得我还以为又出什么奇怪的问题。





### 不太好用的地方

- 如果项目的接口累计变得很多，第一次从xml文件中读取，生成的时候就会很慢。
- .net 项目每次一编译，发布完成，第一次请求访问都很慢，如果接口经常有改动，使用起来感觉还是不太方便。
- 调试功能 没有postman ，apifox 等其他工具好用。





## 使用后的效果

>  项目中引入的包 我是用的 swashbuckle 。不知道这个中文啥意思，不管他了。

![](http://blogimg.hongjy.cn/swagger-ui1.png)

> rest full 格式的json地址 ，可以导入到post man当中方便调试

![](http://blogimg.hongjy.cn/swagger-ui3.png)



> 生成接口文档

![](http://blogimg.hongjy.cn/swagger-ui4.png)



> 生成请求参数和返回实体类的注释

![](http://blogimg.hongjy.cn/swagger-ui5.png)
