# VSCode 使用基础
VSCode 是一款**轻量级**的**代码编辑器**，可以通过安装各种各样不同**扩展**的方式来实现开发者所需要的功能。

## 下载与运行
* 打开 VSCode 官网：<https://code.visualstudio.com/>
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
- [Julia in Visual Studio Code](https://code.visualstudio.com/docs/languages/julia)
- [在 vscode 中使用 Julia](https://www.julia-vscode.org/docs/stable/)
- [MinGW-w64 安装教程](https://zhuanlan.zhihu.com/p/76613134)
- [Windows 下使用 Mingw32-make 来执行 Makefile 示例](https://blog.csdn.net/linjf520/article/details/108559210)

## Markdown 编辑
利用内置功能，可以使用编辑器编辑 [Markdown](../knowledge/markdown.md)。进一步地，利用 markdown-pdf 等插件可以导出 pdf 等格式（[使它正确渲染 latex 的方式](https://zhuanlan.zhihu.com/p/416590621)）

[^1]: https://www.luogu.com.cn/blog/GNAQ/VSC-guide
[^2]: https://github.com/SAST-skill-docers/sast-skill-docs/blob/master/docs/basic/vscode.md
