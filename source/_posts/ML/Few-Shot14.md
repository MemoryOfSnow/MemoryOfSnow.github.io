---
title: '关于MC，持续学习的局限性'
date: 2023-02-22 00:13:22
categories: 机器学习 #
tags: [持续学习]
mathjax: true
---

> M. S. Rahman, S. E. Coull和M. Wright, 《On the Limitations of Continual Learning for Malware Classification》. arXiv, 2022年8月13日. 见于: 2022年12月8日. [在线]. 载于: http://arxiv.org/abs/2208.06568

## 本文结论：

CL本应该适合于恶意软件每日的进化和数量级，但是本文实验数据说明持续学习在几乎所有场景下表现都不如数据的*Joint* 重放。选择性重放20%~50%的数据相比联合重放，可以在达到最佳训练效果的同时节省35-50%的时间。

**在域增量学习（二元分类任务里，融合数据分布的迁移，适应新域的同时，保留先前学到的知识）情景下，CL表现都很差。**

在任务增量学习时，几种CL方法表现相当好。

## 学到的

**多类别分类恶意软件时：可以基于其代码库、功能和整体结构特征。**

**读论文方法：**在对一个领域基本了解后，专注方法时，**直接去看Introduction里的作者贡献**即可。

克服灾难性遗忘(catastrophic forgetting)：

- 正则化：加入正则化损失函数，惩罚重要的权重变化
- 适应性扩张*adaptive expansion*
- 重放：用具有代表性的旧数据补充每个新任务的训练数据。
  - **蒸馏损失、**不遗忘学习. Learning without Forgetting 
  - **生成重放。用第二个模型去学习之前任务的数据分布，从分布中产生新数据重放。生成重放在旧数据不可用或受限时特别有用。**

用其他分析方法得到的辅助信息可以用来帮助恶意软件分类，如恶意软件种类、恶意行为、感染载体等，使得整个优化问题多了约束。

## 持续学习的训练策略

三组参数：任务间共享参数θ_s（除了分类层以外的层），先前任务参数θ_0（旧任务对应的权重和输出层），新任务参数θ_n（新任务的输出层）。

- Joint training:所有参数一起优化，基于所有数据的训练，得到的模型被认为是最好，但训练代价大。
- 持续学习训练：对于每个新任务n，固定θ_0，每次优化θ_s和θ_n。无须旧数据可及，因此难度高，只是训练更快，可以频繁重训练。



## 参数调优

层数、

隐藏单元数

激活函数

优化函数  Adam  SGD

学习率

## 评价策略

Min指标：最弱的性能显示了一种技术可能不适合使用的程度。

## 处理数据集中字符串的技巧：

用于大规模多任务学习的**特征哈希**

> Kilian Weinberger, Anirban Dasgupta, John Langford, Alex Smola, and Josh Attenberg. Feature hashing for large scale multitask learning. In *International Conference on Machine Learning (ICML)*, pp. 1113–1120, 2009. 



## 术语约定

持续学习：CL

恶意软件分类：MC

增量学习：incremental learning ，IL

AV-Test的 可能有害的程序 ：potentially unwanted applications，PUA

## 本文内容

11种CL技术\*2种恶意软件数据集\*MC的3种(任务、类别、域）的增量学习场景下；调研MC模型遭受灾难性遗忘(catastrophic forgetting)的程度。

恶意软件：PE、Android、PDF文件、恶意URL。

采用ML去解决MC，基于一个假设，模型可以泛化到新数据。但是恶意软件和良性软件都在更新升级，导致其软件内部不稳定。

为适应数据分布随时间的迁移，模型需要经常重训练。而数据产生的太快，**导致大的数据集**（FSL不存在这个问题），训练困难。

[VT的统计页面](https://www.virustotal.com/gui/stats)显示，每天接收到的新文件有近百万个。面对如此大 的数据，防病毒公司的三个选择

1）花费大代价在全体数据集上频繁的重训练

2）砍掉一些老数据，造成老病毒被复用的危险；

3）训练的不那么频繁。

4）**增量学习**

## 

## 计算机视觉领域数据集： 

MNIST, CIFAR10 and CIFAR100, and ImageNet













