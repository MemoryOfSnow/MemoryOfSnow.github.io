---
title: tar命令
date: 2018-06-11 19:59:30
categories: Linux 
tags: [sh脚本,Linux命令]
---

```sh
#解压缩
 tar -xvf xxx.tar
```



```sh
#压缩  target  source_dir/
tar -cvf xxx.tar xxx/

其中，字母v如果更换为
-z #生成tar.gz文件
-j #生成tar.bz2文件
-Z #打包成xxx.tar后，并且将其用compress压缩，生成一个umcompress压缩过的包，命名为xxx.tar.Z


```

```sh
#追加文件放入压缩包
tar -rf xxx.tar newadd.txt
#更新文件放入压缩包
tar -uf xxx.tar newadd.txt
#展示压缩包中的文件
tar -tf xxx.tar

```

