---
title: Optimizer
date: 2019-03-11 15:05:45
categories: 机器学习 #
tags: [Pytorch]
---

- SGD(stochastic gradient descent)  随机梯度下降
- SGD with momentum
- Adagrad
- RMSProp
- Adam

## Notation

参数： θ_t，_

梯度： ∇ L(θ_t)，_

动量：m_{t+1}

## Problem Simplication

Off-line Learning





Generalization  ，即SGDM收敛性一般优于Adam，而Adam训练起来比较快。可以设置Learning rate range，即upbound和lower bound，设置好stepsize，动态一大一小地设置学习率。