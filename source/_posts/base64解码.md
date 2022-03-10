---
title: Base64解码
date: 2020-03-17 14:19:49
categories: Python #Code
tags: [Crypt,python]
---

import base64
f=open('input.txt','r')
out=open('base64_decode.txt','w')
f1=f.read()
def b64dec(astr,m):
 f2=astr
 for i in range(m):
  f2=base64.b64decode(f2)
  print f2
 astr=f2
 out.write(astr)

 
b64dec(f1,2)
f.close()
out.close()
