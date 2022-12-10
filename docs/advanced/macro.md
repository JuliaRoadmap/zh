# 宏
## 基础
这是一个非常简单的宏：
```julia-repl
julia> macro sayhello()
           return :( println("Hello, world!") )
       end

@sayhello (macro with 1 method)
```

宏在 Julia 的语法中有一个专门的字符 `@` (at-sign)，紧接着是其使用 `macro 名称 ... end` 形式来声明的唯一的宏名。在这个例子中，编译器会把所有的 `@sayhello` 替换成：
```jl
:( println("Hello, world!") )
```

当 `@sayhello` 在 REPL 中被输入时，解释器立即执行，因此我们只会看到计算后的结果：
```julia-repl
julia> @sayhello()
Hello, world!
```

现在，考虑一个稍微复杂一点的宏：
```jl
macro sayhello(name)
	return :( println("Hello, ", $name) )
end
```

这个宏接受一个参数`name`。当遇到`@sayhello`时，quoted 表达式会被*展开*并将参数中的值插入到最终的表达式中：
```julia-repl
julia> @sayhello("human")
Hello, human
```

我们可以使用函数 `macroexpand` 查看引用的返回表达式（**重要提示：** 这是一个非常有用的调试宏的工具）：
```julia-repl
julia> ex = macroexpand(Main, :(@sayhello("human")) )
:(Main.println("Hello, ", "human"))

julia> typeof(ex)
Expr
```

我们可以看到 `"human"` 字面量已被插入到表达式中了

还有一个宏`@macroexpand`，它可能比 `macroexpand` 函数更方便：
```julia-repl
julia> @macroexpand @sayhello "human"
:(println("Hello, ", "human"))
```

## 为什么需要宏
我们已经在上一节中看到了一个函数 `f(::Expr...) -> Expr`。 其实`macroexpand`也是这样一个函数。那么，为什么会要设计宏呢？
宏是必需的，因为它们在解析代码时执行，因此，宏允许程序员在运行完整程序*之前*生成定制代码的片段。为了说明差异，请考虑以下示例：
```julia-repl
julia> macro twostep(arg)
           println("I execute at parse time. The argument is: ", arg)
           return :(println("I execute at runtime. The argument is: ", $arg))
       end

@twostep (macro with 1 method)

julia> ex = macroexpand(Main, :(@twostep :(1, 2, 3)) );
I execute at parse time. The argument is: :((1, 2, 3))
```

第一个 `println` 调用在调用 `macroexpand` 时执行。生成的表达式*只*包含第二个 `println`：
```julia-repl
julia> typeof(ex)
Expr

julia> ex
:(println("I execute at runtime. The argument is: ", $(Expr(:copyast, :($(QuoteNode(:((1, 2, 3)))))))))

julia> eval(ex)
I execute at runtime. The argument is: (1, 2, 3)
```

## 宏的调用
宏的通常调用语法如下：
```jl
@name expr1 expr2 ...
@name(expr1, expr2, ...)
```

请注意，在宏名称前的标志 `@`，且在第一种形式中参数表达式间没有逗号，而在第二种形式中 `@name` 后没有空格。这两种风格不应混淆。例如，下列语法不同于上述例子；它把元组 `(expr1, expr2, ...)` 作为参数传给宏：

```jl
@name (expr1, expr2, ...)
```

在数组字面量（或推导式）上调用宏的另一种方法是不使用括号直接并列两者。在这种情况下，数组将是唯一的传给宏的表达式。以下语法等价（且与 `@name [a b] * v` 不同）：

```jl
@name[a b] * v
@name([a b]) * v
```

在这着重强调，宏把它们的参数作为表达式、字面量或符号接收。浏览宏参数的一种方法是在宏的内部调用 `show` 函数：
```julia-repl
julia> macro showarg(x)
           show(x)
           # ... remainder of macro, returning an expression
       end
@showarg (macro with 1 method)

julia> @showarg(a)
:a

julia> @showarg(1+1)
:(1 + 1)

julia> @showarg(println("Yo!"))
:(println("Yo!"))
```

