# vscode使用基础
VSCode 是一款**轻量级**的**代码编辑器**，可以通过安装各种各样不同**扩展**的方式来实现开发者所需要的功能。

!!! note "区分：代码编辑器（Editor）与集成开发环境（IDE, Integrated Development Environment）"
    代码编辑器事实上可以看成是一个记事本，其最基本的功能是文档编辑。不过之所以将其称为是**代码编辑器**，是因为它虽然继承自一般的文档编辑器，又具备了一些一般的文档编辑器所不具备的功能。具体来说，例如自动语法高亮，自动补全，甚至是自动代码重构等等。\
    集成开发环境（IDE）是一种用于构建应用程序的软件，**可将常用的开发人员工具合并到单个图形用户界面**（GUI）中。具体来说，我们只需要简单的点击按钮，可能就可以完成程序的编译、链接、运行、调试等等工作。而这些工作在最初都是需要人手工在命令行中完成的。\
    我们今天要介绍的 VSCode 是一款轻量级的**代码编辑器**。如果没有各种扩展插件的支持的话，可能我们只能把它称作是大号的 Notepad++，而正是因为社区中各种各样的扩展，VSCode 才得以展现其强大。

![image-20220209114623794](https://s2.loli.net/2022/02/09/psKk8yJ2CxMic1O.png)

## 下载与运行
* 打开 VSCode 官网：https://code.visualstudio.com/
* 点击大大的 Download 按钮（如果是 Windows 64 位用户可以点击下拉框选择 x64 安装包版本）
* 进行安装或解压缩（注意路径中不能存在任何中文字符，推荐仅用字母和数字）
* 到你安装 VSCode 的目录下，新建 `data` 文件夹

> 这里我们新建 `data` 文件夹后，之后 VSCode 运行时的扩展插件和用户数据便都会存放在 `data` 文件夹下，这样可以在一定程度上避免系统盘容量占用的问题。如果不新建 `data` 文件夹，那么 VSCode 会将上述插件和用户信息存放在系统盘的用户目录下。
>
> ![image-20220209213021194](https://s2.loli.net/2022/02/09/IsPShQ2nLyqmwH8.png)

## 扩展插件的安装
我们打开 VSCode，先简单介绍下界面及其功能：

![image-20220209220846472](https://s2.loli.net/2022/02/09/pM6kzGH4xbIRW5K.png)

红色框是我们当前项目（即文件夹）下的所有文件清单，蓝色框是我们编写代码的地方，绿色框是我们的应用商店。

这里我们推荐扩展「Chinese (Simplified) Language Pack for Visual Studio Code」，在应用商店中搜索即可下载。在安装了简体中文插件后，我们可以按 `Ctrl + Shift + P`，打开输入框，输入 `Configurate display language`，选择中文后重新启动即可

## 相关文档
- https://code.visualstudio.com/
- https://zhuanlan.zhihu.com/p/76613134
- https://blog.csdn.net/linjf520/article/details/108559210
- [在vscode中使用Julia](https://www.julia-vscode.org/docs/stable/)

## Markdown 编辑
利用内置功能，可以使用编辑器编辑 [Markdown](../knowledge/markdown.md)。进一步地，利用 markdown-pdf 等插件可以导出 pdf 等格式（[使它正确渲染 latex 的方式](https://zhuanlan.zhihu.com/p/416590621)）

[^1]: https://www.luogu.com.cn/blog/GNAQ/VSC-guide
[^2]: https://github.com/SAST-skill-docers/sast-skill-docs/blob/master/docs/basic/vscode.md
