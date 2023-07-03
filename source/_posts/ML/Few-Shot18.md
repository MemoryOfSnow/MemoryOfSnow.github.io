---
title: 'GAN在小样本学习中的应用'
date: 2023-06-14 16:13:22
categories: 机器学习 #
tags: [FSL]
mathjax: true
---

>  Zhang R, Che T, Ghahramani Z, et al. Metagan: An adversarial approach to few-shot learning[J]. Advances in neural information processing systems, 2018, 31. [pdf](http://papers.neurips.cc/paper/7504-metagan-an-adversarial-approach-to-few-shot-learning.pdf)

## 基础知识

1、小样本情况下，人利用经验和先前的知识学习任务，而传统机器学习不使用先前知识容易过拟合。

2.元学习是一种利用先前知识的技术，从相似任务分布上训练提取一种可迁移的模式。

3.半监督小样本学习：有标签的样本是很少，但是无标签的样本也可以获取的到。





## 问题挑战

半监督小样本分类的元学习

难以从小样本里获得可泛化的决策边界。



## 解决办法

**核心思路：**假样本可以帮助小样本分类器学到更陡峭的边界。真假决策边界是如何帮助小样本分类的？？？

## 思路来源

小样本学习很像半监督学习。修改GAN在半监督学习领域的应用，将其应用到小样本场景下。

1.两者都没有足够数量的有标签样本。

2.都能从不完美的生成器获益。



## 创新点

对RN和MAML，叠加MetaGAN，让准确率，上升2到3个百分点。



## 实验

### 1.数据集

Omniglot Mini-Imagenet

### 2.实验内容

在2个数据集上，做3类任务，实验设置有**5-way 1-shot**,5-way 5-shot，20-way 1-shot，20-way 5-shot。加粗部分在3类任务上都有做。

#### 2.1 监督小样本学习



#### 2.2样本级的半监督小样本学习

允许在任务中有一些未标记的训练样本，来自与标签相同类或者干扰类（是二者择一，还是都选？？？）。

#### 2.3任务级的半监督小样本学习

更允许无监督学习，即在support Set里和Query Set里都不加标签。

## 未来研究方向