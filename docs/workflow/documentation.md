# 文档与文学式编程
## 文档字符串
无论代码多么完善，缺乏文档都会让他人（甚至日后的自己）难以使用。为函数、类型等编写文档字符串 **docstring** 应该成为一种习惯，用户可以通过 REPL 的帮助模式（`?`）查询它们。[^1]

```julia
"""
    myfunc(a, b; kwargs...)

一句话描述函数的用途，紧跟在（缩进的）签名之下。

如有必要，在此处补充更多说明。
"""
function myfunc end
```

[DocStringExtensions.jl](https://github.com/JuliaDocs/DocStringExtensions.jl) 提供了若干快捷方式，可自动生成签名、字段列表等常见内容，减少 docstring 的编写工作量。

## Documenter.jl
包的文档不限于 docstring，还可以包含高级概述、技术说明、示例和教程等。[Documenter.jl](https://github.com/JuliaDocs/Documenter.jl) 允许你基于 `docs/` 子目录中的 Markdown 文件构建完整的文档网站，其[官方文档](https://documenter.juliadocs.org/stable/)本身就是极好的参考范例。[^1]

本地构建文档：

```julia-repl
julia> using Pkg
julia> Pkg.activate("docs")
julia> include("docs/make.jl")
```

使用 [LiveServer.jl](https://github.com/tlienart/LiveServer.jl) 在本地实时预览并自动更新文档网站（类似 Revise.jl 的热更新效果）：

```julia-repl
julia> using LiveServer
julia> servedocs()
```

通过在 [PkgTemplates.jl](https://github.com/JuliaCI/PkgTemplates.jl) 中选择 [Documenter 插件](https://juliaci.github.io/PkgTemplates.jl/stable/user/#PkgTemplates.Documenter)，可以自动配置 `docs/` 目录内容及 GitHub Actions 工作流，将文档部署到 [GitHub Pages](https://pages.github.com/)。

有用的 Documenter.jl 插件：
- [DocumenterCitations.jl](https://github.com/JuliaDocs/DocumenterCitations.jl)：从 BibTeX 文件插入学术引用
- [DocumenterInterLinks.jl](https://github.com/JuliaDocs/DocumenterInterLinks.jl)：跨文档交叉引用（Documenter 和 Sphinx）

若需要替代方案，可以尝试 [Pollen.jl](https://github.com/lorenzoh/Pollen.jl)；[Replay.jl](https://github.com/AtelierArith/Replay.jl) 则可将终端操作录制为 ASCII 视频，适合制作教程演示。

## 文学式编程
科学软件往往难以理解，仅靠代码本身可能无法清晰传达思路。文学式编程将代码与文本、公式、图像交织在一起，适合编写技术文档或学术文章。[^1]

### Literate.jl
[Literate.jl](https://github.com/fredrikekre/Literate.jl) 允许在普通 Julia 脚本中以特定格式书写注释，并将其转换为 Markdown 文档、Jupyter Notebook 或 Documenter.jl 页面等多种格式。[Books.jl](https://github.com/JuliaBooks/Books.jl) 适合撰写较长的技术书籍。

### Quarto
[Quarto](https://quarto.org/) 是一个开源的科学和技术出版系统，支持 Python、R 和 Julia。Quarto 可将 Markdown（`.md`）、Quarto Markdown（`.qmd`）和 Jupyter Notebook（`.ipynb`）渲染为多种格式：

- 文档：Word、PDF、HTML
- 演示文稿：Reveal.js、PowerPoint、Beamer
- 网站、博客、书籍

Julia 1.5+ 支持[原生 Julia 引擎](https://quarto.org/docs/blog/posts/2024-07-11-1.5-release/#native-julia-engine)，无需依赖 Python 即可执行代码块。内容可发布到 GitHub Pages、Netlify、[Quarto Pub](https://quartopub.com/) 等平台。

### PlutoPapers.jl
[PlutoPapers.jl](https://github.com/mossr/PlutoPapers.jl) 在 Pluto.jl Notebook 中直接提供类 LaTeX 样式的交互式论文排版，将计算文档与出版级论文之间的差距缩到最小。

[^1]: [Modern Julia Workflows - Sharing your code](https://modernjuliaworkflows.org/sharing/)
