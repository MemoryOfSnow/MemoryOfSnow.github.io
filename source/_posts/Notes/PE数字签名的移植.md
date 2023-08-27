---
title: PE数字签名的移植
date: 2023-08-18 14:58:58
categories: 笔记 #
tags: [PE]
---
>全文抄袭这两篇
>
>https://cloud.tencent.com/developer/article/1910261
>
>https://mp.weixin.qq.com/s/x6VavWfK_fEungV2pDZ1Iw
```
C:\Program Files (x86)\Windows Kits\10\bin\10.0.18362.0\x86\signtool.exe
更多的使用pfk和pf12文件。
SignTool sign /fd md5
SignTool sign /f test.cer /csp "Hardware Cryptography Module" /k HighValueContainer /v test.exe
```

## 制作证书

- 使用管理员身份运行x86_x64 Cross Tools Command Prompt for VS 2022，生成签名成功。

```
makecert -r -$ "individual" /sv "test.PVK" -n "CN=GS,O=GS,C=China,S=Guangzhou" -a md5 -b 08/18/2023 -e 08/18/2033 test.cer
```

![1692370031213](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692370031213.png)

第一次创建私钥密码，生成私钥文件test.PVK；之后再经过私钥密码确认后，生成公钥证书文件test.cer文件。

加入受信任 的跟存储区。

```
certmgr.exe -add -c test.cer -s -r localMachine root
```

### 生成spc文件

```
cert2spc test.cer test.spc
```

### 安装证书(Failed)，

找不到可视化的signcode，使用了新版sdk自带的signtool

```
d:\test>signtool sign /debug /v /a /sm /ac test.cer /fd sha256  test.exe

The following certificates were considered:
    Issued to: GS
    Issued by: GS
    Expires:   Tue Jan 01 00:00:00 2030
    SHA1 hash: EE0FBF8360FF3E8592A0CA55096760CBB9D3E835

After EKU filter, 1 certs were left.
After expiry filter, 1 certs were left.
After Private Key filter, 0 certs were left.
SignTool Error: No certificates were found that met all the given criteria.
```

总是报错，先安装一个证书看签名移植过程再说。

```
d:\test>signtool sign /debug /v /sm /fd sha256  test.exe

The following certificates were considered:
    Issued to: NVIDIA GameStream Server
    Issued by: NVIDIA GameStream Server
    Expires:   Fri Jun 26 16:03:20 2043
    SHA1 hash: 387B08818D2E0BC8BFA623DC033AF906246F4BEA

After EKU filter, 1 certs were left.
After expiry filter, 1 certs were left.
After Private Key filter, 1 certs were left.
The following certificate was selected:
    Issued to: NVIDIA GameStream Server
    Issued by: NVIDIA GameStream Server
    Expires:   Fri Jun 26 16:03:20 2043
    SHA1 hash: 387B08818D2E0BC8BFA623DC033AF906246F4BEA

Done Adding Additional Store
Successfully signed: test.exe

Number of files successfully Signed: 1
Number of warnings: 0
Number of errors: 0
```

![1692375968841](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692375968841.png)

如图，左边是安装了签名的软件。文件大小变为了10,528字节，比原来的9,216 字节多了1,312字节（测试了其他程序，增加的字节数不变）。

### 卸载证书

```
signtool remove /s test.exe
```

## PE数字证书的头格式

![1692376207537](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692376207537.png)

增加部分的内容。

![1692376376290](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692376376290.png)

如图所示，修改了三个地方的值，增加了一部分字段。

![1692376664884](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692376664884.png)

修改的第一处地方是文件的checksum，

![1692376755140](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692376755140.png)

第二处是0x188处RVA所属的4字节从0x00000000变为了新节的0x00240000（小端序），正好对应增加的签名块的起始位置,0x2400；

第三处是0x18c-0x18f处的四字节值，从0x20050000，恰好是1312字节大小。

修改处对应的文件结构为

```
struct COFFHeader {
	char signature[4];
	MachineType machine;
	u16 numberOfSections;
	u32 timeDateStamp;
	u32 pointerToSymbolTable;
	u32 numberOfSymbols;
	u16 sizeOfOptionalHeader;
	Characteristics characteristics;

	if (sizeOfOptionalHeader > 0x00) {
		OptionalHeader optionalHeader;
	}
};

struct OptionalHeader{
	DataDirectory directories[numberOfRVAsAndSizes];	
}
struct DataDirectory {
	u32 rva;
	u32 size;
};
```

对于增加的证书，

![1692376376290](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692376376290.png)

符合以下数据结构：

