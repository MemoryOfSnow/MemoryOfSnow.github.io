---
title: md5加密
date: 2020-03-17 14:19:49
categories: CTF #Code
tags: [python,Crypt]
---


```python
#!D:/softwares/Python3.7
import hashlib
hash = hashlib.md5()#md5对象，md5不能反解，但是加密是固定的，就是关系是一一对应，所以有缺陷，可以被对撞出来
hash.update(bytes('paul',encoding='utf-8'))#要对哪个字符串进行加密，就放这里
print(hash.hexdigest())#拿到加密字符串
# hash2=hashlib.sha384()#不同算法，hashlib很多加密算法
# hash2.update(bytes('admin',encoding='utf-8'))
# print(hash.hexdigest())


hash3 = hashlib.md5(bytes('abd',encoding='utf-8'))
''' 如果没有参数，所以md5遵守一个规则，生成同一个对应关系，如果加了参数，
就是在原先加密的基础上再加密一层，这样的话参数只有自己知道，防止被撞库，
因为别人永远拿不到这个参数
'''
hash3.update(bytes('admin',encoding='utf-8'))
print(hash3.hexdigest())


```