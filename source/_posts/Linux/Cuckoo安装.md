---
title: Ubuntu虚拟机安装Cuckoo
date: 2022-06-11 19:59:30
categories: Linux 
tags: [Cuckoo]
---
## 1.基础依赖

```
$ sudo apt-get install python python-pip python-dev libffi-dev libssl-dev
$ sudo apt-get install python-virtualenv python-setuptools
$ sudo apt-get install libjpeg-dev zlib1g-dev swig
sudo apt-get install git mongodb libffi-dev build-essential python-django python python-dev python-pip python-pil python-sqlalchemy python-bson python-dpkt python-jinja2 python-magic python-pymongo python-gridfs python-libvirt python-bottle python-pefile python-chardet tcpdump -y

```



```
find /home/ -path "/home/Downloads" -prune -o -type f -name 'pip.conf' -print
```



## 2.安装数据库软件

基于Django的web接口（依赖Mongodb)

```
#对于Ubuntu22
sudo vim /etc/apt/sources.list
#插入
deb http://security.ubuntu.com/ubuntu bionic-security main
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
sudo apt-get update
sudo apt-get install mongodb
```



```
sudo apt-get install postgresql libpq-dev
```



### m2crypto

```
ln -s /usr/include/x86_64-linux-gnu/openssl/opensslconf.h /usr/include/openssl/opensslconf.h
pip install --global-option=build_ext --global-option="-I/usr/include/x86_64-linux-gnu" m2crypto
```



### Volatility

```
git clone https://github.com/volatilityfoundation/volatility.git
cd volatility
python setup.py build
python setup.py install
python vol.py -h
```



## 3.可选项安装

###  mitmproxy辅助模块

virturalenv py3.6 

Intercept SSL/TLS generated traffic 

把它的二进制文件路径放在cuckoo配置文件里

### guacd

```
apt install libguac-client-rdp0 libguac-client-vnc0 libguac-client-ssh0 guacd
```

### Pydeep

```
apt install libfuzzy-dev
wget http://sourceforge.net/projects/ssdeep/files/ssdeep-2.13/ssdeep-2.13.tar.gz/download -O ssdeep-2.13.tar.gz
tar -zxf ssdeep-2.13.tar.gz
cd ssdeep-2.13
./configure
make
sudo make install
ssdeep -V #检查版本
pip show pydeep  #再安装一次看看会不会提示已安装
```



## KVM/Zen等虚拟化软件

```
$ sudo apt-get install qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils python-libvirt
```



## 4.安装Cuckoo

```
apt-get install libx11-dev
#apt-file search Intrinsic.h apt-file可以根据缺少的文件找对应需要安装的库
sudo apt-get install libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk
pip install -U cuckoo
```





## 5.运行

1.cuckoo -d

```
Potentially vulnerable virtualbox version installed. Failed to retrieve its version. Update if version is: 5.2.27
 find / -name 'cuckoo.conf'|grep cuckoo
vim /root/.cuckoo/conf/cuckoo.conf
 将vulnerable 置为 yes
```

2.再次运行报告下面的错误

```
2023-04-12 13:52:37,757 [cuckoo] CRITICAL: CuckooCriticalError: Unable to bind ResultServer on 192.168.56.1:2042 [Errno 99] Cannot assign requested address. This usually happens when you start Cuckoo without bringing up the virtual interface associated with the ResultServer IP address. Please refer to https://cuckoo.sh/docs/faq/#troubles-problem for more information.
```

修改cuckoo的网卡接口与wsl启动保持一致

## 6.借助CWD在一部机器上运行多个实例

```
$ sudo mkdir /opt/cuckoo
$ sudo chown cuckoo:cuckoo /opt/cuckoo
$ cuckoo --cwd /opt/cuckoo

# You could place this line in your .bashrc, for example.
$ export CUCKOO=/opt/cuckoo
$ cuckoo
```

