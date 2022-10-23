---
title: 'Attack Robustness and Centrality of Complex Networks'
date: 2022-10-21 15:43:22
categories: 笔记 #
tags: [ComplexNotebook]
mathjax: true
---

>Iyer, Swami & Killingback, Timothy & Sundaram, Bala & Wang, Zhen. (2013). Attack Robustness and Centrality of Complex Networks. PloS one. 8. e59613. 10.1371/journal.pone.0059613. 

组件失败时系统的稳定性——依赖于底层网络的稳定性——顶点移除时网络结构的改变

- betweenness centrality.
- 基于度分布、聚集系数、组合系数去衡量复杂网络的鲁棒性

研究基于度、中间度、接近度和特征向量中心性的`去除方案`对各种模型网络的影响，包括幂律和指数分布、不同聚类系数和不同分类程度的模型网络

## 网络渗流和稳定性

渗透：取一个网络并去除其顶点的某些部分（以及连接到顶点的边）的过程。

对于疫苗接种或者节点失效来说，虽然它物理上还存在，但从功能视图上看一些节点被移除了。

**若渗流后的最大组件（相对于原始网络规模）在规模上变得太小，系统不可正常工作。**



系统稳定性衡量函数为移除节点的函数：

![1666345435871](ComplexNetWork/1666345435871.png)



