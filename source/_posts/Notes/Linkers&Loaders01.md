---
title: PE/COFF
date: 2023-05-12 14:58:58
categories: 笔记 #
tags: [PE]
---



> 俞甲子等，《程序员的自我修养——链接、装载与库》，北京：电子工业出版社，2009年6月第2版。

## 1.5 程序的分段和分页

解决三个问题：1.内存隔离。2.空间利用。3.重定位。

本质上是增加了一个中间层，即虚存，这样就可以避免在编写程序时还要考虑详细的地址分配问题了。为了内存隔离，分段；为了细粒度的空间利用，分页。

CPU->虚拟地址-->MMU(Memory Management Unit，内存管理单元)—>物理地址。

## 2.1 构建过程

预编译：.cpp/.cxx.,.hpp——>.i,.ii，处理所有的"#"预编译命令并递归插入和展开宏命令，删除注释，加入行号和文件名标识，保留#pragma编译器指令。

编译：gcc -S/cc1 hello.c -o hello.s。完成词法分析和语法分析，生成中间代码。

```
#include <...> search starts here:
/usr/lib/gcc/x86_64-linux-gnu/11/include
/usr/local/include
/usr/include/x86_64-linux-gnu
/usr/include
```



汇编：gcc -c /as hello.s -o hello.o。把汇编符号翻译为机器码。

链接：ld，最终确定各个符号的绝对地址，完成对指令引用的符号地址的校正，需要一大堆文件。

### 

## 2.2 编译原理概述

词法分析，Scanner-->Tokens，识别记号，同时叫标识符放到符号表(lex)。

语法分析，Parser-->Syntax tree，关于编译器的编译器(yacc)。

语义分析：Semantic Analyzer-->Commented Syntax Tree（注释语法树），只能分析静态语义：声明、类型匹配转换（在编译器可以确定的语义，其他的等待程序运行（除0异常）时才能确定）

中间代码生成：使得编译器可以拆分为前后端。非常接近目标代码，但是跟目标机器与运行时环境无关。不包含数据尺寸、地址和寄存器名字。

目标代码生成与优化：生成器和优化器。

```
LEA,基址比例变址寻址（Load Effective Address），进行地址的计算后将算得的结果放入存储中，不会把结果地址的内存数据实际加载到寄存器里。用于高效地进行一些复杂的地址计算，例如数组索引、数据结构访问等，而无需实际读写内存
```



## 2.3 链接器年龄比编译器更长

纸带编程时，一些跳转都是绝对地址，需要人为计算，一旦指令间增删其他指令，所有目标地址都要重新人工计算**（重定位，Relocation，每个要被修正的地方叫一个重定位入口，Relocation Entry)**，一条纸带上的指令很麻烦，多条纸带间更是灾难。

引入符号（对函数和变量位置的助记符），计算符号地址的过程让汇编器自动完成，方便程序的模块化。

程序之间的接口就是这些符号，类似于拼图，我少这一部分，你恰好多这一部分，每个模块放到合适的位置，就是一幅完整的有意义的图。

## 2.4 静态链接是什么玩意？

详细介绍在第4章。

链接过程包括：地址和空间分配、Symbol Resolution（符号决议：静态链接，绑定：动态链接）和重定位。

**库：**常用的代码编译成目标文件存放，例如运行时库。

## 5.2一些历史

DEC（Degital Equipment Corp.)被 康柏电脑 收购， 康柏电脑02年又被惠普（1939）收购。DEC推出的VAX/VMS（Virtual Address eXtension/System） ，是一个最先使用权限管理和容错机制的多任务OS， 提供高性能、可靠性和安全性 。微软开发Win NT时，最初成员来自于DEC的VAX/VMS小组，所以Windows的PE格式来自于DEC的VAX/VMS上的COFF（Common Object File Format）文件格式。

 贝尔实验室 （Bell Telephone Laboratories， 1925 ）  —>  肖克利半导体实验室（Shockley Semiconductor Laboratory，1955） —> 仙童半导体（Fairchild Semiconductor，1957）  —>AMD(1968)，Intel(1968) —>Microsoft（操作系统，1975）。

 SGI（Silicon Graphics, Inc.，1982） —>NVIDA（正在收购ARM（移动处理器），1993）， Netscape  （1994年，开源了 Netscape Navigator（打不过微软IE） ，发展成为 Mozilla Firefox 。

Google （创建者为Stanford University博士，PageRank算法： Google搜索引擎的核心， 通过链接关系评估网页的重要性  ， 1998 ）

**思路：**链接多的代码块，也可以权重传递和赋予它高的权重值。

- COFF:VC++产生的目标文件格式。

- PE：Win平台下的可执行文件格式，和ELF都是基于段的相同结构， 是COFF的一种扩展。对于64位系统，将PE中的32位字段改为64字段，叫做PE32+。

- 映像文件Image File：因为PE文件在装载时会被映射到进程的虚拟空间中运行，它是进程虚拟空间的映像，所以PE可执行文件又可称为映像文件。

  

### SMP与多核

服务器要的是 并发吞吐 ，要CPU核数、要线程数、要大的L2/L3缓存。

而PC要的是单核频率。

截至2023年5月12日，至强的处理器基准频率基本在4GHz以下， 酷睿i9-13900KS 睿频最高为6GHz（受生产工艺影响）。出于性能需求发展出多处理器，SMP（symmetrical）是其中的常见形式，由于成本高，通过共用缓存，SMP发展成为多核处理器。

### 段名

段名**只具有提示作用**，没有实际意义。不同编译器产生的段名不同，VC++用'.code'和'.data'。

使用链接脚本来控制link时，段名含义一般是固定的。

## 自定义段

```c++
//GCC，扩展属性，将变量或者函数放入自定义段中
__atribute__((section("name")))
//要放入name段的全局变量或者函数
    
    
//VC++中，编译指示：把全局变量放到FOO段里
#pragma data_seg("FOO")
int global =1;
//把编译器指示换回来，此时开始，全局变量和局部变量恢复到放入.data中
#pragama data_seg(".data")
```

使用VS Command Prompt，编译：

```sh
#编译，不调用链接器，禁用Microsoft C/C++语法扩展，生成标准的C/C++目标文件
cl /c /Za SimpleSection.c
```

[Microsoft C/C++语法扩展](https://learn.microsoft.com/en-us/cpp/build/reference/microsoft-extensions-to-c-and-cpp?view=msvc-170)，编译器会自动定义`__STDC__`这个宏。

利用VS目标文件查看工具查看COFF格式或PE格式，详细/简介。

```
dumpbin  [/all,summary] hw2.obj >hw2_section.txt
```



 C runtime library (UCRT) 







[微软的PE文件格式定义](https://learn.microsoft.com/en-us/windows/win32/debug/pe-format)






