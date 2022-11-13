# Markdown的使用
Markdown是一个[标准库](stdlib.md)，用于解析和导出Markdown格式

## 文本格式
`markdown` 本身是一种文本格式，它的大体规范相同，但在不同地方可能存在细节上的不同。
基本使用格式可以[参考此文](https://docs.net9.org/basic/markdown/)，更准确地，[这是标准性的规范](https://spec.commonmark.org/)。

Markdown 语法允许嵌入[LaTeX](#latex)。
特别地，Julia（默认）使用[julia-markdown](https://docs.juliacn.com/latest/stdlib/Markdown/)

利用 [vscode](../knowledge/vscode.md#markdown-编辑) 或其它高级编辑器，可以轻松编辑 Markdown。

## 基础使用
```jl
julia> m=md"""
       # 标题
       1. 内容
       """ # 也可用@md_str、parse
  标题
  ≡≡≡≡

    1. 内容

julia> html(m) # 以html形式导出
"<h1>标题</h1>\n<ol>\n<li><p>内容</p>\n</li>\n</ol>\n"

julia> latex(m) # 以纯latex形式导出
"\\section{标题}\n\\begin{itemize}\n\\item[1. ] 内容\n\n\\end{itemize}\n"
```

## LaTeX
LaTeX 是一种渲染文档、数学公式所用的表达语言（当然，一些 Tex 宏包还支持有机化学等）。
通常使用的是它的一部分，[KaTeX](https://katex.org/)，主要用于表达数学公式。
在 julia-markdown 中，它的嵌入可以采用传统的美元，即一对 `$ $`，也可以使用一对``` `` `` ```，
- [入门可参考](https://docs.net9.org/basic/latex/)
- [官网](https://latex.org/)
- [中文LaTeX工作室](https://www.latexstudio.net/)
- [Julia中LaTeX相关资源](https://discourse.juliacn.com/t/topic/4564)

[^1]: https://discourse.juliacn.com/t/topic/2310
