# Markdown
Markdown 是一个[标准库](stdlib.md)，用于解析和导出 [Markdown 格式](../knowledge/markdown.md)

## 基础使用
```julia-repl
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

[^1]: https://discourse.juliacn.com/t/topic/2310
