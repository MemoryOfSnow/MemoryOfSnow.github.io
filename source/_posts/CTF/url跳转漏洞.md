---
title: 常见的Bypass
date: 2020-02-01 14:19:49
categories: CTF
tags: [Web]
---
## Bypass

### 1.特殊字符的绕过

@，#，/，?，\,\\\\\,//绕过。
base64加码，URL编码绕过

### 2.白名单绕过

白名单的：找到类似的域名，或者采用多级跳转。

### 3.xip.io后缀绕过

<!--more-->

### 4.脚本或者xss跳转

```js
<script language="javascript">
    window.location="http://www.baidu.com"
</script>
```

```html
<meta http-equiv="refresh" content="3; url=scary.html">
<meta name="xxxx" content="1;url=http://www.baidu.com" http-equiv="refresh">
```




## 漏洞存在情形

登陆完成后跳转

用户交互

充值接口

问卷等