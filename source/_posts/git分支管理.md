---
title: git分支管理
date: 2022-03-11 01:06:42
categories: Tools
tags: [git,hexo]
---





首先，在github网页端的控制界面从master分出一个分支hexo；

```sh
#指定hexo分支clone到本地，并重命名为blog
git clone -b hexo git@github.com:MemoryOfSnow/MemoryOfSnow.github.io.git blog
#添加用户名配置
git config --global user.email "you@example.com"
git config --global user.name "MemoryOfSnow"
# 强行覆盖远程的hexo分支
git push --set-upstream origin hexo --force
#本地切换分支
git checkout -b hexo
```

hexo的_config.yml将分支设置为master，而整个文件夹设置为hexo分支，这样就可以实现多设备共同维护博客了。

## 写完博客后

```sh
hexo g -d
#后三组可以设置为一个dos脚本，随时执行
git add .
git commit -m "a new file"
git push
```

脚本如下：

```sh
git add .
git commit -m "bat auto push:%date:~0,10%,%time:~0,8%" 
::  git commit -m "%commitMessage%" 
git push origin hexo
@echo done,
```



## .gitignore文件内容

```sh
.DS_Store
Thumbs.db
db.json
*.log
node_modules/
public/
.deploy*/
```

