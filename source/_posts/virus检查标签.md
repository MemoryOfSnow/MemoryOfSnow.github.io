---
title: 根据sha256检查程序标签
date: 2020-04-15 14:19:49
categories: Tools
tags: [python]
---

```python
#通过模拟键盘的方式获取报告
#参考https://blog.csdn.net/yan_star/article/details/113667094

import os
import pyautogui as pag
import pyperclip
import win32clipboard as w
import win32con#下载pywin32包
import time


address_bar=(1322,107)  #地址栏坐标
test_result=(142,365)   #预测结果所在坐标


api_addr="https://www.virustotal.com/gui/file/"

samples_addr="E:\Linux_sh\malware\Linux-Malware-Samples"#样本需要提前计算sha256值
report_addr="E:/Linux_sh/report_"+samples_addr+".txt"
test_str="00ae07c9fe63b080181b8a6d59c6b3b6f9913938858829e5a42ab90fb72edf7a"
url=api_addr+test_str
flag=1#flag==1为恶意


def get_text():
  w.OpenClipboard()
  d = w.GetClipboardData(win32con.CF_TEXT)
  w.CloseClipboard()
  return d.decode('utf-8')

def examine(file):
  #输入网址
  url=api_addr+file
  pag.click(address_bar[0],address_bar[1],1)
  pag.hotkey('alt','d')
  pyperclip.copy(url)
  #pyperclip.paste()
  pag.hotkey('ctrl','v')
  pag.keyDown('enter')
  pag.keyUp('enter')
  time.sleep(2)
  #获取检测结果(142,365)
  pag.click(test_result[0],test_result[1],2)
  pag.hotkey('ctrl','c')
  result=get_text()
  if result=='0':
      flag=0
  else:
      flag=1
  print('%s:%d\n'%(test_str,flag))



if __name__ == "__main__":
  path=samples_addr
  samples=os.listdir(samples_addr)
  for file in samples:
    examine(file)
```

