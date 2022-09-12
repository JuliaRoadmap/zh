# 表达式
`Expr` 对象包含两个部分：

第一：一个标识表达式类型的 `head` 类型为 `Symbol`，是一个 [interned string](https://en.wikipedia.org/wiki/String_interning) 标识符（下面会有更多讨论）

```jl
julia> ex1 = Meta.parse("1 + 1")
:(1 + 1)

julia> typeof(ex1)
Expr

julia> ex1.head
:call
```

第二：参数 `args`，可能是符号、其他表达式或字面量：

```jl
julia> ex1.args
3-element Vector{Any}:
  :+
 1
 1
```

表达式也可能直接用前置表达式形式构造：
```jl
julia> ex2 = Expr(:call, :+, 1, 1)
:(1 + 1)
```

上面构造的两个表达式 – 一个通过解析构造一个通过直接构造 – 是等价的：
```jl
julia> ex1 == ex2
true
```

`dump` 可以带有缩进和注释地显示 `Expr` 对象：
```jl
julia> dump(ex2)
Expr
  head: Symbol call
  args: Array{Any}((3,))
    1: Symbol +
    2: Int64 1
    3: Int64 1
```

`Expr` 对象也可以嵌套：
```jl
julia> ex3 = Meta.parse("(4 + 4) / 2")
:((4 + 4) / 2)
```

另外一个查看表达式的方法是使用 `Meta.show_sexpr`，它能显示给定 `Expr` 的 [S-expression](https://en.wikipedia.org/wiki/S-expression)，对 Lisp 用户来说，这看着很熟悉。下面是一个示例，阐释了如何显示嵌套的 `Expr`：

```jl
julia> Meta.show_sexpr(ex3)
(:call, :/, (:call, :+, 4, 4), 2)
```

## 符号
字符 `:` 在 Julia 中有两个作用。第一种形式构造一个 `Symbol`，这是作为表达式组成部分的一个 `interned string`：
```jl
julia> s = :foo
:foo

julia> typeof(s)
Symbol
```

构造函数 `Symbol` 接受任意数量的参数并通过把它们的字符串表示连在一起创建一个新的符号：
```jl
julia> :foo == Symbol("foo")
true

julia> Symbol("func", 10)
:func10

julia> Symbol(:var, '_', "sym")
:var_sym
```

注意，要使用 `:` 语法，符号的名称必须是有效的标识符。否则，必须使用 `Symbol(str)` 构造函数。

在表达式的上下文中，符号用来表示对变量的访问；当一个表达式被求值时，符号会被替换为这个符号在合适的 [作用域](../basic/scope.md) 中所绑定的值

有时需要在 `:` 的参数两边加上额外的括号，以避免在解析时出现歧义：
```jl
julia> :(:)
:(:)

julia> :(::)
:(::)
```

## 引用
`:` 的第二个语义是不显式调用 `Expr` 构造器来创建表达式对象。这被称为*引用*。`:` 后面跟着包围着单个 Julia 语句括号，可以基于被包围的代码生成一个 `Expr` 对象。下面是一个引用算数表达式的例子：
```jl
julia> ex = :(a+b*c+1)
:(a + b * c + 1)

julia> typeof(ex)
Expr
```

为了查看这个表达式的结构，可以试一试 `ex.head` 和 `ex.args`，或使用 `dump`

注意等价的表达式也可以使用 `Meta.parse` 或者直接用 `Expr` 构造：
```jl
julia>      :(a + b*c + 1)       ==
       Meta.parse("a + b*c + 1") ==
       Expr(:call, :+, :a, Expr(:call, :*, :b, :c), 1)
true
```

解析器提供的表达式通常只有符号、其它表达式和字面量值作为其参数，而由 Julia 代码构造的表达式能以非字面量形式的任意运行期值作为其参数。在此特例中，`+` 和 `a` 都是符号，`*(b,c)` 是子表达式，而 `1` 是 64 位带符号整数字面量

引用多个表达式有第二种语法形式：在 `quote ... end` 中包含代码块
```jl
julia> ex = quote
           x = 1
           y = 2
           x + y
       end
quote
    #= none:2 =#
    x = 1
    #= none:3 =#
    y = 2
    #= none:4 =#
    x + y
end

julia> typeof(ex)
Expr
```

## 插值
使用值参数直接构造 `Expr` 对象虽然很强大，但与*通常的*Julia 语法相比，`Expr` 构造函数可能让人觉得乏味。作为替代方法，Julia 允许将字面量或表达式插入到被引用的表达式中。表达式插值由前缀 `$` 表示

在此示例中，插入了变量 `a` 的值：
```jl
julia> a = 1;

julia> ex = :($a + b)
:(1 + b)
```

对未被引用的表达式进行插值是不支持的，这会导致编译期错误：
```jl
julia> $a + b
ERROR: syntax: "$" expression outside quote
```

在此示例中，元组 `(1,2,3)` 作为表达式插入到条件测试中：

```jl
julia> ex = :(a in $((1,2,3)) )
:(a in (1, 2, 3))
```

在表达式插值中使用 `$` 是有意让人联想到字符串插值和命令插值。表达式插值使得复杂 Julia 表达式的程序化构造变得方便和易读。

## Splatting 插值
请注意，`$` 插值语法只允许插入单个表达式到包含它的表达式中。有时，你手头有个由表达式组成的数组，需要它们都变成其所处表达式的参数，而这可通过 `$(xs...)` 语法做到。例如，下面的代码生成了一个函数调用，其参数数量通过编程确定：
```jl
julia> args = [:x, :y, :z];
julia> :(f(1, $(args...)))
:(f(1, x, y, z))
```

## 嵌套引用
自然地，引用表达式可以包含在其它引用表达式中。插值在这些情形中的工作方式可能会有点难以理解。考虑这个例子：
```jl
julia> x = :(1 + 2);

julia> e = quote quote $x end end
quote
    #= none:1 =#
    $(Expr(:quote, quote
    #= none:1 =#
    $(Expr(:$, :x))
end))
end
```

注意到表达式中含有 `$x`，这意味着`x`还未被`评估(evaluate)`。换句话说，`$`表达式属于内部引用表达式，因此使用如下方法时
```jl
julia> eval(e)
quote
    #= none:1 =#
    1 + 2
end
```

但是通过多个 `$` 也可以实现在外部 `quote` 表达式将值插入到内部引用表达式的 `$` 中去
```jl
julia> e = quote quote $$x end end
quote
    #= none:1 =#
    $(Expr(:quote, quote
    #= none:1 =#
    $(Expr(:$, :(1 + 2)))
end))
end
```

```jl
julia> eval(e)
quote
    #= none:1 =#
    3
end
```

这种行为背后的直觉是每个 `$` 都将 `x` 求值一遍：一个 `$` 工作方式类似于 `eval(:x)`，其返回 `x` 的值，而两个 `$` 行为相当于 `eval(eval(:x))`。

### QuoteNode
`quote` 形式在 AST 中通常表示为一个 head 为 `:quote` 的 `Expr`
```jl
julia> dump(Meta.parse(":(1+2)"))
Expr
  head: Symbol quote
  args: Array{Any}((1,))
    1: Expr
      head: Symbol call
      args: Array{Any}((3,))
        1: Symbol +
        2: Int64 1
        3: Int64 2
```

正如我们所看到的，这些表达式支持插值符号 `$`。但是，在某些情况下，需要在*不执行*插值的情况下引用代码。这种引用还没有语法，但在内部表示为 `QuoteNode` 类型的对象：
```jl
julia> eval(Meta.quot(Expr(:$, :(1+2))))
3

julia> eval(QuoteNode(Expr(:$, :(1+2))))
:($(Expr(:$, :(1 + 2))))
```

解析器为简单的引用项（如符号）生成 `QuoteNode`：
```jl
julia> dump(Meta.parse(":x"))
QuoteNode
  value: Symbol x
```

`QuoteNode` 也可用于某些高级的元编程任务
