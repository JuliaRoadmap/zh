# 函数
函数 `Function` 是一个特殊的超类型，它的子类型的实例通过关键字 `function` 定义

## 基本格式
```jl
function 函数名(参数名1, 参数名2)
    做些什么
    return 返回值
end

# 对于简单函数的简写
函数名(参数1, 参数2) = 表达式
```

最后的 `return` 可以不写，但可能造成阅读困难。
若不写返回值，则返回 [`nothing`](little_types.md#无)

``````check newbie
函数可以直接或间接地调用自身，这称为递归。
例如，你可以选择用递归方法计算 Fibonacci 数列：
```jl
function fib(i::Integer)
    @assert i>0
    if i<=2
        return 1
    else
        return fib(i-1)+fib(i-2)
    end
end
```

``````

## 参数类型
可以通过将 `::类型名称` 附加到参数名称来声明函数参数的类型（不标注默认是 `Any`）
```julia-repl
julia> foo(x::Int)=3
foo (generic function with 1 method)

julia> foo(true)
ERROR: MethodError: no method matching foo(::Bool)
...
```

参数类型声明**通常对性能没有影响**，在 Julia 中声明参数类型的最常见原因是
* **派发** 如 [方法](method.md) 中所述，对于不同的参数类型，你可以有不同版本（「方法」）的函数，在这种情况下，参数类型用于确定调用哪个版本的函数
* **正确性** 函数只为某些参数类型返回正确的结果
* **清晰性**

但是，**过分限制参数类型是常见的错误**，这会不必要地限制函数的适用性，并防止它在未预料到的情况下被重用。如有不确定，就省略参数类型

## 返回类型
也可以在右括号后使用 `::类型` 运算符在函数声明中指定返回类型。 这可以将返回值转换为指定的类型，这种做法**很少使用**：通常应该编写「类型稳定」的函数

## 默认值
函数参数允许提供默认值，但必须从后往前提供
```julia-repl
julia> foo(x::Bool, y::Bool=true)=x
foo (generic function with 2 methods)

julia> bar(x::Bool=true, y::Bool)=x
ERROR: syntax: optional positional arguments must occur at end around REPL[3]:1
Stacktrace:
 [1] top-level scope
   @ REPL[3]:1
```

## 不定参数
可以在最后一个参数后加 `...`，表示接受若干参数，作为元组类型传入
```julia-repl
julia> bar(t::Int...)=print(t)
bar (generic function with 1 method)

julia> bar(1,2,3)
(1, 2, 3)
```

## 第二栏
你可以在上述一切后加一个 `,` 添加一栏，表示接受额外参数，例如 `printstyled` 的原型是
```jl
printstyled(xs...; bold::Bool=false, color::Union{Symbol, Int}=:normal)
```

在调用时，对于第二栏的参数，可以加一个 `;`（或 `,`），然后使用 `参数名=值`，例如 `printstyled(x; bold=true, color=:red)`

## 命名
- 允许的函数名与[允许的变量名](variable_basic.md#命名规范)相同
- 可以在函数名前加`模块名.`标注所属的模块
- 对于同模块中的同名函数，若第一栏参数个数和对应类型限制完全相同，后出现的会进行覆盖
```julia-repl
julia> baz(x::Int; o=1) = print(x, o)
baz (generic function with 1 method)

julia> baz(x::Int) = print("new")
baz (generic function with 1 method)

julia> baz(1)
new
julia> baz(1; o=0)
10
```

## lambda表达式
一种常用于创建局部匿名函数的方式是 `lambda表达式`。
它的格式是 `(参数列表) -> 表达式`，为了方便，有时把表达式放入 `begin ... end`
```julia-repl
julia> f = (x::Int) -> x+1
#2 (generic function with 1 method)

julia> f(3)
4
```

## do
`do ... end` 可以创建一个匿名函数，并把它作为第一个参数传递给调用的函数
```julia-repl
julia> foo(f::Function, x)=f(x)
foo (generic function with 1 method)

julia> foo(3) do a
           return a+1
       end
4
```

## 参数传递行为
Julia 函数参数遵循有时称为「pass-by-sharing」的约定，这意味着变量在被传递给函数时其值并不会被复制。函数参数本身充当新的变量绑定（指向变量值的新地址），它们所指向的值与所传递变量的值完全相同。调用者可以看到对函数内可变值（如数组）的修改。这与 Scheme，大多数 Lisps，Python，Ruby 和 Perl 以及其他动态语言中的行为相同
```julia-repl
julia> function change!(x::Vector)
           x[1]=1
       end
change! (generic function with 1 method)

julia> v=[0]
1-element Vector{Int64}:
 0

julia> change!(v)
1

julia> v
1-element Vector{Int64}:
 1
```

## 更多阅读
以上所述远不是定义函数的完整图景。Julia 拥有一个复杂的类型系统并且允许对参数类型进行多重分派
- [函数进阶](../advanced/function.md)
- [类型系统](../advanced/typesystem.md)
- [方法](../advanced/method.md)
- [lambda 表达式在数学上的使用](https://www.luogu.com.cn/blog/t532/church-encoding-and-lam-cal)

## 参阅
- [如何组织函数](https://discourse.juliacn.com/t/topic/3190)
- [如何重载 +、==](https://discourse.juliacn.com/t/topic/5457)

```check newbie
## 练习
- LightLearn Standard 函数定义
- [Hydro H1032. 【模板】快速幂](https://hydro.ac/p/H1032)（用递归重写）
```

[^1]: https://docs.juliacn.com/latest/manual/functions/
