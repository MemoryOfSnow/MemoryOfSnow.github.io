---
title: 根据deb-bundle安装MySQL
date: 2020-03-17 14:19:49
categories: Linux #Mysql
tags: [sh脚本,mysql]
---
## 根据deb-bundle安装MySQL

服务器类型：SMP Debian 4.9.189-3+deb9u2 (2019-11-11) x86_64 GNU/Linux

<!--more-->

```bash
#下载对应的deb-bundle包
 wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-server_8.0.19-1debian9_amd64.deb-bundle.tar
#解压
tar zvf mysql-server_8.0.19-1debian9_amd64.deb-bundle.tar
#得到如下文件
libmysqlclient-dev_8.0.19-1debian9_amd64.deb
libmysqlclient21_8.0.19-1debian9_amd64.deb
mysql-client_8.0.19-1debian9_amd64.deb
mysql-common_8.0.19-1debian9_amd64.deb
mysql-community-client-core_8.0.19-1debian9_amd64.deb
mysql-community-client_8.0.19-1debian9_amd64.deb
mysql-community-server-core_8.0.19-1debian9_amd64.deb
mysql-community-server-debug_8.0.19-1debian9_amd64.deb
mysql-community-server_8.0.19-1debian9_amd64.deb
mysql-community-test-debug_8.0.19-1debian9_amd64.deb
mysql-community-test_8.0.19-1debian9_amd64.deb
mysql-server_8.0.19-1debian9_amd64.deb
mysql-testsuite_8.0.19-1debian9_amd64.deb

```

## 根据实践，得到以下依赖关系

```bash
 # 按照安装mysql过程中的命令执行先后排序
 # 排除错误
 touch /etc/mysql/my.cnf.fallback
 # 安装通用文件
 dpkg -i mysql-common_8.0.19-1debian9_amd64.deb 
 #安装依赖库
 dpkg -i libmysqlclient21_8.0.19-1debian9_amd64.deb 
 dpkg -i libmysqlclient-dev_8.0.19-1debian9_amd64.deb 
 #安装core
dpkg -i mysql-community-server-core_8.0.19-1debian9_amd64.deb 
 
 #安装mysql-client
dpkg -i mysql-community-client-core_8.0.19-1debian9_amd64.deb 
dpkg -i mysql-community-client_8.0.19-1debian9_amd64.deb
dpkg -i mysql-client_8.0.19-1debian9_amd64.deb 

#安装mysql-community-server
dpkg -i mysql-community-server_8.0.19-1debian9_amd64.deb 
# 安装mysql-server
dpkg -i mysql-server_8.0.19-1debian9_amd64.deb 
# 最后一步，增加依赖项安装
apt --fix-broken install
#done!
```

## The server requested authentication method unknown to the client

安装好Mysql最新版本8.0.19后 ，用php测试链接时出现了以上问题。

 发现是由于新版本的mysql账号密码解锁机制不一致导致的 

解决办法来自[__MAN的blog]( https://blog.csdn.net/guoguicheng1314/article/details/80526111 ):

删除创建的用户和授权，

```html
找到mysql配置文件并加入default_authentication_plugin=mysql_native_password
```

变为原来的验证方式，然后从新创建用户并授权即可

 

或

```bash
mysql -u root -p
 
use mysql;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '你的密码';
```

或者

 在CREATE USER时，使用IDENTIFIED WITH xxx_plugin BY 'password'，比如： 

```sql
CREATE USER 'native'@'localhost' IDENTIFIED WITH mysql_native_password BY 'yourpassword';
```

### 授权

Access Denied问题

```sql
	# privileges可以是INSERT,UPDATE,SELECT等等。
GRANT privileges ON databasename.tablename TO 'username'@'host';
```

