---
title: dump内存获取vpn密码
date: 2020-03-01 14:19:49
categories: CTF #try
tags: [逆向]
---


注：本期内容参考tianyi网络安全公众号



![1580899594410](..\..\..\exp\\imgs\\1580899594410.png)

对于*密码，dump内存获取其中内容。

## 本期工具

- procdump

- strings

- Win32Gru/Notepad++

## 步骤

1.获取EasyConnect进程的PID号

<!--more-->

```bash
C:\Users\Paul>tasklist|findstr "Client"
SangforCSClient.exe           3408 Console                    1     28,224 K
```

2.利用procdump将Client的内存镜像dump到磁盘

```bash
procdump64 -accepteula -ma 3408 f:\test\vpn
```

```bash
ProcDump v9.0 - Sysinternals process dump utility
Copyright (C) 2009-2017 Mark Russinovich and Andrew Richards
Sysinternals - www.sysinternals.com

[18:41:26] Dump 1 initiated: f:\test\vpn-1.dmp
[18:41:27] Dump 1 writing: Estimated dump file size is 138 MB.
[18:41:27] Dump 1 complete: 138 MB written in 0.6 seconds
[18:41:27] Dump count reached.
```

3.利用strings工具获取镜像里的字符串

```bash
strings vpn.dmp >strings.txt
```

4.利用notepad++搜索'PIN:'关键字找到密码位置

![1580899547470](..\..\..\exp\\imgs\\1580899547470.png)

对于最后两部，也可以使用grep工具，但是在win环境下grep并不是很给力，需要在Linux下使用；

```sh
strings vpn.dmp|grep -F 'PIN:' -A 6
```