除了给定的参数列表，每个宏都会传递名为 `__source__` 和 `__module__` 的额外参数。

参数 `__source__` 提供 `@` 符号在宏调用处的解析器位置的相关信息（以 `LineNumberNode` 对象的形式）。这使得宏能包含更好的错误诊断信息，其通常用于日志记录、字符串解析器宏和文档，比如，用于实现 `@__LINE__`、`@__FILE__` 和 `@__DIR__` 宏

引用 `__source__.line` 和 `__source__.file` 即可访问位置信息：

```julia-repl
julia> macro __LOCATION__(); return QuoteNode(__source__); end
@__LOCATION__ (macro with 1 method)

julia> dump(
            @__LOCATION__(
       ))
LineNumberNode
  line: Int64 2
  file: Symbol none
```

参数 `__module__` 提供宏调用展开处的上下文相关信息（以 `Module` 对象的形式）。这允许宏查找上下文相关的信息，比如现有的绑定，或者将值作为附加参数插入到一个在当前模块中进行自我反射的运行时函数调用中。

## 构建高级的宏
这是 Julia 的 `@assert` 宏的*简化*定义：
```julia-repl
julia> macro assert(ex)
           return :( $ex ? nothing : throw(AssertionError($(string(ex)))) )
       end
@assert (macro with 1 method)
```

这个宏可以像这样使用：
```julia-repl
julia> @assert 1 == 1.0

julia> @assert 1 == 0
ERROR: AssertionError: 1 == 0
```

宏调用在解析时扩展为其返回结果，并替代已编写的语法。这相当于编写：
```jl
1 == 1.0 ? nothing : throw(AssertionError("1 == 1.0"))
1 == 0 ? nothing : throw(AssertionError("1 == 0"))
```

也就是说，在第一个调用中，表达式 `:(1 == 1.0)` 拼接到测试条件槽中，而 `string(:(1 == 1.0))` 拼接到断言信息槽中。如此构造的表达式会被放置在发生 `@assert` 宏调用处的语法树。然后在执行时，如果测试表达式的计算结果为真，则返回 `nothing`，但如果测试结果为假，则会引发错误，表明声明的表达式为假。请注意，将其编写为函数是不可能的，因为能获取的只有条件的*值*而无法在错误信息中显示计算出它的表达式。

在 Julia Base 中，`@assert` 的实际定义更复杂。它允许用户可选地制定自己的错误信息，而不仅仅是打印断言失败的表达式。与函数一样，具有可变数量的参数（ 变参函数）可在最后一个参数后面用省略号指定：
```julia-repl
julia> macro assert(ex, msgs...)
           msg_body = isempty(msgs) ? ex : msgs[1]
           msg = string(msg_body)
           return :($ex ? nothing : throw(AssertionError($msg)))
       end
@assert (macro with 1 method)
```

现在`@assert` 有两种操作模式，这取决于它接收到的参数数量！如果只有一个参数，`msgs` 捕获的表达式元组将为空，并且其行为与上面更简单的定义相同。 但是现在如果用户指定了第二个参数，它会打印在消息正文中而不是不相等的表达式中。你可以使用恰当命名的 [`@macroexpand`](@ref) 宏检查宏展开的结果：
```julia-repl
julia> @macroexpand @assert a == b
:(if Main.a == Main.b
        Main.nothing
    else
        Main.throw(Main.AssertionError("a == b"))
    end)

julia> @macroexpand @assert a==b "a should equal b!"
:(if Main.a == Main.b
        Main.nothing
    else
        Main.throw(Main.AssertionError("a should equal b!"))
    end)
```

实际的 `@assert` 宏还处理了另一种情形：我们如果除了打印「a 应该等于 b」外还想打印它们的值？有人也许会天真地尝试在自定义消息中使用字符串插值，例如，`@assert a==b "a ($a) should equal b ($b)!"`，但这不会像上面的宏一样按预期工作。你能想到为什么吗？回想一下字符串插值，内插字符串会被重写为 `string` 的调用。比较：

