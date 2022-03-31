---
title: V2ray搭建流程
date: 2020-03-17 14:19:49
categories: CTF #try
tags: [Web]
---

```sh
ssh -t root@149.28.228.xxx
// 安裝執行檔和 .dat 資料檔
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)
```





```sh
wget https://github.com/v2fly/v2ray-examples/blob/master/VMess-TCP/config_server.json
cp -rf config_server.json /usr/local/etc/v2ray/config.json
vim /usr/local/etc/v2ray/config.json

```

输入以下信息：





```sh
 service v2ray status
 systemctl enable v2ray
 systemctl start v2ray
```





更新dat和geoip

```
// 只更新 .dat 資料檔
# bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh)
```

