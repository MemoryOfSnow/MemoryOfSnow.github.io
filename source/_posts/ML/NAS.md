---
title: NAS
date: 2022-03-07 20:43:22
categories: 机器学习 #
tags: [NAS]
---
## 神经网络结构搜索

> [厦大-纪荣嵘教授](https://www.bilibili.com/video/BV18Y4y1r7tb)

![image-20220510201253099](NAS/image-20220510201253099.png)

### 主要流程

![image-20220510201331612](NAS/image-20220510201331612.png)

1.基于细胞的：

谷歌2018年的策略，把公共结构做成cell，借助这些cell组合出需要的模型。

Zoph, Barret, et al. "Learning transferable architectures for scalable image recognition."Proceedings of the IEEE conference on computer vision and pattern recognition.2018.

2。基于链式的：

![image-20220510202140341](NAS/image-20220510202140341.png)

![image-20220510202439208](NAS/image-20220510202439208.png)





---

全局视角：

![image-20220510202643036](NAS/image-20220510202643036.png)

![image-20220510203014458](NAS/image-20220510203014458.png)

![image-20220510203153112](NAS/image-20220510203153112.png)

## NAS的进化计算

从种群出发，然后一定概率进行变异，杂交，交给环境，利用环境去做出选择，然后再进行迭代。

![image-20220510204255094](NAS/image-20220510204255094.png)

Genetic CNN

搜索策略:进化算法，将网络结构编码为01序列的基因，通过俄罗斯转盘选择、复制、交叉、变异产生后代.





当搜索变深时，内存开销增大，要裁剪掉大量操作。