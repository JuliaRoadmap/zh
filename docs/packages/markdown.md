# Markdown的使用
Markdown是一个[标准库](stdlib.md)，用于解析和导出Markdown格式

## 文本格式
`markdown`本身是一种文本格式，它的大体规范相同，但在不同地方可能存在细节上的不同\
基本使用格式可以轻松搜到，[这是标准性的规范](https://spec.commonmark.org/)\
markdown允许嵌入[LaTeX](#latex)\
特别地，Julia（默认）使用[julia-markdown](https://docs.juliacn.com/latest/stdlib/Markdown/)

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
- LaTeX的嵌入可以采用传统`$ $`，也可以使用一对``` `` `` ```，通常使用的是它的一部分，[KaTeX](https://katex.org/)
- [官网](https://latex.org/)
- [中文LaTeX工作室](https://www.latexstudio.net/) | []
- [Julia中LaTeX相关资源](https://discourse.juliacn.com/t/topic/4564)

[^1]: https://discourse.juliacn.com/t/topic/2310
