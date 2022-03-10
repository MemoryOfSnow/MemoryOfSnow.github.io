---
title: jupyter增加内核
date: 2020-03-17 14:19:49
categories: Python #Tools
tags: [Jupyter,python]
---

在Python3下安装好jupyter后

## 1.设置jupyter的默认运行路径

```
jupyter notebook --generate-config`
C:\Users[用户名].jupyter\jupyter_notebook_config.py
```


找到 #c.NotebookApp.notebook_dir = ''，去掉该行前面的“#”；在这里设置路径

## 2.安装Python2内核

> 在我的电脑上是python2.7和python3.9。其中python2.7下的python.exe被我重命名为python2。

2.1 在python2下安装ipykernel

```bash
python2 -m pip install ipykernel
```

2.2 增加内核

```bash
python2 -m ipykernel install --name python2
Installed kernelspec python2 in C:\ProgramData\jupyter\kernels\python2
```

注：Python更到最新的一个坏处是一些库还没来得及支持

另外ROCm可以多多关注，毕竟比cuda开源，

