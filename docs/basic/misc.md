# 查缺补漏
## 加载代码
可以通过`include(路径)`加载一个[路径](../knowledge/filesystem.md#路径)下的代码，如使用`include("foo.jl")`导入同目录下`foo.jl`中的代码

## ...
`...`除在函数定义时表示[不定参数](function.md#不定参数)外，还可表示将可以[遍历](../advanced/iterate.md)的东西展开
```jl
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
`Symbol`是一种类似于字符串的[不可变](../advanced/struct.md)类型，通常用于[元编程](../advanced/macro.md)或高效的存储
```jl
julia> :p
:p

julia> Symbol(":")
:(:)

julia> String(:p)
"p"
```

## docstring
创建一个新全局变量/函数/[类型](../advanced/typesystem.md)等时，可以在前面紧跟一个字符串，它会自动出现在帮助文档中
```jl
julia> "something" aaa=1
aaa

help?> aaa
search: aaa readavailable bytesavailable AbstractArray AbstractRange

  something
```

## 变量引用机制
你可能已经意识到了，一些函数（通常末尾带`!`）可以改变变量的值，而一些类型的实例总是无法改变\
参阅[语法进阶 - 变量引用机制](../advanced/varref.md)
