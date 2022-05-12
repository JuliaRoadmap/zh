# 函数
函数`Function`是一个特殊的超类型，它的子类型实例通过关键字`function`定义

## 基本格式
```jl
function 函数名(参数名1,参数名2)
    做些什么
    return 返回值
end

# 对于简单函数的简写
函数名(参数1,参数2)=表达式
```

最后的`return`可以不写，但可能造成阅读困难\
若无返回值，则返回[`nothing`](little_types.md#无)

你可以给参数名后加上`::类型名`（默认其实是`Any`型的）
```jl
julia> foo(x::Int)=3
foo (generic function with 1 method)

julia> foo(true)
ERROR: MethodError: no method matching foo(::Bool)
...
```

也可以在函数右括号后加上`::类型名`来标注返回值类型

## 默认值
函数参数允许提供默认值，但必须从后往前提供
```jl
julia> foo(x::Bool,y::Bool=true)=x
foo (generic function with 2 methods)

julia> bar(x::Bool=true,y::Bool)=x
ERROR: syntax: optional positional arguments must occur at end around REPL[3]:1
Stacktrace:
 [1] top-level scope
   @ REPL[3]:1
```

## 不定参数
可以在最后一个参数后加`...`，表示接受若干参数，作为元组类型传入
```jl
julia> bar(t::Int...)=print(t)
bar (generic function with 1 method)

julia> bar(1,2,3)
(1, 2, 3)
```

## 第二栏
你可以在上述一切后加一个`,`添加一栏，表示接受额外参数，例如`printstyled`的原型是
```jl
printstyled(xs...; bold::Bool=false, color::Union{Symbol,Int}=:normal)
```

在调用时，对于第二栏的参数，可以加一个`;`（或`,`），然后使用`参数名=值`，例如`printstyled(x;bold=true,color=:red)`

## 命名
- 允许的函数名与[允许的变量名](variable_basic.md#命名规范)相同
- 可以在函数名前加`模块名.`标注所属的模块
- 对于同模块中的同名函数，若第一栏参数个数和对应类型限制完全相同，后出现的会进行覆盖
```jl
julia> baz(x::Int;o=1)=print(x,o)
baz (generic function with 1 method)

julia> baz(x::Int)=print("new")
baz (generic function with 1 method)

julia> baz(1)
new
julia> baz(1;o=0)
10
```

## lambda表达式
一种常用于创建局部函数的方式是`lambda表达式` [相关知识](https://www.luogu.com.cn/blog/t532/church-encoding-and-lam-cal)\
它的格式是`(参数列表) -> 表达式`，为了方便，有时把表达式放入`begin ... end`
```jl
julia> f=(x::Int)->x+1
#2 (generic function with 1 method)

julia> f(3)
4
```

!!! note
    [如何组织函数](https://discourse.juliacn.com/t/topic/3190)\
    [如何重载+、==](https://discourse.juliacn.com/t/topic/5457)

## 练习
- LightLearn 5

[^1]: https://discourse.juliacn.com/t/topic/941?u=jun
