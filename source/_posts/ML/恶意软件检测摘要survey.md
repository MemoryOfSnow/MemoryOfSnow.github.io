---
title: 恶意检测2023年论文摘要汇
date: 2023-05-08 14:17:22
categories: 机器学习 #
tags: [Malware]
---



[1] 针对在程序功能无关区域添加修改的一类对抗样本攻击,  利用模型解释技术提取端到端恶意代码检测**模型的决策依据作为特征**,  进而通过**异常检测**方法准确识别对抗样本.  该方法作为恶意代码检测模型的**附加模块**,  不需要对原有模型做修改, 

[2]建立了一种多尺度卷积核混合的卷积神经网络（Convolutional Neu⁃ ral Network，CNN）架构，以提高恶意代码识别能力. 该模型运用具有捷径**（shortcut）结构**的深度大内核卷积和标准小内 核卷积相结合的混合卷积核（Mixed Kernels，MK）模块，以提高模型准确率；在此基础上，通过**多尺度内核融合（Multiscale Kernel Fusion，MKF**），以降低模型参数量；再结合**特征重组（feature shuffle）**操作，实现优化特征通信，在不增加模 型参数量的前提下提升了分类精度 。

 [3]设计 APT 恶意 软件基因模型和基因相似度检测算法构建**恶意行为基因库**,  

[4] . 针对目前研究仅着眼于提升模型分类准确率而忽略了恶意代码**检测的时效性**  。将多尺度恶意 代码特征融合与通道注意力机制结合，增强关键特征表达，并使用数据增强技术改善数据集类别不平衡问题 ，检测速度快。

[5]生成**概率 CFG**，其中顶点代表操作码，操作码之间的边代表这些操作码在文件中出现的概率。。。。

[6]可视化方法生成的恶意软件图像并没有保留语义和统计属性，尺寸小且统一。 本文给出了提取内容和填充模式的定义，以表征恶意软件可视化任务的关键因素，并提出了一种新的基于汇编指令和**马尔可夫传递矩阵**的恶意软件可视化方法来表征恶意软件。 因此，提出了一种基于**三通道可视化**和深度学习（MCTVD）的恶意软件分类方法。。。。

[7]通过实施 CNN 模型和**迁移学习** (TL，**MobileNetV2 和 ResNet-50 模型**) 进行恶意软件分类的深度学习，以克服基于 DL 的恶意软件检测模型中的常见问题，包括过度拟合、高资源消耗和无法检测混淆的恶意软件。本文提出的模型检测混淆的能力强。。。。

[8]提出了提高特征表示质量的两种新机制。一是通过重新解释user-defined function calls的操作码序列来捕获这些函数调用的语义；二是将文字信息整合到函数调用图FCG的嵌入中，以实现更好的判别能力。在静态检测的背景下，通过采用所提出的两种机制，五个广泛采用的分类器对恶意软件家族分类的准确率平均提高了 2%。。。。（表示）

[9]







[1] 田志成, 张伟哲, 乔延臣, 等. 基于模型解释的 PE 文件对抗性恶意代码检测[J]. 软件学报, 2023, 34(4): 1926-1943. 

[2] 张丹丹, 宋亚飞, 刘曙. MalMKNet：一种用于恶意代码分类的多尺度卷积神经网络[J]. 电子学报, [DOI: 10.12263/DZXB.20221069](https://doi.org/10.12263/DZXB.20221069). 

 [3]陈伟翔, 任怡彤, 肖岩军, 等. 面向 APT 家族分析的攻击路径预测方法研究[J]. Journal of Cyber Security 信息安全学报, 2023, 8(1). 

[4] 王硕, 王坚, 王亚男, 等. 一种基于特征融合的恶意代码快速检测方法[J]. 电子学报, 2023, 51(1): 57-66. 

[5] shah, I.A., Mehmood, A., Khan, A.N. *et al.* HeuCrip: a malware detection approach for internet of battlefield things. *Cluster Comput* **26**, 977–992 (2023). https://doi.org/10.1007/s10586-022-03618-y 

[6] Deng H, Guo C, Shen G, et al. MCTVD: A malware classification method based on three-channel visualization and deep learning[J]. Computers & Security, 2023, 126: 103084. 

[7] Habibi O, Chemmakha M, Lazaar M. Performance Evaluation of CNN and Pre-trained Models for Malware Classification[J]. Arabian Journal for Science and Engineering, 2023: 1-15. 

[8] Wu C Y, Ban T, Cheng S M, et al. IoT malware classification based on reinterpreted function-call graphs[J]. Computers & Security, 2023, 125: 103060. 



[9] Malhotra V, Potika K, Stamp M. A Comparison of Graph Neural Networks for Malware Classification[J]. arXiv preprint arXiv:2303.12812, 2023. 

https://arxiv.org/pdf/2303.12812

[10] Chaganti R, Ravi V, Pham T D. A multi-view feature fusion approach for effective malware classification using Deep Learning[J]. Journal of Information Security and Applications, 2023, 72: 103402. 

https://www.researchgate.net/profile/Vinayakumar-Ravi/publication/366323708_A_multi-view_feature_fusion_approach_for_effective_malware_classification_using_Deep_Learning/links/639c5704e42faa7e75cad9c6/A-multi-view-feature-fusion-approach-for-effective-malware-classification-using-Deep-Learning.pdf

[11] 利用节表的注入欺骗分类模型。da Silva A A, Pamplona Segundo M. On deceiving malware classification with section injection[J]. Machine Learning and Knowledge Extraction, 2023, 5(1): 144-168. 

https://www.mdpi.com/2504-4990/5/1/9

[12]

 Ravi V, Alazab M. Attention‐based convolutional neural network deep learning approach for robust malware classification[J]. Computational Intelligence, 2023, 39(1): 145-168. 

https://www.researchgate.net/profile/Vinayakumar-Ravi/publication/363834604_Attention-based_convolutional_neural_network_deep_learning_approach_for_robust_malware_classification/links/634ba0e376e39959d6c627dc/Attention-based-convolutional-neural-network-deep-learning-approach-for-robust-malware-classification.pdf

[13]动态权重值的联邦学习分类安卓恶意软件方法

 Chaudhuri A, Nandi A, Pradhan B. A Dynamic Weighted Federated Learning for Android Malware Classification[M]//Soft Computing: Theories and Applications: Proceedings of SoCTA 2022. Singapore: Springer Nature Singapore, 2023: 147-159. 

https://arxiv.org/pdf/2211.12874

[14]增强勒索软件分类，通过**多阶段特征提取和数据不平衡的校正**。

 Onwuegbuche F C, Delia A. Enhancing Ransomware Classification with Multi-Stage Feature Selection and Data Imbalance Correction[J]. 



[15]





[16]







[17]







[18]







[19]









[20]