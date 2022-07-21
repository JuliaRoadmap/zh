# 文档功能测试
文字，**粗体**，*斜体*，`行内代码`，[内部链接](#标题2)[^1]，[外部链接](http://info.cern.ch/)\
第二行，[其它文档链接](about.md)，[标题链接](about.md#网站功能)，[纯代码文件链接](../lists/typetree1.6.txt#L20-L50)

---

## 标题2
![](/assets/svg/benchmarks.svg)

1. 1
	* a
	* b
		1. 1
		2. 2
2. 2
	* a
		* a
			* $x^2$

> 引用
> > 二级引用
> > * a

| 表格 | 第二个 |
| --- | --- |
| `a` | 1**+**2 |
| $b$ | 末尾 |

$$\sum_{i=1}^n i^{i+1}$$

!!! note
	note

!!! warn
	warn

!!! compat "DoctreePages v1.1"
	compat

```plain
plain
```

```jl
julia> begin foo(nothing,"$(Int)\n") end # comment

help?> 32+`15`#= =# @bar
```

```shell
$ activate vfs

vfs> init
initialized

vfs> quit
```

```insert-setting
type = "select-is"
content = "您是否是开发者？"
default = "no"
choices = {"yes"="是", "no"="否"}
store = {"yes"="is-developer","no"="!is-developer"}
```

```insert-fill
content = "1+1等于几？**允许末尾额外空格**"
ans = "2"
ans_regex = "^2 {0,}$"
```

```insert-test
[global]
name = "文档测试测试"
time_limit = 600
full_score = 10

[[parts]]
type = "choose"
content = "选择"
choices = ["a", "b", "c", "d"]
ans_dict = {"A"=1, "AB"=2, "ABC"=3, "ABCD"=4}

[[parts]]
type = "fill"
content = "3~5个空格"
ans_regex = "^ {3,5}$"
score = 6

[[parts]]
type = "text"
content = "文字"
```

```is-developer
欢迎开发者！
```

[^1]: footnote
[^2]: 脚注2