```julia-repl
julia> typeof(:("a should equal b"))
String

julia> typeof(:("a ($a) should equal b ($b)!"))
Expr

julia> dump(:("a ($a) should equal b ($b)!"))
Expr
  head: Symbol string
  args: Array{Any}((5,))
    1: String "a ("
    2: Symbol a
    3: String ") should equal b ("
    4: Symbol b
    5: String ")!"
```

所以，现在宏在 `msg_body` 中获得的不是单纯的字符串，其接收了一个完整的表达式，该表达式需进行求值才能按预期显示。这可作为 `string` 调用的参数直接拼接到返回的表达式中；有关完整实现，请参阅 [源代码](https://github.com/JuliaLang/julia/blob/master/base/error.jl)

`@assert` 宏充分利用拼接被引用的表达式，以便简化对宏内部表达式的操作。

## 卫生宏
在更复杂的宏中会出现关于[卫生宏](https://en.wikipedia.org/wiki/Hygienic_macro) 的问题。简而言之，宏必须确保在其返回表达式中引入的变量不会意外地与其展开处周围代码中的现有变量相冲突。相反，作为参数传递给宏的表达式通常被*认为*在其周围代码的上下文中进行求值，与现有变量交互并修改之。另一个问题源于这样的事实：宏可以在不同于其定义所处模块的模块中调用。在这种情况下，我们需要确保所有全局变量都被解析到正确的模块中。Julia 比使用文本宏展开的语言（比如 C）具有更大的优势，因为它只需要考虑返回的表达式。所有其它变量（例如上面`@assert` 中的 `msg`）遵循[通常的作用域块规则](../basic/scope.md)

为了演示这些问题，让我们来编写宏 `@time`，其以表达式为参数，记录当前时间，对表达式求值，再次记录当前时间，打印前后的时间差，然后以表达式的值作为其最终值。该宏可能看起来就像这样：
```jl
macro time(ex)
    return quote
        local t0 = time_ns()
        local val = $ex
        local t1 = time_ns()
        println("elapsed time: ", (t1-t0)/1e9, " seconds")
        val
    end
end
```

在这里，我们希望 `t0`、`t1` 和 `val` 成为私有临时变量，并且我们希望 `time_ns` 引用 Julia Base 中的 `time_ns` 函数，而不是任何用户可能拥有的 `time_ns` 变量（同样适用于 `println`）。 想象一下，如果用户表达式 `ex` 还包含对名为 `t0` 的变量的赋值，或者定义了自己的 `time_ns` 变量，可能会出现什么问题：程序可能会报错，或者进行未知的行为。

Julia 的宏展开器通过以下方式解决了这些问题。 首先，宏结果中的变量分为局部变量或全局变量。 如果变量被赋值（并且不是声明为全局的）、声明为局部、或用作函数参数名称，则该变量被视为局部变量。 否则，它被认为是全局的。 然后将局部变量重命名为唯一的（使用 `gensym` 函数，该函数生成新符号），并在宏定义环境中解析全局变量。 因此，上述两个问题都得到了处理； 宏的局部变量不会与任何用户变量冲突，并且 `time_ns` 和 `println` 将引用 Julia Base 定义。

然而，仍有另外的问题。考虑此宏的以下用法：
```jl
module MyModule
import Base.@time
time_ns() = ... # compute something
@time time_ns()
end
```

这里的用户表达式`ex` 是对`time_ns` 的调用，但与宏使用的`time_ns` 函数不同。它清楚地指向`MyModule.time_ns`。 因此我们必须安排在宏调用环境中解析`ex`中的代码。 这是通过使用 `esc` *转义*表达式来完成的：
```jl
macro time(ex)
    ...
    local val = $(esc(ex))
    ...
end
```

以这种方式封装的表达式会被宏展开器单独保留，并将其简单地逐字粘贴到输出中。因此，它将在宏调用所处环境中解析。

这种转义机制可以在必要时用于「违反」卫生，以便于引入或操作用户变量。例如，以下宏在其调用所处环境中将 `x` 设置为零：

```jl
macro zerox()
	return esc(:(x = 0))
end

function foo()
	x = 1
	@zerox
	return x
end

julia> foo()
0
```

应当明智地使用这种变量操作，但它偶尔会很方便。

获得正确的规则也许是个艰巨的挑战。在使用宏之前，你可以去考虑是否函数闭包便已足够。另一个有用的策略是将尽可能多的工作推迟到运行时。例如，许多宏只是将其参数封装为 `QuoteNode` 或类似的 `Expr`。这方面的例子有 `@task body`，它只返回 `schedule(Task(() -> $body))`， 和 `@eval expr`，它只返回 `eval(QuoteNode(expr))`。

为了演示，我们可以将上面的 `@time` 示例重新编写成：
```jl
macro time(expr)
    return :(timeit(() -> $(esc(expr))))
end

function timeit(f)
    t0 = time_ns()
    val = f()
    t1 = time_ns()
    println("elapsed time: ", (t1-t0)/1e9, " seconds")
    return val
end
```

但是，我们不这样做也是有充分理由的：将 `expr` 封装在新的作用域块（该匿名函数）中也会稍微改变该表达式的含义（其中任何变量的作用域），而我们想要 `@time` 使用时对其封装的代码影响最小。

## 宏与派发
与 Julia 函数一样，宏也是泛型的。由于多重派发，这意味着宏也能有多个方法定义：
```jl
macro m end

macro m(args...)
	println("$(length(args)) arguments")
end

macro m(x, y)
	println("Two arguments")
end

julia> @m "asd"
1 arguments

julia> @m 1 2
Two arguments
```

但是应该记住，宏派发基于传递给宏的 AST 的类型，而不是 AST 在运行时进行求值的类型：
```julia-repl
julia> macro m(::Int)
           println("An Integer")
       end
@m (macro with 3 methods)

julia> @m 2
An Integer

julia> x = 2
2

julia> @m x
1 arguments
```

## 代码生成
当需要大量重复的样板代码时，为了避免冗余，通常以编程方式生成它。在大多数语言中，这需要一个额外的构建步骤以及生成重复代码的独立程序。在 Julia 中，表达式插值和 `eval` 允许在通常的程序执行过程中生成这些代码。例如，考虑下列自定义类型
```jl
struct MyNumber
	x::Float64
end
```

我们想为该类型添加一些方法。在下面的循环中，我们以编程的方式完成此工作：
```jl
for op = (:sin, :cos, :tan, :log, :exp)
	eval(quote
		Base.$op(a::MyNumber) = MyNumber($op(a.x))
	end)
end
```

现在，我们对自定义类型调用这些函数：

```julia-repl
julia> x = MyNumber(π)
MyNumber(3.141592653589793)

julia> sin(x)
MyNumber(1.2246467991473532e-16)

julia> cos(x)
MyNumber(-1.0)
```

在这种方法中，Julia 充当了自己的[预处理器](https://en.wikipedia.org/wiki/Preprocessor)，并且允许从语言内部生成代码。使用 `:` 前缀的引用形式编写上述代码会使其更简洁：

```jl
for op = (:sin, :cos, :tan, :log, :exp)
    eval(:(Base.$op(a::MyNumber) = MyNumber($op(a.x))))
end
```

不管怎样，这种使用 `eval(quote(...))` 模式生成语言内部的代码很常见，为此，Julia 自带了一个宏来缩写该模式：
```jl
for op = (:sin, :cos, :tan, :log, :exp)
    @eval Base.$op(a::MyNumber) = MyNumber($op(a.x))
end
```

`@eval` 重写此调用，使其与上面的较长版本完全等价。为了生成较长的代码块，可以把一个代码块作为表达式参数传给 `@eval`：
```jl
@eval begin
    # 多行
end
```

## 非标准字符串字面量
回想一下在[字符串](../basic/string.md)的文档中，以标识符为前缀的字符串字面量被称为非标准字符串字面量，它们可以具有与未加前缀的字符串字面量不同的语义。例如：
* `r"^\s*(?:#|$)"` 产生一个[正则表达式对象](regex.md)而不是一个字符串
* `b"DATA\xff\u2200"` 是一个字节数组字面量，表示`[68, 65, 84, 65, 255, 226, 136, 128]`

可能令人惊讶的是，这些行为并没有被硬编码到 Julia 的解释器或编译器中。相反，它们是由一个通用机制实现的自定义行为，且任何人都可以使用该机制：带前缀的字符串字面量被解析为特定名称的宏的调用。例如，正则表达式宏如下：
```jl
macro r_str(p)
    Regex(p)
end
```

这便是全部代码。这个宏说的是字符串字面量 `r"^\s*(?:#|$)"` 的字面内容应该传给宏 `@r_str`，并且展开后的结果应当放在该字符串字面量出现处的语法树中。换句话说，表达式 `r"^\s*(?:#|$)"` 等价于直接把下列对象放进语法树中：
```jl
Regex("^\\s*(?:#|\$)")
```

字符串字面量形式不仅更短、更方便，也更高效：因为正则表达式需要编译，`Regex` 对象实际上是*在编译代码时*创建的，所以编译只发生一次，而不是每次执行代码时都再编译一次。请考虑如果正则表达式出现在循环中：
```jl
for line = lines
    m = match(r"^\s*(?:#|$)", line)
    if m === nothing
        # non-comment
    else
        # comment
    end
end
```

因为正则表达式 `r"^\s*(?:#|$)"` 在这段代码解析时便已编译并被插入到语法树中，所以它只编译一次，而不是每次执行循环时都再编译一次。要在不使用宏的情况下实现此效果，必须像这样编写此循环：
```jl
re = Regex("^\\s*(?:#|\$)")
for line = lines
	m = match(re, line)
	if m === nothing
	else
	end
end
```

此外，如果编译器无法确定在所有循环中正则表达式对象都是常量，可能无法进行某些优化，使得此版本的效率依旧低于上面的更方便的字面量形式。当然，在某些情况下，非字面量形式更方便：如果需要向正则表达式中插入变量，就必须采用这种更冗长的方法；如果正则表达式模式本身是动态的，可能在每次循环迭代时发生变化，就必须在每次迭代中构造新的正则表达式对象。然而，在绝大多数用例中，正则表达式不是基于运行时的数据构造的。在大多数情况下，将正则表达式编写为编译期值的能力是无法估量的。

用户定义字符串文字的机制非常强大。不仅使用它实现了 Julia 的非标准字面量，而且还使用以下看起来无害的宏实现命令行字面量语法（``` `echo "Hello, $person"` ```）：
```jl
macro cmd(str)
    :(cmd_gen($(shell_parse(str)[1])))
end
```

当然，这个宏的定义中使用的函数隐藏了许多复杂性，但它们只是函数且完全用 Julia 编写。你可以阅读它们的源代码并精确地看到它们的行为——它们所做的一切就是构造要插入到你的程序的语法树的表达式对象。

与字符串字面量一样，命令行字面量也可以以标识符为前缀，以形成所谓的非标准命令行字面量。 这些命令行字面量被解析为对特殊命名的宏的调用。 例如，语法 ```custom`literal` ``` 被解析为 `@custom_cmd "literal"`。 Julia 本身不包含任何非标准的命令行字面量，但包可以使用这种语法。 除了不同的语法和 `_cmd` 后缀而不是 `_str` 后缀，非标准命令行字面量的行为与非标准字符串字面量完全一样。

如果两个模块提供了同名的非标准字符串或命令字面量，能使用模块名限定该字符串或命令字面量。例如，如果 `Foo` 和 `Bar` 提供了相同的字符串字面量 `@x_str`，那么可以编写 `Foo.x"literal"` 或 `Bar.x"literal"` 来消除两者的歧义。


以下是另一种定义宏的方式：
```jl
macro foo_str(str, flag)
    # do stuff
end
```

可以使用如下语法来调用这个宏
```jl
foo"str"flag
```

上述语法中 flag 的类型可以是一个 `String`，表示在字符串字面量之后包含的内容
