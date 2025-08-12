# 元编程
Lisp 留给 Julia 最大的遗产就是它的元编程支持。和 Lisp 一样，Julia 把自己的代码表示为语言中的数据结构。既然代码被表示为了可以在语言中创建和操作的对象，程序就可以变换和生成自己的代码。这允许在没有额外构建步骤的情况下生成复杂的代码，并且还允许在 「语法树」 级别上运行的真正的 Lisp 风格的宏。与之相对的是预处理器「宏」系统（如 C 和 C++ 中的），它们在解析和解释代码之前进行文本操作和变换。由于 Julia 中的所有数据类型和代码都被表示为 Julia 的 数据结构，强大的 [reflection](https://en.wikipedia.org/wiki/Reflection_omputer_%28cprogramming%29) 功能可用于探索程序的内部及其类型，就像任何其他数据一样。

## 程序表示
每个 Julia 程序均以字符串开始：
```julia-repl
julia> prog = "1 + 1"
"1 + 1"
```

**接下来会发生什么？**

下一步是 **解析**（parse）每个字符串到一个称为表达式的对象，由 Julia 的类型 [`Expr`](expr.md) 表示，**这里的关键点是 Julia 的代码在内部表示为可以从语言本身访问的数据结构**。

## 表达式求值
给定一个表达式对象，可以使用 `eval` 使 Julia 在全局作用域内评估（执行）它：
```julia-repl
julia> ex1 = :(1 + 2)
:(1 + 2)

julia> eval(ex1)
3

julia> ex = :(a + b)
:(a + b)

julia> eval(ex)
ERROR: UndefVarError: b not defined
[...]

julia> a = 1; b = 2;

julia> eval(ex)
3
```

每个[模块](module.md)有自己的 `eval` 函数，该函数在其全局作用域内对表达式求值。传给 `eval` 的表达式不止可以返回值——它们还能改变封闭模块的环境状态
```julia-repl
julia> ex = :(x = 1)
:(x = 1)

julia> x
ERROR: UndefVarError: x not defined

julia> eval(ex)
1

julia> x
1
```

这里，表达式对象的求值导致一个值被赋值给全局变量 `x`。

由于表达式只是 `Expr` 对象，而其可以通过编程方式构造然后对它求值，因此可以动态地生成任意代码，然后使用 `eval` 运行所生成的代码。这是个简单的例子：
```julia-repl
julia> a = 1; ex = Expr(:call, :+, a, :b)
:(1 + b)

julia> a = 0; b = 2; eval(ex)
3
```

`a` 的值被用于构造表达式 `ex`，该表达式将函数 `+` 作用于值 1 和变量 `b`。请注意 `a` 和 `b` 使用方式间的重要区别：
* *变量* `a` 在表达式构造时的值在表达式中用作立即值。因此，在对表达式求值时，`a` 的值就无关紧要了：表达式中的值已经是 `1`，与 `a` 的值无关
* 另一方面，因为在表达式构造时用的是符号 `:b`，所以变量 `b` 的值无关紧要——`:b` 只是一个符号，变量 `b` 甚至无需被定义。然而，在表达式求值时，符号 `:b` 的值通过寻找变量 `b` 的值来解析

## 关于表达式的函数
如上所述，Julia 能在其内部生成和操作 Julia 代码，这是个非常有用的功能。我们已经见过返回 `Expr` 对象的函数例子：`parse` 函数，它接受字符串形式的 Julia 代码并返回相应的 `Expr`。函数也可以接受一个或多个 `Expr` 对象作为参数，并返回另一个 `Expr`。这是个简单的例子：
```julia-repl
julia> function math_expr(op, op1, op2)
           expr = Expr(:call, op, op1, op2)
           return expr
       end
math_expr (generic function with 1 method)

julia>  ex = math_expr(:+, 1, Expr(:call, :*, 4, 5))
:(1 + 4 * 5)

julia> eval(ex)
21
```

作为另一个例子，这个函数将数值参数加倍，但不处理表达式：
```julia-repl
julia> function make_expr2(op, opr1, opr2)
           opr1f, opr2f = map(x -> isa(x, Number) ? 2*x : x, (opr1, opr2))
           retexpr = Expr(:call, op, opr1f, opr2f)
           return retexpr
       end
make_expr2 (generic function with 1 method)

julia> make_expr2(:+, 1, 2)
:(2 + 4)

julia> ex = make_expr2(:+, 1, Expr(:call, :*, 5, 8))
:(2 + 5 * 8)

julia> eval(ex)
42
```

## 宏
[宏](macro.md)提供了一种机制，可以将生成的代码包含在程序的最终主体中。宏将一组参数映射到返回的 *表达式*，并且生成的表达式被直接编译，而不需要运行时 `eval` 调用。宏参数可能包括表达式、字面量和符号

## 生成函数
有个非常特殊的宏叫 `@generated`，它允许你定义所谓的*生成函数*。它们能根据其参数类型生成专用代码，与用多重派发所能实现的代码相比，其代码更灵活和/或少。虽然宏在解析时使用表达式且无法访问其输入值的类型，但是生成函数在参数类型已知时会被展开，但该函数尚未编译。

生成函数的声明不会执行某些计算或操作，而会返回一个被引用的表达式，接着该表达式构成参数类型所对应方法的主体。在调用生成函数时，其返回的表达式会被编译然后执行。为了提高效率，通常会缓存结果。为了能推断是否缓存结果，只能使用语言的受限子集。因此，生成函数提供了一个灵活的方式来将工作重运行时移到编译时，代价则是其构造能力受到更大的限制。

定义生成函数与普通函数有五个主要区别：
1. 使用 `@generated` 标注函数声明。这会向 AST 附加一些信息，让编译器知道这个函数是生成函数。
2. 在生成函数的主体中，你只能访问参数的*类型*，而不能访问其值，以及在生成函数的定义之前便已定义的任何函数。
3. 不应计算某些东西或执行某些操作，应返回一个*被引用的*表达式，它会在被求值时执行你想要的操作。
4. 生成函数只允许调用在生成函数定义之前定义的函数。（如果不遵循这一点，引用来自未来世界的函数可能会导致 `MethodErrors` ）
5. 生成函数不能*更改*或*观察*任何非常量的全局状态。（例如，其包括 IO、锁、非局部的字典或者使用 `hasmethod`）即它们只能读取全局常量，且没有任何副作用。换句话说，它们必须是纯函数。由于实现限制，这也意味着它们目前无法定义闭包或生成器。

举例子来说明这个是最简单的。我们可以将生成函数 `foo` 声明为
```julia-repl
julia> @generated function foo(x)
           Core.println(x)
           return :(x * x)
       end
foo (generic function with 1 method)
```

请注意，代码主体返回一个被引用的表达式，即 `:(x * x)`，而不仅仅是 `x * x` 的值。

从调用者的角度看，这与通常的函数等价；实际上，你无需知道你所调用的是通常的函数还是生成函数。让我们看看 `foo` 的行为：
```julia-repl
julia> x = foo(2);
Int64

julia> x
4

julia> y = foo("bar");
String

julia> y
"barbar"
```

因此，我们知道在生成函数的主体中，`x` 是所传递参数的*类型*，并且，生成函数的返回值是其定义所返回的被引用的表达式的求值结果，在该表达式求值时 `x` 表示其*值*。

如果我们使用我们已经使用过的类型再次对 `foo` 求值会发生什么？

```julia-repl
julia> foo(4)
16
```

请注意，这里并没有输出 `Int64`。我们可以看到对于特定的参数类型集来说，生成函数的主体只执行一次，且结果会被缓存。此后，对于此示例，生成函数首次调用返回的表达式被重新用作方法主体。但是，实际的缓存行为是由实现定义的性能优化，过于依赖此行为并不实际。

生成函数*可能*只生成一次函数,但也*可能*多次生成，或者看起来根本就没有生成过函数。因此，你应该*从不*编写有副作用的生成函数——因为副作用发生的时间和频率是不确定的。（对于宏来说也是如此——跟宏一样，在生成函数中使用 `eval` 也许意味着你正以错误的方式做某事。）但是，与宏不同，运行时系统无法正确处理对 `eval` 的调用，所以不允许这样做。

理解 `@generated` 函数与方法的重定义间如何相互作用也很重要。遵循正确的 `@generated` 函数不能观察任何可变状态或导致全局状态的任何更改的原则，我们看到以下行为。观察到，生成函数*不能*调用在生成函数本身的*定义*之前未定义的任何方法。

一开始 `f(x)` 有一个定义
```jl
f(x) = "original definition";
```

定义使用 `f(x)` 的其它操作：
```jl
g(x) = f(x);
@generated gen1(x) = f(x);
@generated gen2(x) = :(f(x));
```

我们现在为 `f(x)` 添加几个新定义：

```jl
f(x::Int) = "definition for Int";
f(x::Type{Int}) = "definition for Type{Int}";
```

并比较这些结果的差异：

```julia-repl
julia> f(1)
"definition for Int"

julia> g(1)
"definition for Int"

julia> gen1(1)
"original definition"

julia> gen2(1)
"definition for Int"
```

生成函数的每个方法都有自己的已定义函数视图：
```julia-repl
julia> @generated gen1(x::Real) = f(x); gen1(1)
"definition for Type{Int}"
```

上例中的生成函数 `foo` 能做的，通常的函数 `foo(x) = x * x` 也能做（除了在第一次调用时打印类型，并产生了更高的开销）。但是，生成函数的强大之处在于其能够根据传递给它的类型计算不同的被引用的表达式：
```julia-repl
julia> @generated function bar(x)
           if x <: Integer
               return :(x ^ 2)
           else
               return :(x)
           end
       end
bar (generic function with 1 method)

julia> bar(4)
16

julia> bar("baz")
"baz"
```

（当然，这个刻意的例子可以更简单地通过多重派发实现······）

滥用它会破坏运行时系统并导致未定义行为：
```julia-repl
julia> @generated function baz(x)
           if rand() < .9
               return :(x^2)
           else
               return :("boo!")
           end
       end
baz (generic function with 1 method)
```

由于生成函数的主体具有不确定性，其行为和*所有后续代码的行为*并未定义。

!!! warn
    不要复制这些例子！

这些例子有助于说明生成函数定义和调用的工作方式；但是，**不要复制它们**，原因如下：
* `foo` 函数有副作用（对 `Core.println` 的调用），并且未确切定义这些副作用发生的时间、频率和次数
* `bar` 函数解决的问题可通过多重派发被更好地解决——定义 `bar(x) = x` 和 `bar(x::Integer) = x ^ 2` 会做同样的事，但它更简单和快捷
* `baz` 函数是病态的

请注意，不应在生成函数中尝试的操作并无严格限制，且运行时系统现在只能检测一部分无效操作。还有许多操作只会破坏运行时系统而没有通知，通常以微妙的方式而非显然地与错误的定义相关联。因为函数生成器是在类型推导期间运行的，所以它必须遵守该代码的所有限制。

一些不应该尝试的操作包括：
1. 缓存本地指针。
2. 以任何方式与 `Core.Compiler` 的内容或方法交互。
3. 观察任何可变状态。
    * 生成函数的类型推导可以在*任何*时候运行，包括你的代码正在尝试观察或更改此状态时。
4. 采用任何锁：你调用的 C 代码可以在内部使用锁（例如，调用 `malloc` 不会有问题，即使大多数实现在内部需要锁），但是不要试图在执行 Julia 代码时保持或请求任何锁。
5. 调用在生成函数的主体后定义的任何函数。对于增量加载的预编译模块，则放宽此条件，以允许调用模块中的任何函数。

那好，我们现在已经更好地理解了生成函数的工作方式，让我们使用它来构建一些更高级（和有效）的功能……

## 一个高级的例子
Julia 的 base 库有个内部函数 `sub2ind`，用于根据一组 n 重线性索引计算 n 维数组的线性索引——换句话说，用于计算索引 `i`，其可用于使用 `A[i]` 来索引数组 `A`，而不是用 `A[x,y,z,...]`。一种可能的实现如下：

```jl
function sub2ind_loop(dims::NTuple{N}, I::Integer...) where N
    ind = I[N] - 1
    for i = N-1:-1:1
        ind = I[i]-1 + dims[i]*ind
    end
    return ind + 1
end



julia> sub2ind_loop((3, 5), 1, 2)
4
```

用递归可以完成同样的事情：

```jl
sub2ind_rec(dims::Tuple{}) = 1;
sub2ind_rec(dims::Tuple{}, i1::Integer, I::Integer...) =
    i1 == 1 ? sub2ind_rec(dims, I...) : throw(BoundsError());
sub2ind_rec(dims::Tuple{Integer, Vararg{Integer}}, i1::Integer) = i1;
sub2ind_rec(dims::Tuple{Integer, Vararg{Integer}}, i1::Integer, I::Integer...) =
    i1 + dims[1] * (sub2ind_rec(Base.tail(dims), I...) - 1);



julia> sub2ind_rec((3, 5), 1, 2)
4
```

这两种实现虽然不同，但本质上做同样的事情：在数组维度上的运行时循环，将每个维度上的偏移量收集到最后的索引中。

然而，循环所需的信息都已嵌入到参数的类型信息中。因此，我们可以利用生成函数将迭代移动到编译期；用编译器的说法，我们用生成函数手动展开循环。代码主体变得几乎相同，但我们不是计算线性索引，而是建立计算索引的*表达式*：

```jl
@generated function sub2ind_gen(dims::NTuple{N}, I::Integer...) where N
    ex = :(I[$N] - 1)
    for i = (N - 1):-1:1
        ex = :(I[$i] - 1 + dims[$i] * $ex)
    end
    return :($ex + 1)
end



julia> sub2ind_gen((3, 5), 1, 2)
4
```

**这会生成什么代码？**

找出所生成代码的一个简单方法是将生成函数的主体提取到另一个（通常的）函数中：

```jl
@generated function sub2ind_gen(dims::NTuple{N}, I::Integer...) where N
    return sub2ind_gen_impl(dims, I...)
end

function sub2ind_gen_impl(dims::Type{T}, I...) where T <: NTuple{N,Any} where N
    length(I) == N || return :(error("partial indexing is unsupported"))
    ex = :(I[$N] - 1)
    for i = (N - 1):-1:1
        ex = :(I[$i] - 1 + dims[$i] * $ex)
    end
    return :($ex + 1)
end
```

我们现在可以执行 `sub2ind_gen_impl` 并检查它所返回的表达式：

```julia-repl
julia> sub2ind_gen_impl(Tuple{Int,Int}, Int, Int)
:(((I[1] - 1) + dims[1] * (I[2] - 1)) + 1)
```

因此，这里使用的方法主体根本不包含循环——只有两个元组的索引、乘法和加法/减法。所有循环都是在编译期执行的，我们完全避免了在执行期间的循环。因此，我们只需对每个类型循环*一次*，在本例中每个 `N` 循环一次（除了在该函数被多次生成的边缘情况——请参阅上面的免责声明）。

## 可选地生成函数
生成函数可以在运行时实现高效率，但需要编译时间成本：必须为具体的参数类型的每个组合生成新的函数体。通常，Julia 能够编译函数的「泛型」版本，其适用于任何参数，但对于生成函数，这是不可能的。这意味着大量使用生成函数的程序可能无法静态编译。

为了解决这个问题，语言提供用于编写生成函数的通常、非生成的替代实现的语法。应用于上面的 `sub2ind` 示例，它看起来像这样：
```jl
function sub2ind_gen(dims::NTuple{N}, I::Integer...) where N
    if N != length(I)
        throw(ArgumentError("Number of dimensions must match number of indices."))
    end
    if @generated
        ex = :(I[$N] - 1)
        for i = (N - 1):-1:1
            ex = :(I[$i] - 1 + dims[$i] * $ex)
        end
        return :($ex + 1)
    else
        ind = I[N] - 1
        for i = (N - 1):-1:1
            ind = I[i] - 1 + dims[i]*ind
        end
        return ind + 1
    end
end
```

在内部，这段代码创建了函数的两个实现：一个生成函数的实现，其使用 `if @generated` 中的第一个块，一个通常的函数的实现，其使用 `else` 块。在 `if @generated` 块的 `then` 部分中，代码与其它生成函数具有相同的语义：参数名称引用类型，且代码应返回表达式。可能会出现多个 `if @generated` 块，在这种情况下，生成函数的实现使用所有的 `then` 块，而替代实现使用所有的 `else` 块。

请注意，我们在函数顶部添加了错误检查。此代码对两个版本都是通用的，且是两个版本中的运行时代码（它将被引用并返回为生成函数版本中的表达式）。这意味着局部变量的值和类型在代码生成时不可用——用于代码生成的代码只能看到参数类型。

在这种定义方式中，代码生成功能本质上只是一种可选的优化。如果方便，编译器将使用它，否则可能选择使用通常的实现。这种方式是首选的，因为它允许编译器做出更多决策和以更多方式编译程序，还因为通常代码比由代码生成的代码更易读。但是，使用哪种实现取决于编译器实现细节，因此，两个实现的行为必须相同。

[^1]: https://docs.juliacn.com/latest/manual/metaprogramming/
