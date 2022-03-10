---
title: git分支管理
date: 2022-03-11 01:06:42
categories: Tools
tags: [git,hexo]
---







```sh
#本地切换分支
git checkout -b hexo
#制定hexo分支clone到本地
git clone -b hexo git@github.com:MemoryOfSnow/MemoryOfSnow.github.io.git
# 强行覆盖远程的hexo分支
git push --set-upstream origin hexo --force
```

hexo的_config.yml将分支设置为master，而整个文件夹设置为hexo分支，这样就可以实现多设备共同维护博客了。

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

