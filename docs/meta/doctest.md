# 文档功能测试
文字，**粗体**，*斜体*，`行内代码`，[内部链接](#标题2)[^1]，[外部链接](http://info.cern.ch/)\
第二行，[其它文档链接](about.md)，[标题链接](about.md#网站功能)，[纯代码文件链接](../lists/typetree1.6.txt#L20-L50)

---

## 标题2
![alt](../../assets/svg/benchmarks.svg)

1. 1
2. 2

- a
- b

> 引用

| 表格 | 第二个 |
| --- | --- |
| `a` | 1**+**2 |
| $b$ | 3*-*4 |

$$\sum_{i=1}^n i^{i+1}$$

!!! note
	note

!!! warn
	warn

!!! compat "HTMLify 1.0"
	compat

```plain
plain
```

```jl
julia> begin foo(nothing,"$(Int)\n") end # comment

help?> 32+`15`#= =# @bar
```

```insert-html
<div style="color:red;">RED HTML</div>
```

```insert-fill
("1+1等于几？\n允许末尾额外空格","2",r"^2 {0,}$")
```

```is-developer
欢迎开发者！
```

[^1]: footnote
