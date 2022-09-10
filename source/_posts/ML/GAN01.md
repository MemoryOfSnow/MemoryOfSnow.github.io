---
title: GAN01
date: 2022-09-08 20:43:22
categories: 机器学习 #
tags: [DeepLearning]
mathjax: true
---

## 生成模型

输入Z和一个x，输出一个分布(dustribution)范围Y。让输出具有一点创造性。

例如语音聊天机器人，需要一个范围。

## Generative Adversarial Network(GAN)

以生成动漫头像为例。

Generator和Discriminator互相对抗。

Generator





Discriminator（一个NN，输出一个标量值(0~1)，值越接近1，表示生成的内容越有可能是一张动漫图片。

> 用来分辨Generator的输出与真正的图片有何不同。

### 算法：

1.G初始化参数，生成杂讯。

2.固定G，更新D；（经过训练，D学到真正的和生成的之间的差异：把真正的人脸当做1,把训练出的图片当做0；或者是回归问题)

3.固定D(鉴别器)，更新G(生成器生成在D中得分高的样本)

重复步骤2,3

## Progressive GAN可以产生人脸

Interpolation内插可以融合两张图片，做男女性别互转的照片。

## Divergence

散度 表征空间各点矢量场发散的强弱程度 