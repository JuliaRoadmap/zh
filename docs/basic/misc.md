# 查缺补漏
为了避免你遗漏一些重要的细节，在正式引入 `advanced` 节前（当然也可以就此停止），这里进行一些补充：

## 加载代码
可以通过 `include(路径)` 加载一个[路径](../knowledge/filesystem.md#路径)下的代码，如使用 `include("foo.jl")` 导入相对路径下 `foo.jl` 中的代码。这类似于 C 中的 `#include ""`。

这种加载相当于把那个文件中的代码复制到 `include` 所在位置，显然也是有返回值的。

## ...
`...` 语法除在函数定义时表示[不定参数](function.md#不定参数)外，还可表示将可以[遍历](../advanced/iterate.md)的东西展开
```julia-repl
julia> ([1,2,3]... , [4]...)
(1, 2, 3, 4)

julia> [1:3... , 1:2...]
5-element Vector{Int64}:
 1
 2
 3
 1
 2

julia> gcd((2,4,8)...)
2
```

## 符号
`Symbol` 是一种类似于字符串的[不可变](../advanced/struct.md)类型，通常用于[元编程](../advanced/meta.md)或高效的存储
```julia-repl
julia> :p
:p

julia> Symbol(":")
:(:)

julia> String(:p)
"p"
```

## docstring
当你创建一个新的全局变量/函数/[类型](../advanced/typesystem.md)等时，可以在前面紧跟一个字符串，它会自动出现在帮助文档中
```julia-repl
julia> "something" aaa=1
aaa

help?> aaa
search: aaa readavailable bytesavailable AbstractArray AbstractRange

  something
```

这种“前面紧跟”规则是预设的，也可以改变，可参阅[关于代码文档的更多内容](https://docs.juliacn.com/latest/manual/documentation/#man-documentation)。

## 变量引用机制
你可能已经意识到了，一些函数（通常末尾带 `!`）可以改变变量的值，而一些类型的实例却总是无法被改变的。关于这个，请参阅[语言进阶 - 变量引用机制](../advanced/varref.md)。