```c
typedef struct _WIN_CERTIFICATE
{
    DWORD dwLength;//表项长度，这里是0x00000520,1312字节
    WORD wReVision;//证书版本，0x0200，表示WIN_CERT_REVISION_2
    WORD wCertificateType;//证书类型，这里0x0002表是PKCS#7的SignData
    BYTE bCertificate[ANYSIZE_ARRAY];//SignedData，从第9个字节开始的数据
    
}WIN_CERTIFICATE, *LPWIN_CERTIFICATE;
```

将0x2400这个节偏移0x09位置开始的所有数据提取，我使用imHex，保存为testPKcs7Data.bin。

![1692380683213](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692380683213.png)

记得移除最后的00字节。

也可以使用dd命令。

```
dd if=./test.exe of=./test02Pkcs7Data.bin skip=9216 bs=1 count=1298
```

其中，9224=int(0x2400)+8，count=1312-8-6（00字节）

之后使用asn1view读取该文件，下载这个软件的时候，去各种网站上下载，

先下载到了一个病毒

```
https://cdn-file-ssl.ludashi.com/downloader/temp_package/2023-08/asn1dump(%E6%96%87%E4%BB%B6%E7%BC%96%E7%A0%81%E6%A0%BC%E5%BC%8F%E6%9F%A5%E7%9C%8B%E5%B7%A5%E5%85%B7)_3715450019.exe
```

之后下载的软件少配置文件，最后终于下到了正常的。

```
https://dl002.liqucn.com/upload/2021/1518/a/asn1view.zip
```

逐个拿可执行文件的hash值去VT上查就可以了，或者对于下载文件夹运行脚本检查，不需要使用VT的API接口，只需要拼接字符串，然后用正则式匹配里面检测到的引擎数即可，当然记得设置header部分。

### asn1view获取到的内容

> 或者使用https://holtstrom.com/michael/tools/asn1decoder.php 

![1692381389608](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692381389608.png)

### PE  签名数据分析

![1692382153034](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692382153034.png)

 一个PKCS#7 SignedData结构包括PE文件的哈希值，一个被软件出版厂商的私钥创建的签名、将软件出版厂商的签名密钥和法人代表进行绑定的（系列）X.509 v3证书。PKCS#7 1.5版本规范定义了如下关于SignedData 的 ASN.1（抽象语法符号）结构： 

```c
typedef struct PKCS7_SignedData {
    int version; // Version (of PKCS #7, generally version 1)
    digestAlgorithms DigestAlgorithms; // Collection of all algorithms used by SignerInfo signature blocks
    contentInfo ContentInfo; // Content type and content or reference to content
    certificates *ExtendedCertificatesAndCerticificates, // OPTIONAL: Collection of all certificates used
     *CertificateRevocationLists; // OPTIONAL: Collection of all CRLs
    signerInfos *signerInfos; // One or more SignerInfo signature blocks
} PKCS7_SignedData;

typedef struct SignerInfo {
    Certificate certificate; // Issuer and serial number to uniquely identify the signer's certificate
    DigestAlgorithm digestAlgorithm; // Digest algorithm
    DigestEncryptionAlgorithm digestEncryptionAlgorithm; // Digest encryption algorithm
    Digest digest; // Hash
    EncryptedDigest encryptedDigest; // Actual signature
    AuthenticatedAttribute *authenticatedAttributes; // OPTIONAL: Attributes signed by this signer
    UnauthenticatedAttribute *unauthenticatedAttributes; // OPTIONAL: Attributes not signed by this signer
} SignerInfo;
contentInfo=Sequence(
    contenttype Contenttype,
    content [0]
)
```

![1692382879057](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692382879057.png)

这里的 “1.2.840.113549.1.7.2”  ，表示

采用PKCS#7结构;

生成签名的哈希算法MD5\SHA1\\**SHA256**\，

签名属性SPC

证书颁发者信息(包括md5withRSA签名、证书颁发者YXZ、组织WHU、国家及省份)等。核心数据包括：散列算法\摘要数据\公钥数据\签名后数据;  

## 数字证书的移植。

1、有签名程序开展，找到PE头的struct IMAGE_DATA_DIRECTORY Security，取出其签名的偏移和大小长度，移到偏移处，取大小长度的内容；

这里取了HBuildX的程序的签名部分。

![1692383289453](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692383289453.png)

![1692384153074](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692384153074.png)

2、将以上长度的内容复制到无签名程序的尾部，修改struct IMAGE_DATA_DIRECTORY Security处的偏移和长度值，指向Certificates；

![1692384315658](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692384315658.png)

![1692384364030](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692384364030.png)

最终，移花接木成功。

![1692384266251](PE%E6%95%B0%E5%AD%97%E7%AD%BE%E5%90%8D%E7%9A%84%E7%A7%BB%E6%A4%8D/1692384266251.png)

