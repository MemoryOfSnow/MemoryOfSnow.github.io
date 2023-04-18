---
title: 'Meta-Dataset: A Dataset of Datasets for Learning to Learn from Few Examples'
date: 2023-03-22 00:13:22
categories: 机器学习 #
tags: [FSL,持续学习]
mathjax: true
---

提供了一个Tensorflow实现的 新的基准数据集的训练和测试代码 。
>这篇论文和之前读过的Few-Shot13:《Learning a Universal Template for Few-shot Dataset Generalization》，
>以及《CrossTransformers: spatially-aware few-shot transfer》的代码都是同一批作者的研究，
>
>[Meta-Dataset-Code05](https://github.com/google-research/meta-dataset)



《Self-Support Few-Shot Semantic Segmentation》，用自支持匹配获得更好的特征原型。[Self-Support-Code06](https://github.com/fanq15/SSP)



## 度量学习

(PN、MN、RN、CrossTransformerLearner），

## 优化学习

1.proto_maml_fc

2.BaselineFinetune

3.proto

最差的：关系网络。

（、maml、almost-no-inner-loop、GenerativeClassifier），

FLUTEFiLM

## 10个数据集

![1680521958453](Few-Shot16/1680521958453.png)



## 一些推荐参数

- inner learning rate α=0.1

## 可继续研究的新问题

训练episode、校验、初始化的最优策略未明；

在多个来源的数据