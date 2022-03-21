---
title: BubbleBabble解密
date: 2020-03-17 14:19:49
categories: CTF #Code
tags: [python,Crypt]
---
```python
from bubblepy import BubbleBabble

str='xinik-samak-luvag-hutaf-fysil-notok-mepek-vanyh-zipef-hilok-detok-damif-cusol-fezyx'
bb=BubbleBabble()
print(bb.decode(str))

```