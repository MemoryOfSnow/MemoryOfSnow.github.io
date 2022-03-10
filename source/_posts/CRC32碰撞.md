---
title: crc32碰撞
date: 2020-03-17 14:19:49
categories: Python #Code
tags: [Crypt,python]
---
```python
from zlib import crc32
import random

char='0123456789'

def crc32_f(data):
    return hex(crc32(data)&0xffffffff)[2:10]

length=input('length:')
crc32_=raw_input('crc32:').lower()

while True:
    text=''
    for i in range(length):
        text+=char[random.randint(0,len(char)-1)]
    if crc32_f(text)==crc32_:
        raw_input('find it:'+text)
        exit

```




