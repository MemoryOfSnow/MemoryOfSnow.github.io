---
title: Conflux-Notebook2
date: 2020-11-01 16:30:34
categories: 笔记 #
tags: [区块链]
---



Conflux三大好处：共识协议改进，**认证存储**和**交易中继协议**。

相比UTXO，Conflux使用account model并支持smart contract.

## 1.MPT

merkle patricia tree 

>  Conflux uses MPT作为合约的状态的认证存储的主结构。

Conflux中的智能合约：

- 执行更高效

接入存储（访问状态）的同时更有效的利用内存(delta tree)

## 2.对交易id的编码

有效利用带宽进行交易广播（transaction relay protocol）

Node（发现块的）广播交易id，让peer请求真正需要的交易。