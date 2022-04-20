---
title: 安卓逆向分析技术
date: 2022-02-10 11:00:12
categories: CTF #
tags: [Android,逆向]
---

## 训练算法

针对子视图分别生成分类器。同时基于Co-training协同训练算法





## 动态特征提取方案、

基于Zygote注入技术的动态API调用视图的特征提取

编写基于uiautomator框架的用户UI行为模拟程序

基于Xposed框架Hook目标程序的部分安全敏感API





## u附录

> [Android世界之盘古女娲——Zygote](https://blog.csdn.net/chz429/article/details/87514718)

Android系统(Linux)-->**init进程** --fork-->**zygite进程**-->创建Java虚拟机-->

注册JNI调用-->调用Java层的ZygoteInit类的main函数，进入Java世界-->

**Java层的ZygoteInit**进行如下四步工作：

1.建立一个Socket服务端，监听客户端的连接，用于IPC通信。

2.预加载类和资源（安卓系统启动慢的缘故；加载framework-res.apk中的资源）

3.通过fork的方式，启动**system_server进程**（system_server是和zygote共存亡的，只要system_server被杀死，zygote也会把自己杀掉，这就导致了系统的重启。）

4.通过调用runSelectLoopMode（）方法，进入无限循环，等待客户端的连接请求，并处理请求。（进行必要的native初始化后，主要逻辑都是在Java层完成）

[Java native关键字](https://blog.csdn.net/funneies/article/details/8949660)，JNI允许Java代码使用以其他语言编写的代码和代码库。

在Android系统中，zygote（受精卵）是一个native进程，是Android系统上所有应用进程的父进程，我们系统上app的进程都是由这个zygote分裂出来的。zygote则是由Linux系统用户空间的第一个进程——init进程，通过fork的方式创建的。
**原生应用**是为了在特定设备及其操作系统上使用而构建的，因此它可以使用设备特定的硬件和软件。与开发为跨多个系统通用的网络应用程序相比，原生应用APP程序可以提供优化的性能。