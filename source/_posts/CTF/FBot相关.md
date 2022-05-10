---
title: Fbot
date: 2020-02-01 14:19:49
categories: CTF
tags: [Web]
---

ADB.Miner会感染Amazon FireTV （使用FireOS 7，一个安卓分支)操作系统，利用adb安卓调试接口传播，并挖矿。



投入载荷会下载执行 hxxp://188.209.52.142/c，或者是hxxp://188.209.52.142/w。这两个脚本的区别仅在下载方式是wget/curl，下文不再区分。两个脚本的主体功能一致，包括：

- 尝试进一步从 188.209.52.142 下载 fbot.{arch} 恶意样本；
- 卸载 com.ufo.miner，一个类似ADB.Miner的挖矿组件；
- 完成自身清理工作。

下载得到的 fbot.{arch} 是个mirai的变种，主要特点包括：

- C2：musl.lib:7000，当前在EmerDNS上的解析地址为 66.42.57.45，Singapore/SG Singapore
- 扫描和传播：针对 TCP 5555 adb 端口扫描。扫描成功后，会下载hxxp://188.209.52.142/c，完成对蠕虫自身的传播。
- 进程清理：样本中会遍历 /proc/pid/exe 目录下面的特定进程，如smi、xig、rig等。枚举得到符合条件的进程后，会杀掉该进程。

#### 主控域名 musl.lib 在EmereDNS上的解析

Fbot蠕虫作者选择了OpenNic公司的公共DNS服务。蠕虫中硬编码了一组OpenNic公共服务器IP地址，被感染的机器通过向这些服务器请求，得到 musl.lib 的EmerDNS解析IP。

扫描器的版本有：

```
hxxp://188.209.52.142/fbot.aarch64     #扫描器，下同，完成自身的蠕虫传播
hxxp://188.209.52.142/fbot.arm7
hxxp://188.209.52.142/fbot.mips
hxxp://188.209.52.142/fbot.mipsel
hxxp://188.209.52.142/fbot.x86
hxxp://188.209.52.142/fbot.x86_64
```

