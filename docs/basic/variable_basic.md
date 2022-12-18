# 变量简介
Julia 有丰富的变量类型，包括但不限于整数、浮点数、字符串、指针；是「弱类型语言」，允许同一变量前后类型不同。

```is-newbie
等等，你是不是想问“变量”是什么？
简单来说，变量是一个名称（“变量名”）与一个值的绑定。这个变量名所代表的值是可变的，即在一段代码前后绑定的值可以不同。
```

请在 REPL 中尝试以下示例
```julia-repl
julia> v=1 # 初始化(initialize)、赋值(assign)
1

julia> v # 读取值
1

julia> v+=1 # 改变值
2

julia> v="var" # 改变类型
"var"

julia> 变量=1 # 变量名允许中文！
1

julia> 变量=sqrt # 函数也可以是变量
sqrt (generic function with 19 methods)

julia> 变量(4)
2.0
```

!!! tips
	Julia 暂时不支持变量删除，如果有占空间的变量希望删除，可以赋值为[nothing](little_types.md#无)

## 变量命名
变量名区分大小写：
```julia-repl
julia> a=0
0

julia> A=1
1

julia> a, A # 一种方便的查看方式
(0, 1)
```

可以使用 UTF-8 编码的 Unicode 字符作为变量名（允许大部分 Unicode 字符，包括大部分中文字符），但不允许使用[关键字](../lists/keywords.md)

```julia-repl
julia> for=1
ERROR: syntax: unexpected "="
Stacktrace:
 [1] top-level scope
   @ none:1
```

在REPL和一些其它的环境中，很多Unicode数学符号可以通过键入 `\` 加 [`LaTeX`](../packages/markdown.md#LaTeX) 符号名，再按 `tab` 打出

```julia-repl
julia> α=1 # \alpha<tab>
1

help?> α̂₂ # 你从别的地方复制过来一个字符，不知道怎么打可以用help模式
"α̂₂" can be typed by \alpha<tab>\hat<tab>\_2<tab>
...
```

如果有需要，Julia 甚至允许你重定义内置常量和函数。（这样做可能引发潜在的混淆，所以并**不推荐**）\
然而，不允许重定义一个已经在使用中的内置常量或函数
```julia-repl
julia> sin=0
0

julia> cos(0)
1.0

julia> cos=0
ERROR: cannot assign a value to variable Base.cos from module Main
```

## 命名规范
应尽量遵循以下官方提供的命名规范
* 对于变量
	* 若用英文，变量名应首字母小写，用下划线分隔名字中的单词，但是不鼓励使用，除非不使用下划线时名字非常难读
* 对于[类型](../advanced/struct.md)和[模块](../advanced/module.md)
	* 若用英文，名字应以大写字母开头，并且用大写字母而不是用下划线分隔单词
* 对于[函数](function.md)和[宏](../advanced/macro.md)
	* 若用英文，名字用小写，不使用下划线
	* 会对参数进行更改的函数使用`!`结尾

## 常量
你可以在变量名前加 `const ` 表示常量，常量的值原则上不能被改变
```julia-repl
julia> const c=0
0

julia> c=1
WARNING: redefinition of constant c. This may fail, cause incorrect answers, or produce other errors.
```

!!! note
	变量存在[作用域](scope.md)

```is-newbie
## 练习
- 试给名为 ℕ 的变量赋值 7
```

---

[^1]: https://docs.juliacn.com/latest/manual/variables/
