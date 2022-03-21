---
title: Android_Rev01
date: 2022-02-10 11:00:12
categories: CTF #
tags: [Android,逆向]
---

## App的特征

> 根据drebin数据集中的样本特征出现次数占比升序排列如下

- 硬件组件
- 可疑API调用
- 网络地址
- 已使用权限
- 受限API调用
- 请求权限
- 过滤意图
- 应用组件

```
 u'broadcastreceiverlist_com.google.ads.conversiontracking.installreceiver',
 u'contentproviderlist_kr.co.smartstudy.sspatcher.ssinterprocessdataprovider$sscontentproviderimpl',
 u'requestedpermissionlist_android.permission.change_network_state',
 u'broadcastreceiverlist_.contact.service.synchronizationtask',
 u'activitylist_com.cmm.worldartapk.activity.searchactivity',
 u'requestedpermissionlist_com.google.android.providers.gsf.permission.read_gservices',
 u'activitylist_.wxapi.wxentryactivity',
 u'intentfilterlist_com.aio.apphypnotist.update_widget',
```

