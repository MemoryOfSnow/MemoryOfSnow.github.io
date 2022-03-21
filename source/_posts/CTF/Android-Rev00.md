---
title: Android_Rev00
date: 2022-02-09 11:00:12
categories: CTF #
tags: [Android,逆向]
---
## 1.逆向环境组件

> 根据《安卓软件安全与逆向分析》

搭建一个Android逆向环境，最关键组件：

- JDK1.8环境+PATH；
- apktool.jar及其对应脚本；
- signapk.jar，pem、pk8签名文件（安卓源码或者openssl生成）

> 必须使用jdk1.8版本，否则在利用signapk.jar签名时，会报告BASE64Encoder类找不到异常。

其他可选组件，jd-gui，dex2jar。

<!--more-->

## 2.AndroidStduio开发工具

提供AVD和SDK。

最需要其中的adb命令行；keytool等工具也会被使用。

## 3.无混淆文件逆向思路1

在反编译后的`res\values\strings.xml`中找到提示信息对应标签，再在同目录的`public.xml`中找到对应16进制id；搜索`smali`目录，找到关键文件下的关键函数；在关键函数中找到关键跳转。

![ScreenShot2022-02-14 pm5.12.23](Android-Rev00/ScreenShot2022-02-14 pm5.12.23.png)

修改关键跳转，例如`if-eqz`修改为`if-nez`，重新打包签名安装，破解成功。

涉及到的一些命令记录如下，

```bash
java -jar Libs/apktool.jar d oldfile -o unzippedfile  #jar-->smali
java -jar Libs/apktool.jar b unzippedfile -o newfile  #重新打包
java -jar Libs/signapk.jar Libs/my.x509.pem Libs/my_private.pk8 newapk newapksigned #签名后才可安装
```

#### 3.1 证书生成命令

```sh
# 1.生成app.keystore
keytool -genkey -v -keystore app.keystore -alias ss_pku -storepass 123456 -keypass 123456 -keyalg RSA -validity 20000 -dname "CN='PaulC', OU='ss', O='pku', L='Beijing', ST='Beijing', C='zh'"
# 2.把keystore文件转换为pkcs12格式

  keytool   -importkeystore -srckeystore app.keystore   -destkeystore tmp.p12 -srcstoretype JKS         -deststoretype PKCS12 
# 3.dump为可读文本
openssl pkcs12 -in tmp.p12 -nodes -out temp.rsa.pem -password pass:123456
# 4.复制粘贴到
复制temp.rsa.pem中“BEGIN CERTIFICATE”  “END CERTIFICATE” 到 my.x509.pem
复制 “BEGIN RSA PRIVATE KEY”   “END RSA PRIVATE KEY” 到  private.rsa.pem
# 5.生成pk8文件
 openssl pkcs8 -topk8 -outform DER -in     private.rsa.pem -inform PEM -out my_private.pk8 -nocrypt

```

我用python的`os.system()`将这些命令写成了脚本方便使用：





> 反思：对于从服务器上分发的注册序列号的破解，还可以自建服务器或者修改返回包的信息破解。这需要我了解其加密手段，了解协议，感觉和医生还是比较相似的。
