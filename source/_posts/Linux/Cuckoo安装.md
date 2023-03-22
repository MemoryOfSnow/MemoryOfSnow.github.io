---
title: Ubuntu22虚拟机安装Cuckoo
date: 2022-06-11 19:59:30
categories: Linux 
tags: [Cuckoo]
---



## 安装Cuckoo







### m2crypto

```
ln -s /usr/include/x86_64-linux-gnu/openssl/opensslconf.h /usr/include/openssl/opensslconf.h
pip install --global-option=build_ext --global-option="-I/usr/include/x86_64-linux-gnu" m2crypto
```

## 2.安装Py36支持的组件

### Volatility



## 3.可选项安装



```
apt install libfuzzy-dev
```



### guacd

```
apt install libguac-client-rdp0 libguac-client-vnc0 libguac-client-ssh0 guacd
```

## 4.安装Cuckoo

```
apt-get install libx11-dev
#apt-file search Intrinsic.h apt-file可以根据缺少的文件找对应需要安装的库
pip install -U cuckoo
```

