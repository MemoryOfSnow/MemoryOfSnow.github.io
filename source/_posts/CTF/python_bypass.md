## LessEQualmore

```
>nc chal-lessequalmore.chal.hitconctf.com 11111
flag{1}
*** Flag Checker ***
You entered:
flag{1}
Sorry, wrong flag!
```







## Not just usbpcap

### 鼠标协议

  	每一个数据包的数据区有四个字节，

第一个字节代表按键，当取 0x00 时，代表没有按键、为 0x01 时，代表按左键，为 0x02 时，代表当前按键为右键。第二个字节可以看成是一个 signed byte 类型，其最高位为符号位，当这个值为正时，代表鼠标水平右移多少像素，为负时，代表水平左移多少像素。第三个字节与第二字节类似，代表垂直上下移动的偏移。 

键盘数据包的数据长度为 8 个字节，击键信息集中在第 3 个字节 

```
tshark -r ./release.pcapng -T fields -e usb.capdata >usbdata.txt
python UsbKeyboardDataHacker.py ./release.pcapng
```

```
l USB UART  异步接收传送器
l USB HID 交互式人性化接口
l USB Memory  数据存储
Audio/Video Distribution Transport Protocol）：

AVDTP是一种蓝牙协议，用于传输音频和视频数据。它定义了在蓝牙设备之间传输多
媒体数据流的规则和方法。AVDTP的作用是管理多媒体数据的流动，包括数据的传输、控制和同步。
HCI_EVT（Host Controller Interface Event）：

HCI_EVT是蓝牙协议栈中的一部分，用于管理与蓝牙硬件控制器之间的通信。它定义了一组事件和命令，允许主机设备与蓝牙硬件进行交互，包括连接、数据传输和配置等操作。
USBHUB（USB Hub Protocol）：

USBHUB是与USB（Universal Serial Bus）相关的协议，用于管理USB集线器（Hub）。USB集线器允许多个USB设备连接到单个USB端口，USBHUB协议定义了集线器的工作原理和与主机设备之间的通信方式。
RTP（Real-time Transport Protocol）：

RTP是一种用于实时数据传输的协议，通常用于音频和视频流的传输。它提供了时间同步、流标识和数据流传输的机制，以确保实时媒体数据能够以低延迟和高质量传输。RTP通常与RTCP（RTP Control Protocol）一起使用，后者用于监控和管理传输质量。
```

 `Bus 002 Device 002` 代表 `usb` 设备正常连接， 

### 蓝牙协议







## Misc1

![1694226682107](Untitled%201/1694226682107.png)







### 后台仓库

```
https://github.com/QingdaoU/Judger
```



main.c

```
max_process_number
max_output_size
exe_path
input_path "/dev/stdin"
output_path
error_path "/dev/stderr"
args
 env
 log_path judger.log
 seccomp_rule_name seccomp_rule_name->sval[0]
 uid 65534
 gid 65534
```

child.c  child_process








```
 proc = subprocess.Popen(proc_args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 out, err = proc.communicate()
 return json.loads(out.decode("utf-8"))
```





general.c

-  socket、fork、vfork、kill；
  - execveat

  禁止以w、rw使用open、openat；

```
//c_cpp.c

{SCMP_SYS(read), SCMP_SYS(fstat),
SCMP_SYS(mmap), SCMP_SYS(mprotect),
SCMP_SYS(munmap), SCMP_SYS(uname),
SCMP_SYS(arch_prctl), SCMP_SYS(brk),
SCMP_SYS(access), SCMP_SYS(exit_group),
SCMP_SYS(close), SCMP_SYS(readlink),
SCMP_SYS(sysinfo), SCMP_SYS(write),
SCMP_SYS(writev), SCMP_SYS(lseek),
SCMP_SYS(clock_gettime), SCMP_SYS(pread64)}; 
```

  不让写文件时：

禁止以w、rw使用open、openat；

或者在允许写文件时：

 允许进程调用 `open` 系统调用。 

 允许进程调用 `openat` 系统调用，类似于 `open`，但可以指定文件的相对路径。 

 允许进程调用 `dup2` 系统调用，用于复制文件描述符到指定的文件描述符号码。 

 允许进程调用 `dup3` 系统调用，类似于 `dup2`，但支持更多选项 



```
     max_memory=1024 * 1024 * 128, max_stack=32 * 1024 * 1024,
                        max_process_number=200, max_output_size=10000, exe_path="1.out",
                        input_path="1.in", output_path="1.out", error_path="1.out",
                        args=args, env=["a="], log_path="1.log",
                        seccomp_rule_name="1.so", uid=0, gid=0)
```

```
#base.py
   config = {"max_cpu_time": 1000,
                  "max_real_time": 3000,
                  "max_memory": 128 * 1024 * 1024,
                  "max_stack": 32 * 1024 * 1024,
                  "max_process_number": 10,
                  "max_output_size": 1024 * 1024,
                  "exe_path": "/bin/ls",
                  "input_path": "/dev/null",
                  "output_path": "/dev/null",
                  "error_path": "/dev/null",
                  "args": [],
                  "env": ["env=judger_test", "test=judger"],
                  "log_path": "judger_test.log",
                  "seccomp_rule_name": None,
                  "uid": 0,
                  "gid": 0}
```



### 文件路径

```
    def init_workspace(self, language):
        base_workspace = "/tmp"
        workspace = os.path.join(base_workspace, language)
        shutil.rmtree(workspace, ignore_errors=True)
        os.makedirs(workspace)
        return workspace

    def tearDown(self):
        shutil.rmtree(self.workspace, ignore_errors=True)

    def rand_str(self):
        return "".join([random.choice("123456789abcdef") for _ in range(12)])

```

相当于12位密码，难以预测。

## Lisp.js