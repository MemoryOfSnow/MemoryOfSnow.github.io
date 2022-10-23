---
title: 'ConvProtoNet: Deep Prototype Induction towards Better Class Representation for Few-Shot Malware Classification'
date: 2022-09-27 15:43:22
categories: 机器学习 #
tags: [FSL]
mathjax: true
---



> [下载链接](https://mdpi-res.com/d_attachment/applsci/applsci-10-02847/article_deploy/applsci-10-02847-v2.pdf#version=1587905118&usg=AOvVaw0hMY5VHNyAO9Ikmo2Ghf-M)，卷积原型网络：针对小样本恶意软件分类的更好的类表示的深度原型归纳,2020年

Zhijie, Tang & Wang, Peng & Wang, Junfeng. (2020). ConvProtoNet: Deep Prototype Induction towards Better Class Representation for Few-Shot Malware Classification. Applied Sciences. 10. 2847. 10.3390/app10082847. 

## 方法







## 模型架构

ConvProtoNet：基于度量(metric-based)的模型，使用了非参数的方法，**在嵌入层做了深层的原型归纳**，使得表达效果好，分布能匹配，避免了梯度消失，在分析时忽略无用特征。





<!-- more -->

## 实验



## 缺陷



## Abstract





## 讨论和分析

1.恶意软件具有特殊的视觉纹理：重用核心代码、携带恶意载荷、相同代码块的重复执行。

纹理区域比起其他区域：对于余弦相似度有高的响应灵敏度，也常和恶意特征相关。

优点：难度低、转化快、可解释性强、可由CNN直接处理。



2.ConvProtoNet将支持集上的卷积输出作为类原型，而不是特征注意（例如在Hybrid Attention-Based Prototypical Network，用ReLu，负数变0，分数向量稀疏，传播给嵌入层，造成梯度消失)，以防止梯度消失。

## 研究方向

- 提高Few-Shot的准确率到90%以上；Conv-4的嵌入层可以改用其他网络，如ResNet和残差注意力网络

- 分类增多时，模型性能下降如何缓解。
- 嵌入模块对于未知类也通用，当未知类包含的特征很少时，精度极剧下降。改进：使用自适应方法，如MAML