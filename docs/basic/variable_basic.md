# 变量简介
Julia 有丰富的**变量（variable）**类型，包括但不限于整数、浮点数、字符串、指针。它也是一种弱类型语言，允许同一变量前后的类型不同。

等等，你是不是想问“变量”是什么？
简单来说，变量是使用一个名称（称为“变量名”）与一个值进行绑定。
这个变量名所代表的值是可变的，即在一段代码前后绑定的值可以不同。

可以在 REPL 中尝试以下示例：

变量的**初始化（initialize）**与**赋值（assign）**。
```julia-repl
julia> v = 1
1
```

变量的读取与改变。
```julia-repl
julia> v
1

julia> v += 1
2
```

支持的更多操作。
```julia-repl
julia> v="var" # 改变类型
"var"

julia> 变量=1 # 变量名允许中文！
1

julia> 变量=sqrt # 函数也可以是变量
sqrt (generic function with 19 methods)

julia> 变量(4)
2.0
```

在上述例子中，`v = 1` 也可写作 `v=1` 甚至 `v=	1`。
在使用 `=`，`+` 这样的语法符号时，空格的多少对于程序正确运行无关紧要，只会影响美观性。
为提升代码美观性采取的选择称为“风格”。

!!! tips
	Julia 暂时不支持变量删除，如果有占空间的变量希望删除，可以赋值为 [nothing](little_types.md#无)，之后通过 `GC.gc` 回收，参考[此帖](https://discourse.juliacn.com/t/topic/6316)。

## 变量命名
变量名是区分大小写的。
```julia-repl
julia> a=0
0

julia> A=1
1
```

变量值查看。可以利用[元组](./little_types.md#元组)特性实现同时显示多个变量的内容。
```julia-repl
julia> a
0

julia> a, A
(0, 1)
```

可以使用 [Unicode](../knowledge/unicode.md) 字符作为变量名（允许大部分 Unicode 字符，包括大部分中文字符），但不允许变量名与[关键字](../lists/keywords.md)相同。

```julia-repl
julia> for=1
ERROR: syntax: unexpected "="
```

在 REPL 和一些其它的环境中，很多 Unicode 数学符号可以通过键入 `\` 加 [`LaTeX`](../knowledge/latex.md) 符号名，再按 `tab` 打出。

```julia-repl
julia> α=1 # \alpha<tab>
1

help?> α̂₂ # 你从别的地方复制过来一个字符，不知道怎么打可以用help模式
"α̂₂" can be typed by \alpha<tab>\hat<tab>\_2<tab>
...
```

如果有需要，Julia 甚至允许你重定义内置常量和函数。（这样做可能引发潜在的混淆，所以并**不推荐**）
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
**常量（constant）**是程序中原则上值不能被改变的量。
它可以被用于指示「圆周率」这种固定的值，或者「你程序的默认标题」这种运行时不会去改变的量。

你可以在变量名前加 `const` + 空格来表示常量。
```julia-repl
julia> const c=0
0

julia> c=1
WARNING: redefinition of constant c. This may fail, cause incorrect answers, or produce other errors.
```

!!! note
	变量具有[作用域](scope.md)。

## 练习
- 给名为“变量”的变量赋值 7，然后显示 `cos(变量)` 的值。

## 技巧
假设你手上现在有 2 个数字变量 `x` 和 `y`，如何交换它们的值？

你可能会想到这样的做法
```jl
x = y
y = x
```

这对吗？执行完 `x = y` 后，`x` 的值即变为了 `y` 的值，那么第二步就没有意义了。

最直接的想法是使用中间变量存储值：
```jl
t = x
x = y
y = t
```

以后您会看到更多技巧性的方法，此处不再阐述。

[^1]: https://docs.juliacn.com/latest/manual/variables/
