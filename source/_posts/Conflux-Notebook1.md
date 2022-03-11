---
title: Conflux-Notebook1
date: 2020-10-31 14:49:34
categories: 区块链 #
tags: [Conflux]

---

## 1.Conflux简介

> 论文发表时间：2018.8.31,下载链接
>
> [Scaling Nakamoto Consensus to Thousands of Transactions per Second](https://arxiv.org/pdf/1805.03870)  
>
> 姚期智等教授设计的一个区块链系统，修改了共识协议，用DAG取代了chain，普适的激励机制并未涉及。

<!--more-->

### 1.1优势

可证明安全基础上的快

创造块block generation

确认块 confirmation

交易量处理能力 throughput

### 1.2.策略

Nakamoto的策略：预设交易的总顺序，导致其错误依赖和不确定分支；

Conflux推迟交易总排序，积极处理并发地交易和块，所以**快**。

### 1.3.Conflux保证合作安全的两个措施

1.新节点与父节点的边，形成账本的持续不可逆共识（直觉上的投票关系）。

2.新节点与没有入度的节点做一个reference edge，表明生成先后。



**DAG取代chain.**

> 块顺序不可逆的前提假设：与Bitcoin一致，诚实节点控制更多的能源或者算力。

### 1.4.Conflux的节点排序

（conflux实际是一个修改过的基于链的Nakamoto共识)

- 从创世节点开始的中心轴上的Block是一个epoch，对于每个epoch的block，拓扑排序topological sorts。

- 对于各个epoch，用happens-before顺序。
- 最后连起来concatenate



## 2.Conflux协议具体介绍

> 1.架构：在交易池打包交易成块，更新本地DAG（每个矿机存储在本地的），并广播该块。

2.冲突或重复的交易，只处理第一个而抛弃其余的。

3.协议构成

![](20201031185208.png)  

>  **1.3**的两个关系反映在DAG上就是两种边。

```python
'''
parent edge		<b,P(b)>
和
reference edge	<b,b'>。
'''

```



除了两个边，还有一个*主链* (pivot chain），基于**GHOST rule**生成。

>  pivot chain：从Genesis开始，计算亲代树中每个孩子节点的子树大小，并前进到具有最大子树的子块，直到到达叶(tip block)。

**注：主链并不是最长链，而是子树大小最大的节点构成的链。**根据主链上的块，划分epoch，一个epoch内的块总是可以由该epoch主链上的块**到达**。

生成新块的ref edge时，没有入度的tip block不包括那些以ref edge为入度的节点，比如New Block没有连接到G上。

### 2.2 交易确认

transaction在block里，block在epoch里。  

愿意忍受多大的风险（即敌人算力达到什么程度）~主链块被修改概率-->judge accept or refuse.



## 3.Conflux共识算法

- <B,g,P,E>，分别指块、源点、父节点映射函数、边。
- hash函数，给每个块一个唯一的id.

### 3.1 工具函数

```python
#通用函数
def Chain(G，b):
    if b==g:
   		return g
    else:
        return Chain(G,P(b))
    
def Child()
def Sibling()
def Subtree()
def Before(G,b)#有边连接的b之前所有的块
def Past(G,b)#包括b本身，b之前所有的块
def TotalOrder(G)=ConfluxOrder(G,pivot(G,b))
```

### 3.2 主链选择函数

- 该算法递归地前进到其**子树块数最多的**子块；
- 终止条件为到达leaf block.
- 若子块的子树块数一致，再选取id较小的。

```python
#returns the last block in the pivot chain starting from the genesis block g
def Pivot(G,g)

```

### 3.3 共识主循环

- 收到DAG update info（**块里要有签名**），节点更新自身和转播；

- 制造了新块，更新Pivot的值，更新B、E，和P，广播；
  - 广播整张图
  - **广播块，避免多余的流量消耗。**

共识算法：**Greedy-Heaviest-Adaptive-SubTree** (GHAST),



### 3.4 攻击者建模

1.攻击者不能攻击完整性校验函数；

2.攻击者算力不如所有诚实者。

3.攻击者有能力在**一段时间内**隐瞒一个自己发现的块，但是一旦他公开这个块给某个人，根据d-synchronus假设，所有人在**一定时间**后都会知道。

### 区块链常识

***共识机制是为了解决延迟和恶意攻击者的存在造成的块冗余和。***

块产生速率的稳定与问题困难性有关。



## 论文以外的东西

读专业的英语论文，section7大可不必复读，第一章速读；第234细读，有时间品附录部分。



## 未来查的一些东西

- 拜占庭共识Byzantine agreement