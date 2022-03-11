---
title: Conflux-Notebook4
date: 2020-11-17 15:20:38
categories: 区块链 #
tags: [Conflux]
---

> 本文参考文件为：[Conflux白皮书](https://confluxnetwork.org/files/Conflux_Protocol_Specification_20201020.pdf)，试图解决blockID的计算，并了解Conflux具体结构和数据。

## 0. Value


$$
1CFX=10^{18}Drip,  
1uCFX=10^{12}Drip,
1GCFX=10^{9}Drip,
$$


## 1.Accounts and States

Account=(αaddr,αstate)；**α**addr=4+公钥哈希值的大端排序的低位156位。

**α**state = (**α**basic,**α**code,**α**storage,**α**deposit,**α**vote)

**α**basic ≡ (**α**n,**α**b,**α**c,**α**t,**α**o,**α**r,**α**a,**α**p)，8个分量

对于**α**n，这里的nonce指有这个账户发起的活动数的计数器。

### 1.2 RLP structure

<!--more-->

对三种类型的数据的编码，最终都转化为对字节数组的编码；

> 参考[以太坊黄页](https://ethereum.github.io/yellowpaper/paper.pdf)附录B

**Recursive Length Prefix，递归长度前缀**，这是一个序列化函数，将任意长数据加密为结构化的二进制数据。

![image-20201117142602221](image-20201117142602221.png)

B指Byte Array，L指序列列表

![image-20201117140248528](image-20201117140248528.png)

第一个结果的第一个字节总是小于192，而第二个总是大于192。



![image-20201117141429974](image-20201117141429974.png)

第二行，输出结果=（字节数组长度+128）表示为一个BYTE，作为输入数据的前缀。

BE将非负整数值扩展到最小长度的**大端**字节数组；由于是字节数组，所以这里的底数是256=2的8次。

**不能对包含2的64次或更多字节的字节数组进行编码。此限制确保编码的第一个字节字节数组的值总是小于192（183+64/8=191），因此可以很容易地将其与L中的序列编码区分开来。**

![image-20201117143127342](image-20201117143127342.png)

![image-20201117143327927](image-20201117143327927.png)

## 2.Hash Digest of World-State

五种状态的6个条目

```python
(k,v)
'''
Basic entry	:特别的，对于非合约地址，不包括codeHash αc,contract admin αa和sponsorInfo αp。
因此，αbasic_smp ≡ (αn,αb,αt,αo,αr)五个分量，此时TYpe(α)=[1000]2
其他时候，k=αaddr连接一个[data]ch；
		v=RLP(αitem)

'''
```

### 2.2 多版本MP Trie

T0，T1,T2，分别表示快照、中间集合和变化集合。后者是前者的缓存。在交易执行时，只有T2更新，

每10W个epoch，T1合并到T0上，T1被赋值成T0，T0取空集。

![image-20201117153644066](image-20201117153644066.png)

MPTMerge函数更新T0中那些在T1中值不再相同的条目。对于初始值的条目，T0会移除它们。

**epoch i的执行实际意味着epoch(i-5)中的交易被执行。**

**epoch i的状态根并不在epoch i的pivot block中。**



## 3. Transacitions

- to an account address：转移价值 ，导致message call，至少发生其中一个事件。
- to “nowhere”:创建新合约

![交易T的解析函数](20201117121959.png)

交易T由12项构成，其中共用11个域。（>167bytes)

```python
'''
nonce：等于先前发送的交易数，N256
GasPrice：汽油费单价，N256
gasLimit：汽油费限额，N256
action：Ta ∈ B160的地址 ∪B0的新合约。
value：转移给接受者的Drip的数额，N256
storageLimit：用于执行T的最大存储字节，N64
epochHeight：T能执行的epoch的范围，N64，此数值加减10000向下取整是交易可执行的纪元。
chainID：表明交易是否要执行，在Conflux中，Tc = 2，N32。
v,r,s:与可恢复的ECDSA签名相关的三个域
data:对已存在合约的消息调用的输入数据；init:明确初始化过程执行的EVM code，与action对应。任意长字节数组
'''      
```

### 3.2 可恢复的ECDSA签名











## 4.Blocks

B=H+ a list of Ts，H可划分为16项；

![](20201117125612.png)

```python
这16项大小一定>336bytes
'''
ParentHash:KEC256(H（P(B)))
height:达到创世块的父代参考的数量，N64
timestamp：出现两次，Unix时间戳，N64
author：the miner's address,B160
transactionRoot：交易MPT结构的根节点的哈希值，KEC256
deferredStateRoot:stable transaction（pivot chain上5步以前的块中的交易）执行和最终确认后的状态（状态MPT树的不被责备的根节点）的hash，KEC256
deferredReceiptsRoot：blame域为0时，交易收据构成的trie结构的根节点的KEC256。
• deferredLogsBloomHash：由交易收据组成的布隆过滤器的KEC256
blame：标量，N32，这个域检查祖先的四个域来决定是否blame ancestor。与奖励分发有关
difficulty:由前面的块的困难性和当前的时间戳共同决定。N256
adaptiveWeight:布尔值，是权重调整的激发器。
gasLimit：当前每个块的gas支出上限，3000W起步。N256
refereeHash：对于各个参考块的KEC256构成的参考列表的RLP序列化后的结果。

**customData：任意长的字节字符串的列表**

nonce:B256，工作量证明。
'''
```

### 4.1 交易收据 

Transaction Receipt,9个域的元组	

![image-20201117180044232](image-20201117180044232.png)





#### 4.1.2 Bloom fifilter

**针对问题：如何查看一个东西是否在有大量数据的池子里面**

Bloom fifilter，二进制向量数据结构，被用来检测一个元素是不是集合中的一个成员。

如果检测结果为是，该元素不一定在集合中；但如果检测结果为否，该元素一定不在集合中。因此Bloom filter具有100%的召回率。这样每个检测请求返回有“在集合内（可能错误）”和“不在集合内（绝对不在集合内）”两种情况，可见 Bloom filter 是牺牲了正确率和时间以节省空间。

##### 计算方法

参考[简书博客](https://www.jianshu.com/p/88c6ac4b38c8)

![image-20201117181102693](image-20201117181102693.png)

图来自于上面的参考博客

以上图为例，具体的操作流程：假设集合里面有3个元素{x, y, z}，哈希函数的个数为3。首先将位数组进行初始化，将里面每个位都设置位0。对于集合里面的每一个元素，将元素依次通过3个哈希函数进行映射，每次映射都会产生一个哈希值，这个值对应位数组上面的一个点，然后将位数组对应的位置标记为1。查询W元素是否存在集合中的时候，同样的方法将W通过哈希映射到位数组上的3个点。如果3个点的其中有一个点不为1，则可以判断该元素一定不存在集合中。反之，如果3个点都为1，则该元素可能存在集合中。注意：此处不能判断该元素是否一定存在集合中，可能存在一定的误判率。可以从图中可以看到：假设某个元素通过映射对应下标为4，5，6这3个点。虽然这3个点都为1，但是很明显这3个点是不同元素经过哈希得到的位置，因此这种情况说明元素虽然不在集合中，也可能对应的都是1，这是误判率存在的原因。





> 插入和查询时间都是常数,当插入的元素越多，错判“在集合内”的概率就越大了，另外 Bloom filter 也不能删除一个元素

### 4.2 校验Block的Header的8条件

•Height增加一；
•timestamp增加；
•规范的gas limit变化不大（不大于1/1024），并且保持在10的7次方以上； 

•the target diffificulty设置正确

 •工作量证明超出目标难度；
•根据GHAST规则从B的过去视图中正确选择了父亲；
•基于PAST（B），根据GHAST规则正确设置自适应权重标志adaptiveWeight； 

•参考列表RefereeHash正确分解为块头

![image-20201117210133252](image-20201117210133252.png)

其中，well-formed指：

![image-20201117210115681](image-20201117210115681.png)

H是否有效只与块总顺序共识的建立有关，不依赖**deferredStateRoot**, **deferredReceiptsRoot**, **deferredLogsBloomHash** and **blame**.这四个域错误时，**这个块对共识的贡献仍被计算在内**？？？？，但是作者没有reward，因为他没有合适地维护好状态和执行交易。

## &&部分无效的块的贡献

1.什么叫做部分有/无效的块？

#### 4.3 违反GHAST的块的三种部分无效情形

- H(B)*p*不正确；

- H(B)*w* ；

- H(B)*d*；

部分有效的块在发布后的几个小时内可能不会被诚实块引用。**当一个块变旧并失去影响枢轴链的能力时，我们不在乎一个块是否部分有效。 一旦接受了部分有效的块，则将其视为完全有效的块，但计时器链的决定除外**？？？

2.**deferredStateRoot**, **deferredReceiptsRoot**, **deferredLogsBloomHash** and **blame**.这四个域对块的有效性无影响。

3.这四个域错了影响奖金，因为对状态的承诺错了。



只要目标难度合法且工作证明有效，部分有效的块对交易量也有贡献。这是因为Conflux允许引用部分有效的块，并且其中的事务将是按照任何完全有效的块进行处理。由于部分有效区块的生产者无权获得reward，所以
如果这些交易仅在部分有效的区块中收集，则可能会烧掉transaction fee。



### 4.4 Blaming Mechanism

Hm设置为最小的非负整数。

![image-20201117212359365](image-20201117212359365.png)

父亲错，祖父对设置为1。B到Hm+1之间的块都被认为状态无效。

而H(B)m+1责备的块又被B间接责备，我们就可以确定整个CHAIN（B）了。

若CHAIN（B‘）和CHAIN（B）有相交的块，它们若意见不一致，那么B’也被B责备。若B‘离开了主链，就不用再检查下去了。

Hm>0时的**deferredStateRoot**, **deferredReceiptsRoot**, **deferredLogsBloomHash**的求解：

![image-20201117213519558](image-20201117213519558.png)







### 4.2 Keccak 哈希算法







## 5.共识

有关共识的两个问题：

- 块是否有效能否上链；
- 上链的块如何排序

## 5.1 块校验





## 5.2 GHAST



## 5.3  Checkpoint机制

Era Genesis时代创世块，一个时代对应5W的高度。

> 50000 *·N is called the *era genesis block of Era* *N*

**Stable Era Geneses**

- 创世块第一个有效
- G的子树有240个连续的计时器块，记最终的那个计时器块为B
- B之后有240个连续的计时器块（这些块不一定在G的子树上）