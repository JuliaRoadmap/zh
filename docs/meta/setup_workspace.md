# 工作环境配置
## 编辑器
大多数程序文件是带有 `.jl` 扩展名的纯文本文件，因此任何文本编辑器都可以编写 Julia 代码。但集成开发环境（IDE）能提供语言感知的代码辅助，使体验更加顺畅。[^2]

!!! note "区分：代码编辑器（Editor）与集成开发环境（IDE, Integrated Development Environment）"
    代码编辑器事实上可以看成是一个记事本，其最基本的功能是文档编辑。不过之所以将其称为是**代码编辑器**，是因为它虽然继承自一般的文档编辑器，又具备了一些一般的文档编辑器所不具备的功能。具体来说，例如自动语法高亮，自动补全，甚至是自动代码重构等等。\
    集成开发环境（IDE）是一种用于构建应用程序的软件，**可将常用的开发人员工具合并到单个图形用户界面**（GUI）中。具体来说，我们只需要简单的点击按钮，可能就可以完成程序的编译、链接、运行、调试等等工作。而这些工作在最初都是需要人手工在命令行中完成的。

Julia 支持最好的 IDE 是 [Visual Studio Code](https://code.visualstudio.com/)（[下载安装方式参考这里](../knowledge/vscode.md)），配合 [Julia VSCode 扩展](https://www.julia-vscode.org/)使用效果最佳。可从 VSCode 扩展市场安装，并参阅其[文档](https://www.julia-vscode.org/docs/stable/)。

!!! tip
	在 VSCode 中，按 `Ctrl + Shift + P`（Mac 上为 `Cmd + Shift + P`）打开命令面板，输入 "julia" 即可查看所有可用的 Julia 命令，包括启动/重启 REPL、执行当前行等。

若不想使用 Microsoft 生态系统，[VSCodium](https://vscodium.com/) 是 VSCode 的开源替代品。其他编辑器如 [Emacs](https://www.gnu.org/software/emacs/) 和 [Vim](https://www.vim.org/) 也可通过 [JuliaEditorSupport](https://github.com/JuliaEditorSupport) 获得 Julia 插件支持。此外，[JuliaMono](https://juliamono.netlify.app/) 是专为 Julia Unicode 字符设计的等宽字体。

另可参考链接：
* [julia-emacs](https://github.com/JuliaEditorSupport/julia-emacs)
* [julia-vim](https://github.com/JuliaEditorSupport/julia-vim)
* [sublime](https://www.luogu.com.cn/blog/acking/sublime)

更多编辑器配置法[可参阅此](https://www.math.pku.edu.cn/teachers/lidf/docs/Julia/html/_book/basics.html#basics-inst)

## Notebook
Notebook 是 IDE 的流行替代方案，特别适合数据科学场景和文学式编程，它会将代码与说明交错呈现。[^2]

### Jupyter
[Jupyter](https://jupyter.org/) 是最知名的 Notebook 生态，支持 Julia、Python 和 R 三种核心语言。在 Julia 中使用它需要安装 [IJulia.jl](https://github.com/JuliaLang/IJulia.jl) 作为后端：

```julia-repl
julia> using IJulia
julia> IJulia.notebook()
```

VSCode 可直接打开、编辑和运行 Jupyter Notebook，无需额外安装 IJulia.jl 或 Jupyter。

### Pluto.jl
[Pluto.jl](https://plutojl.org/) 是纯 Julia 的 Notebook 替代方案，具有以下特性：
* **响应式**：更新某个单元格时，依赖它的其他单元格自动更新
* **可重现**：自动绑定依赖列表，开箱即用

```julia-repl
julia> using Pluto
julia> Pluto.run()
```

### Quarto
[Quarto](https://quarto.org/) 是一个开源的科学和技术出版系统，使用 `.qmd` 文件（支持可执行代码块），可渲染为文档（Word、PDF）、网页、博客、演示文稿等多种格式。Julia 1.5+ 可使用原生 Julia 引擎（无需依赖 Python）执行代码。[^2]

在 VSCode 中可安装 [Quarto 扩展](https://marketplace.visualstudio.com/items?itemName=quarto.quarto) 获得更好的编辑体验。

## 版本控制
[git](../knowledge/git.md)：目前使用最广泛的分布式版本控制系统之一

!!! note
	[什么是分布式版本控制软件](https://www.imooc.com/read/51/article/1008)

相关平台
* [Github](https://github.com/) | [说明](../knowledge/github.md)；使用最广泛的平台，也是 Julia 大部分设施所在的平台
* [GitLab](https://about.gitlab.com/)
* [码云 Gitee](https://gitee.com)（中国）

## 在线工作与共享
[Google colab](https://colab.research.google.com/) | [说明](https://github.com/googlecolab/colabtools/issues/5151)

[^1]: https://github.com/SAST-skill-docers/sast-skill-docs/blob/master/docs/basic/vscode.md
[^2]: [Modern Julia Workflows - Writing your code](https://modernjuliaworkflows.org/writing/)
