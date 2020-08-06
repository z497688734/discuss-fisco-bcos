# 浏览器搭建
官方提供的是linux版本的,mac使用可能会有环境问题,所以使用手动搭建模式

#1 获取浏览器代码
```
git clone https://github.com/FISCO-BCOS/fisco-bcos-browser.git

├── deploy
│.. └── comm
├── img
├── server
│.. └── fisco-bcos-browser  #后端代码
└── web
    └── fisco-bcos-browser-front #前端代码

```
fisco-bcos-browser代码使用前后端分离的方式开发,代码目录很清晰

# 后端部署

环境要求

| 环境 | 版本|
| -- | -- |
| Java |jdk1.8.0_121或以上版本 |
| gradle | gradle-5.0或以上版本 |
| mysql | mysql-5.6或以上版本 |


后端编译和配置
```
cd server/fisco-bcos-browser
#编译出dist
gradle build
#配置文件
mv conf_template conf
#修改配置文件
vim conf/application.yml
    url: jdbc:mysql://127.0.0.1:3306/db_browser?useUnicode=true&characterEncoding=utf8
    username: root
    password: xxxx
    driver-class-name: com.mysql.jdbc.Driver
#运行，默认端口为5001
sh start.sh

```
查看后端是否成功启动,因安装环境不同,可能会存在以下问题

 openssl问题
```
brew install https://github.com/tebelorg/Tump/releases/download/v1.0.0/openssl.rb
```
gradle安装配置
```
Could not find method annotationProcessor() for arguments [org.projectlombok:lombok:1.18.2] on object of type org.gradle.api.internal.artifacts.dsl.dependencies.DefaultDependencyHandler.

https://gradle.org/releases/

gradle 需要使用5.0以上版本
```
##前端配置
前端代码存在web/fisco-bcos-browser-front/dist，已经编译完直接配置nginx指向即可
```
server{
    listen       80;   #步骤1、前端nginx监听端口
    server_name  lfisco-bcos.com;           #步骤1、前端地址，可>配置为域名
    location / {
            root    /Users/liuhaoyang/2cWorkPlace/demo-fisco-bcos/demo2/fisco-bcos-browser/web/fisco-bcos-browser-front/dist;   #>步骤2、前端文件路径
            index  index.html index.htm;
            try_files $uri $uri/ /index.html =404;
        }

    # Load configuration files for the default server block.
    #步骤3、后端服务(fisco-bcos-browser server)地址及端口
    location /api {
        proxy_pass    http://127.0.0.1:5101/;
        proxy_set_header Host $host;
        proxy_set_header  X-Real-IP   $remote_addr;
        proxy_set_header  X-Forwarded-For  $proxy_add_x_forwarded_for;
    }
    access_log /Users/liuhaoyang/logs/php/lfisco-bcos.com_access.log  main;
    error_log  /Users/liuhaoyang/logs/php/lfisco-bcos.com_error.log;
}
```
按照自己的环境配置完重启nginx即可


