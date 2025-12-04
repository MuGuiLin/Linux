# Windows Bat批处理脚本

> 批处理文件，在[DOS](https://baike.baidu.com/item/DOS/32025?fromModule=lemma_inlink)和[Windows](https://baike.baidu.com/item/Windows/165458?fromModule=lemma_inlink)（任意）[操作系统](https://baike.baidu.com/item/操作系统/192?fromModule=lemma_inlink)中，.bat文件是[可执行文件](https://baike.baidu.com/item/可执行文件/2885816?fromModule=lemma_inlink)，由一系列命令构成，其中可以包含对其他程序的调用。这个文件的每一行都是一条[DOS命令](https://baike.baidu.com/item/DOS命令/5143255?fromModule=lemma_inlink)（大部分时候就好像我们在[DOS](https://baike.baidu.com/item/DOS/32025?fromModule=lemma_inlink)提示符下执行的[命令行](https://baike.baidu.com/item/命令行/196110?fromModule=lemma_inlink)一样），你可以使用[DOS](https://baike.baidu.com/item/DOS/32025?fromModule=lemma_inlink)下的[EDIT](https://baike.baidu.com/item/EDIT/18385448?fromModule=lemma_inlink)或者[Windows](https://baike.baidu.com/item/Windows/165458?fromModule=lemma_inlink)的[记事本](https://baike.baidu.com/item/记事本/66780309?fromModule=lemma_inlink)（[Notepad](https://baike.baidu.com/item/Notepad/291297?fromModule=lemma_inlink)）等任何[文本文件](https://baike.baidu.com/item/文本文件/747597?fromModule=lemma_inlink)编辑工具创建和修改批处理文件。



#### [Linux 常用命令](https://dablelv.blog.csdn.net/article/details/104488673)

#### [Windows 自带Shell  - PSWindows](https://aka.ms/PSWindows)



#### Bat批处理脚本 只能在Windows中运行吗？

> 是的，Bat批处理脚本‌**只能在Windows系统中运行**‌。‌
>
> 这是因为Bat脚本是为Windows操作系统内置的命令行解释器（如cmd.exe）编写的，它依赖于Windows特有的命令和环境。‌12 如果您尝试在Linux或macOS等其他操作系统上直接运行Bat文件，系统会提示找不到相应的解释器或无法识别文件格式。‌



#### 如果在非Windows系统（如：MAC、Linux）上执行类似的自动化任务，可以考虑以下替代方案：

> - ‌**在Linux或macOS上**‌：使用Bash脚本（以`.sh`为扩展名），这是类Unix系统原生支持的脚本语言。‌
> - ‌**跨平台工具**‌：使用像Wine（兼容层）或DOSBox（仿真器）这样的工具在Linux上运行Windows批处理文件，但这并非原生支持。‌
> - ‌**脚本转换**‌：将Bat文件转换为Bash脚本（例如使用`bat2sh`工具），但转换后可能需要手动调整代码以适配目标系统。‌

