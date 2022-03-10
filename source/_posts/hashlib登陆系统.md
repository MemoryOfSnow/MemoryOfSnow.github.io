---
title: hashlib实现的登录系统
date: 2020-03-17 14:19:49
categories: Python #Code
tags: [Crypt,python]
---
import hashlib
#hashlib简单使用
def md5(arg):#这是加密函数，将传进来的函数加密
    md5_pwd = hashlib.md5(bytes('abd',encoding='utf-8'))
    md5_pwd.update(bytes(arg,encoding='utf-8'))
    return md5_pwd.hexdigest()#返回加密的数据
def log(user,pwd):#登陆时候时候的函数，由于md5不能反解，因此登陆的时候用正解
    with open('db','r',encoding='utf-8') as f:
        for line in f:
            u,p=line.strip().split('|')
            #strip()是删除首尾的字符串
            #split()是将字符串按某一个字符分割，且分割n次。如按‘.’分割n次
            if u ==user and p == md5(pwd):#登陆的时候验证用户名以及加密的密码跟之前保存的是否一样
                return True
def register(user,pwd):#注册的时候把用户名和加密的密码写进文件，保存起来
    with open('db','a',encoding='utf-8') as f:
        temp = user+'|'+md5(pwd)
        f.write(temp)
 
i=input('1表示登陆，2表示注册：')
if i=='2':
    user = input('用户名：')
    pwd =input('密码：')
    register(user,pwd)
elif i=='1':
    user = user = input('用户名：')
    pwd =input('密码：')
    r=log(user,pwd)#验证用户名和密码
    if r ==True:
        print('登陆成功')
    else:
        print('登陆失败')
else:
    print('系统不存在此功能模块')
