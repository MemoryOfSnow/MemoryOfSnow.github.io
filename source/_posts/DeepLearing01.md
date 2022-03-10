---
title: DeepLearing01
date: 2022-02-07 20:43:22
categories: 机器学习 #
tags: [DeepLearning]
mathjax: true
---

# Logistic regression逻辑回归

二分类算法；

- image-->matrices-->feature vector-->{0,1}；

- many images-->X-->Y；

## 1.Notation


$$
training\ set:<x,y>,x∈R^{n_x},y∈\{0,1\};
\\
m\ trainging\ examples:(x^{<1>},y^{<1>}),(x^{<2>},y^{<2>}),...,(x^{<m>},y^{<m>})
\\
X=[x^{<1>},x^{<2>},...,x^{<m>}]
\\
Y=[y^{<1>},y^{<2>},...,y^{<m>}]
$$

```python
#m_train、m_test
X.shape
(nx,m)
#Label
Y.shape
(1,m)
```

## 2.激活函数

使模型可以拟合非线形函数。

 Sigmoid激活函数![image-20220208211747719](DeepLearing01/image-20220208211747719.png)

![sigmoid_demo](DeepLearing01/sigmoid_demo.png)

Relu激活函数



## 3.学习器

基于训练数据迭代的更新神经网络权重。

### 3.1 梯度下降过程

随机梯度下降保持单一的学习率更新所有的权重，学习率在训练过程中并不会改变。



### 3.2 Adam学习器

Adam 通过计算梯度的一阶矩估计和二阶矩估计而为不同的参数设计独立的自适应性学习率

> 学习率：



重训练

更新：
