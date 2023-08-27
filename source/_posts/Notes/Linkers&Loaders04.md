---
title: Chap12-系统调用
date: 2023-08-27 14:58:58
categories: 笔记 #
tags: [Linker&Loader]
---

> /usr/include/unistd.h  一些系统调用的C语言形式定义
>
> /usr/include/asm-*/unistd*.h 存放系统调用号
>
> linux-5.6.18\arch\x86\kernel\traps.c x86的部分中断向量表

绕过glibc获得更高的文件读写性能。

为了兼容不同系统的系统调用（定义、实现会各不相同），增加一个抽象层——运行库（标准库），保证了源码级别的可移植性  。

CRT只能取各个平台功能的交集。



```asm
mov 2,eax ;把fork的系统调用号传到寄存器
int 0x80 ;调用中断
;中断服务程序从eax里取得系统调用号，
;查表，eax=2
;调用sys_fork函数
```

### 1.触发中断

x86下Linux支持的系统调用参数最多可以达到6个，分别用EBX、ECX、EDX、ESI、EDI、EBP存储。

### 2.堆栈切换

用户态的ESP和SS的值保存在内核栈里。

当0x80号中断nt 发生时，

1.CPU切入内核态

2.CPU找到当前进程的内核栈

3.在内核栈中依次压入用户态的SS、ESP、EFLAGS、CS（环境）、EIP（返回地址）。

> 当iret时，再依次弹出这些值到对应的寄存器里。

### 3.中断处理程序

```
INT x:

根据x的值

if x=00:  除0

if x=0x14: 缺页

if x=0x02 :硬件驱动

if x=0x80: system_call

{

​	eax=1 =>sys_exit

​	eax=2 =>sys_fork

​	eax=3 =>sys_read

}
```

