git add .
git commit -m "bat批处理自动推送:%date:~0,10%,%time:~0,8%" 
::  git commit -m "%commitMessage%" 
git push origin hexo
@echo 已经完成,