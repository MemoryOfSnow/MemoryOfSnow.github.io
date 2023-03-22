---
title: 给样本贴标签的办法
date: 2022-12-24 14:12:58
categories: 机器学习 #
tags: [Data]
---

## AVCLASS

三大挑战：规范化（相对于使用AV提供的完整标签而言），通用标记删除，别名检测

采取AV vendors多数投票，需要选择出一些打标签比较好的检测引擎，而检测引擎往往对于某一类准确率高，而对于另一类又比较差；也无法定量评估标签的质量。

已知某些引擎会抄袭leader引擎的标签结果。

AVCLASS可以代替聚类过程和给聚类结果打标签。

## AVCLASS2

2020

> Silvia Sebastián, Juan Caballero. AVClass2: Massive Malware Tag Extraction from AV Labels. In proceedings of the Annual Computer Security Applications Conference, December 2020. 

AVLASS2借助VT的json可以获得下面的结果：

```
aca2d12934935b070df8f50e06a20539 33 CLASS:grayware|10,CLASS:grayware:adware|9,FILE:os:windows|8,FAM:adrotator|8,CLASS:downloader|3,FAM:zlob|2
```



