# 复合类型
`struct` 关键字与复合类型一起引入，后跟一个标明一系列**字段/域（field）**名称的块，使用 `::` 运算符注明类型（不注明认为 `::Any`）
```jl
struct Foo
	bar
	baz::Int
	qux::Float64
end
```

没有类型注释的字段默认为 `Any` 类型，所以可以包含任何类型的值。
类型为 `Foo` 的新对象通过将 `Foo` 类型对象像函数一样应用于其字段的值来创建：
```julia-repl
julia> foo = Foo("Hello, world.", 23, 1.5)
Foo("Hello, world.", 23, 1.5)

julia> typeof(foo)
Foo
```

像函数一样使用的类型称为**构造函数（constructor）**。有两个构造函数已被自动生成（这些构造函数称为**默认构造函数**）。其中一个接受任何参数并调用 `convert` 函数将它其转换为字段的类型，另一个接受与字段类型完全匹配的参数。两者都生成的原因是，这使得更容易添加新定义而不会在无意中替换默认构造函数。
由于 `bar` 字段在类型上不受限制，因此传入任何值都可以。但是 `baz` 的值必须可转换为 `Int` 类型：
```julia-repl
julia> Foo((), 23.5, 1)
ERROR: InexactError: Int64(23.5)
Stacktrace:
...
```

可以使用 `fieldnames` 函数找到已知类型的字段名称列表：
```julia-repl
julia> fieldnames(Foo)
(:bar, :baz, :qux)
```

可以使用 `foo.bar` 表示法访问复合对象的字段值，而这实际上会调用 `getproperty` 函数，因此可以自由定义“伪字段”。
想要直接获取字段，可以调用 `getfield`
```julia-repl
julia> foo.bar
"Hello, world."

julia> foo.baz
23

julia> foo.qux
1.5
```

用 `struct` 声明的复合对象是*不可变的*；创建后不能修改。乍一看这似乎很奇怪，但它有几个优点：
* 更高效。某些 `struct` 可以被高效地打包到数组中，并且在某些情况下，编译器可以避免完全分配不可变对象
* 不可能违反类型构造函数提供的不变性
* 使用不可变对象的代码更容易推理

不可变对象可以包含可变对象（比如数组）作为字段。那些被包含的对象将保持可变；只是不可变对象本身的字段不能更改为指向不同的对象

## 可变复合类型
如果使用 `mutable struct` 而不是 `struct` 声明复合类型，则它的实例可以被修改：
```julia-repl
julia> mutable struct Bar
           baz
           qux::Float64
       end
julia> bar = Bar("Hello", 1.5);

julia> bar.qux = 2.0
2.0

julia> bar.baz = 1//2
1//2
```

为了支持修改，这种对象通常分配在堆上，并且具有稳定的内存地址。可变对象就像一个小容器，随着时间的推移，可能保持不同的值，因此只能通过其地址可靠地识别。\
相反地，不可变类型的实例与特定字段值相关——仅字段值就告诉你该对象的所有内容。在决定是否使类型为可变类型时，请询问具有相同字段值的两个实例是否被视为相同，或者它们是否可能需要随时间独立更改。如果它们被认为是相同的，该类型就应该是不可变的。

总结一下，Julia 的两个基本属性定义了不变性：
* 不允许修改不可变类型的值。
	* 对于[纯数据类型](ref.md#纯数据类型)，这意味着值的位模式一旦设置将不再改变，并且该值是位类型的标识
	* 对于复合类型，这意味着其字段值的标识将不再改变。当字段是位类型时，这意味着它们的位将不再改变，对于其值是可变类型（如数组）的字段，这意味着字段将始终引用相同的可变值，尽管该可变值的内容本身可能被修改。
* 具有不可变类型的对象可以被编译器自由复制，因为其不可变性使得不可能以编程方式区分原始对象和副本。
	* 特别地，这意味着足够小的不可变值（如整数和浮点数）通常在寄存器（或栈分配）中传递给函数。
	* 另一方面，可变值是堆分配的，并作为指向堆分配值的指针传递给函数，除非编译器确定没有办法知道这不是正在发生的事情。

## 字段
创建单个字段的复合类型的行为有时称为**包裹（wrap）**。

没有字段的不可变复合类型称为*单例类型*。正式地，如果
1. `T` 是一个不可变的复合类型
1. `a isa T && b isa T` 暗含 `a === b`

那么 `T` 是单例类型。`Base.issingletontype`可以用来检查一个类型是否是单例类型。抽象类型不能通过构造成为单例类型。

根据定义，此类类型只能有一个实例：
```julia-repl
julia> struct NoFields
       end
julia> NoFields() === NoFields()
true
julia> Base.issingletontype(NoFields)
true
```

`===` 函数确认 `NoFields` 的构造实例实际上是一个且相同的

当上述条件成立时，参数类型可以是单例类型，例如
```julia-repl
julia> struct NoFieldsParam{T}
       end
julia> Base.issingletontype(NoFieldsParam)
false

julia> NoFieldsParam{Int}() isa NoFieldsParam
true

julia> Base.issingletontype(NoFieldsParam{Int})
true

julia> NoFieldsParam{Int}() === NoFieldsParam{Int}()
true
```

### 相关函数
| 名称 | 描述 |
| --- | --- |
| fieldnames | 获取复合类型的全部字段名（`::Tuple{Symbol}`） |
| fieldname | 获取复合类型的第 i 个字段名（`::Symbol`） |
| fieldcount | 获取复合类型的字段数 |
| fieldtypes | 获取复合类型的全部字段类型 |
| fieldtype | 获取复合类型的第 i 个字段类型 |
| fieldoffset | 获取第 i 个字段相对于数据开头的偏移字节数 |
| dump | 显示类型或其实例的信息 |
| getfield | 获取指定字段数据 [不是.](function.md#具有特殊名称的操作符) |
| setfield! | 设置指定字段数据 [不是.=](function.md#具有特殊名称的操作符) |

## 构造函数
构造函数是用来创建新对象的函数——确切地说，它创建的是指定复合类型的实例，名称与目标类型名称相同
```julia-repl
julia> struct Foo
           bar
           baz
       end

julia> foo = Foo(1, 2)
Foo(1, 2)

julia> foo.bar
1

julia> foo.baz
2
```

### 默认构造函数
但在没有任何特别的构造函数声明的情况下，有两种默认方式可以创建新的复合对象，一种是显式地给出类型参数，另一种是通过传给对象构造函数的参数隐式地推断出\
由于 `Point{Float64}` 类型等价于在 `Point` 声明时用 `Float64` 替换 `T` 得到的具体类型，它可以相应地作为构造函数使用
```julia-repl
julia> p = Point{Float64}(1.0, 2.0)
Point{Float64}(1.0, 2.0)

julia> typeof(p)
Point{Float64}
```

对于默认的构造函数，必须为每个字段提供一个参数：
```julia-repl
julia> Point{Float64}(1.0)
ERROR: MethodError: no method matching Point{Float64}(::Float64)
...

julia> Point{Float64}(1.0,2.0,3.0)
ERROR: MethodError: no method matching Point{Float64}(::Float64, ::Float64, ::Float64)
...
```

参数类型只生成一个默认的构造函数，因为它无法覆盖。这个构造函数接受任何参数并将它们转换为字段的类型。

许多情况下，没有必要提供想要构造的 `Point` 对象的类型，因为构造函数调用参数的类型已经隐式地提供了类型信息。因此，你也可以将 `Point` 本身用作构造函数，前提是参数类型 `T` 的隐含值是明确的：
```julia-repl
julia> p1 = Point(1.0,2.0)
Point{Float64}(1.0, 2.0)

julia> typeof(p1)
Point{Float64}

julia> p2 = Point(1,2)
Point{Int64}(1, 2)

julia> typeof(p2)
Point{Int64}
```

在 `Point` 的例子中，当且仅当 `Point` 的两个参数类型相同时，`T` 的类型才确实是隐含的。如果不是这种情况，构造函数将失败并抛出`MethodError`
```julia-repl
julia> Point(1,2.5)
ERROR: MethodError: no method matching Point(::Int64, ::Float64)
Closest candidates are:
  Point(::T, !Matched::T) where T at none:2
```

### 外部构造方法
与 Julia 中的其他任何函数一样，构造函数的整体行为由其各个[方法](method.md)的组合行为定义。因此，只要定义新方法就可以向构造函数添加功能。例如，假设你想为 `Foo` 对象添加一个构造方法，该方法只接受一个参数并其作为 `bar` 和 `baz` 的值。这很简单
```julia-repl
julia> Foo(x) = Foo(x,x)
Foo

julia> Foo(1)
Foo(1, 1)
```

继续添加新的零参数构造方法：
```julia-repl
julia> Foo() = Foo(0)
Foo

julia> Foo()
Foo(0, 0)
```

这类构造方法的声明方式与普通的方法一样，被称为**外部**构造方法，只能通过调用其他构造方法来创建新实例，比如自动提供默认值的构造方法

## 内部构造方法
尽管外部构造方法可以成功地为构造对象提供了额外的便利，但它无法解决确保固有属性不变和允许创建自引用对象的问题。因此，我们需要**内部**构造方法，它有两点不同：
1. 内部构造方法在类型声明代码块的内部，而不是和普通方法一样在外部。
2. 内部构造方法能够访问一个特殊的局部函数`new`，此函数能够创建该类型的对象。

例如，假设你要声明一个保存一对实数的类型，但要约束第一个数不大于第二个数。你可以像这样声明它：
```jl
struct OrderedPair
	x::Real
	y::Real
	OrderedPair(x,y) = x > y ? error("顺序错啦") : new(x,y)
end
```

现在 `OrderedPair` 对象只能在 `x <= y` 时被成功构造：
```julia-repl
julia> OrderedPair(1, 2)
OrderedPair(1, 2)

julia> OrderedPair(2,1)
ERROR: 顺序错啦
...
```

如果类型被声明为 `mutable`，你可以直接更改字段值来打破这个固有属性，然而，在未经允许的情况下，随意摆弄对象的内核一般都是不好的行为。你（或者其他人）可以在以后任何时候提供额外的外部构造方法，但一旦类型被声明了，就没有办法来添加更多的内部构造方法了。由于外部构造方法只能通过调用其它的构造方法来创建对象，所以最终构造对象的一定是某个内部构造函数。这保证了已声明类型的对象必须通过调用该类型的内部构造方法才得已存在，从而在某种程度上保证了类型的固有属性。

只要定义了任何一个内部构造方法，Julia 就不会再提供默认的构造方法：它会假定你已经为自己提供了所需的所有内部构造方法。默认构造方法等效于一个你自己编写的内部构造函数，该函数将所有成员作为参数（如果相应的字段具有类型，则约束为正确的类型），并将它们传递给 `new`，最后返回结果对象：
```jl
struct Foo
	bar
	baz
	Foo(bar,baz) = new(bar,baz)
end
```

这个声明与前面没有显式内部构造方法的 `Foo` 类型的定义效果相同。
以下两个类型是等价的——一个具有默认构造方法，另一个具有显式构造方法：

```julia-repl
julia> struct T1
           x::Int64
       end

julia> struct T2
           x::Int64
           T2(x) = new(x)
       end

julia> T1(1)
T1(1)

julia> T2(1)
T2(1)

julia> T1(1.0)
T1(1)

julia> T2(1.0)
T2(1)
```

提供尽可能少的内部构造方法是一种良好的形式：仅在需要显式地处理所有参数，以及强制执行必要的错误检查和转换时候才使用内部构造。其它用于提供便利的构造方法，比如提供默认值或辅助转换，应该定义为外部构造函数，然后再通过调用内部构造函数来执行繁重的工作。这种解耦是很自然的。

### kwdef
如果你不想写很长的额外代码来提供默认值，也可以使用
```julia-repl
julia> Base.@kwdef struct Paper
       color::Symbol=:white
       text::String
       end
Paper

julia> Paper(;text="t")
Paper(:white, "t")
```

### 不完整初始化
最后一个还没提到的问题是，如何构造具有自引用的对象，更广义地来说是构造递归数据结构。由于这其中的困难并不是那么显而易见，这里我们来简单解释一下，考虑如下的递归类型声明：
```jl
mutable struct SelfReferential
	obj::SelfReferential
end
```

这种类型可能看起来没什么大不了，直到我们考虑如何来构造它的实例。
如果 `a` 是 `SelfReferential` 的一个实例，则第二个实例可以用如下的调用来创建：
```jl
b = SelfReferential(a)
```

但是，当没有实例存在的情况下，即没有可以传递给 `obj` 成员变量的有效值时，如何构造第一个实例？唯一的解决方案是允许使用未初始化的 `obj` 成员来创建一个未完全初始化的 `SelfReferential` 实例，并使用该不完整的实例作为另一个实例的 `obj` 成员的有效值，例如，它本身。

为了允许创建未完全初始化的对象，Julia 允许使用少于该类型成员数的参数来调用`new`函数，并返回一个具有某个未初始化成员的对象。然后，内部构造函数可以使用不完整的对象，在返回之前完成初始化。例如，我们在定义 `SelfReferential` 类型时采用了另一个方法，使用零参数内部构造函数来返回一个实例，此实例的 `obj` 成员指向其自身：
```jl
mutable struct SelfReferential
	obj::SelfReferential
	SelfReferential() = (x = new(); x.obj = x)
end
```

我们可以验证这一构造函数有效性，且由其构造的对象确实是自引用的：
```julia-repl
julia> x = SelfReferential();

julia> x === x
true

julia> x === x.obj
true

julia> x === x.obj.obj
true
```

虽然从一个内部构造函数中返回一个完全初始化的对象是很好的，但是也可以返回未完全初始化的对象：

```jl
mutable struct Incomplete
	data
	Incomplete() = new()
end
z = Incomplete();
```

尽管允许创建含有未初始化成员的对象，然而任何对未初始化引用的访问都会立即报错：
```julia-repl
julia> z.data
ERROR: UndefRefError: access to undefined reference
```

这避免了不断地检测 `null` 值的需要。然而，并不是所有的对象成员都是引用。Julia 会将一些类型当作[纯数据类型](ref.md#纯数据类型)。纯数据类型的初始值是未定义的，这一点类似于`UndefInitializer`
```julia-repl
julia> struct HasPlain
           n::Int
           HasPlain() = new()
       end

julia> HasPlain()
HasPlain(438103441441)
```

在内部构造函数中，也可以将不完整的对象传递给其它函数来委托其补全构造：
```jl
mutable struct Lazy
	data
	Lazy(v) = complete_me(new(), v)
end
```

与构造函数返回的不完整对象一样，如果 `complete_me` 或其任何被调用者尝试在初始化之前访问 `Lazy` 对象的 `data` 字段，就会立刻报错。

### 参数类型的构造函数
参数类型的存在为构造函数增加了更多的复杂性。首先，让我们回顾一下[参数类型](typesystem.md#参数复合类型)。在默认情况下，我们可以用两种方法来实例化参数复合类型，一种是显式地提供类型参数，另一种是让 Julia 根据构造函数输入参数的类型来隐式地推导类型参数。这里有一些例子：
```julia-repl
julia> struct Point{T<:Real}
           x::T
           y::T
       end

julia> Point(1,2) # 隐式的 T
Point{Int64}(1, 2)

julia> Point(1.0,2.5) # 隐式的 T
Point{Float64}(1.0, 2.5)

julia> Point(1,2.5) # 隐式的 T
ERROR: MethodError: no method matching Point(::Int64, ::Float64)
Closest candidates are:
  Point(::T, ::T) where T<:Real at none:2

julia> Point{Int64}(1, 2) # 显式的 T
Point{Int64}(1, 2)

julia> Point{Int64}(1.0,2.5) # 显式的 T
ERROR: InexactError: Int64(2.5)
Stacktrace:
...

julia> Point{Float64}(1.0, 2.5) # 显式的 T
Point{Float64}(1.0, 2.5)

julia> Point{Float64}(1,2) # 显式的 T
Point{Float64}(1.0, 2.0)
```

就像你看到的那样，用类型参数显式地调用构造函数，其参数会被转换为指定的类型：`Point{Int64}(1,2)` 可以正常工作，但是 `Point{Int64}(1.0,2.5)` 则会在将 `2.5` 转换为 `Int64`时抛出`InexactError`。当类型是从构造函数的参数隐式推导出来的时候，比如在例子 `Point(1,2)` 中，输入参数的类型必须一致，否则就无法确定 `T` 是什么，但 `Point` 的构造函数仍可以适配任意同类型的实数对

实际上，这里的 `Point`，`Point{Float64}` 以及 `Point{Int64}` 是不同的构造函数。`Point{T}` 表示对于每个类型 `T` 都存在一个不同的构造函数。如果不显式提供内部构造函数，在声明复合类型 `Point{T<:Real}` 的时候，Julia 会对每个满足 `T<:Real` 条件的类型都提供一个默认的内部构造函数 `Point{T}`，它们的行为与非参数类型的默认内部构造函数一致。Julia 同时也会提供了一个通用的外部构造函数 `Point`，用于适配任意同类型的实数对。Julia 默认提供的构造函数等价于下面这种显式的声明：
```julia-repl
julia> struct Point{T<:Real}
           x::T
           y::T
           Point{T}(x,y) where {T<:Real} = new(x,y)
       end

julia> Point(x::T, y::T) where {T<:Real} = Point{T}(x,y);
```

注意，每个构造函数定义的方式与调用它们的方式是一样的。调用 `Point{Int64}(1,2)` 会触发 `struct` 块内部的 `Point{T}(x,y)`。另一方面，外部构造函数声明的 `Point` 构造函数只会被同类型的实数对触发，它使得我们可以直接以 `Point(1,2)` 和 `Point(1.0,2.5)` 这种方式来创建实例，而不需要显示地使用类型参数。由于此方法的声明方式已经对输入参数的类型施加了约束，像 `Point(1,2.5)` 这种调用自然会导致 "no method" 错误。

假如我们想让 `Point(1,2.5)` 这种调用方式正常工作，比如，通过将整数 `1` 自动「提升」为浮点数 `1.0`，最简单的方法是像下面这样定义一个额外的外部构造函数：
```julia-repl
julia> Point(x::Int64, y::Float64) = Point(convert(Float64,x),y);
```

此方法使用 `convert` 函数将 `x` 显式转换为 `Float64`，然后在两个参数都是 `Float64` 的情况下使用通用的构造函数。通过这个方法定义，以前的抛出 `MethodError` 的代码现在可以成功地创建一个类型为 `Point{Float64}` 的点：
```julia-repl
julia> p = Point(1,2.5)
Point{Float64}(1.0, 2.5)

julia> typeof(p)
Point{Float64}
```

然而，其它类似的调用依然有问题：
```julia-repl
julia> Point(1.5,2)
ERROR: MethodError: no method matching Point(::Float64, ::Int64)
Closest candidates are:
  Point(::T, !Matched::T) where T<:Real at none:1
```

如果你想要找到一种方法可以使类似的调用都可以正常工作，请参阅[类型转换与类型提升](conpro.md)。这里稍稍“剧透”一下，我们可以利用下面的这个外部构造函数来满足需求，无论输入参数的类型如何，它都可以触发通用的 `Point` 构造函数：
```jl
Point(x::Real, y::Real) = Point(promote(x,y)...);
```

这里的 `promote` 函数会将它的输入转化为同一类型，在此例中是 `Float64`。定义了这个方法，`Point` 构造函数会自动提升输入参数的类型，且提升机制与算术运算符相同，比如 `+`，因此对所有的实数输入参数都适用：
```julia-repl
julia> Point(1.5,2)
Point{Float64}(1.5, 2.0)

julia> Point(1,1//2)
Point{Rational{Int64}}(1//1, 1//2)

julia> Point(1.0,1//2)
Point{Float64}(1.0, 0.5)
```

因此，虽然 Julia 中默认提供的隐式类型参数构造函数相当严格，但可以很容易地使它们以更轻松且明智的方式运行。 此外，由于构造函数可以利用类型系统、方法和多重派发的所有功能，因此定义复杂的行为通常非常简单。

## 示例学习：有理数
也许将所有这些部分联系在一起的最佳方法是展示参数复合类型及其构造方法的真实示例。 为此，我们实现了自己的有理数类型 `OurRational`，类似于 Julia 的内置 `Rational`（定义在 [`rational.jl`](https://github.com/JuliaLang/julia/blob/master/base/rational.jl)）
```jl
struct OurRational{T<:Integer} <: Real
    num::T # 分子
	den::T # 分母
	# 内部构造方法
	function OurRational{T}(num::T, den::T) where T<:Integer
		# 用于确定总是以这种规范化形式构造的
		if num == 0 && den == 0
			error("不允许 0//0")
		end
		num = flipsign(num, den)
		den = flipsign(den, den)
		g = gcd(num, den)
		num = div(num, g)
		den = div(den, g)
		new(num, den)
	end
end
# 外部构造方法
OurRational(n::T, d::T) where {T<:Integer} = OurRational{T}(n,d)

OurRational(n::Integer, d::Integer) = OurRational(promote(n,d)...)

OurRational(n::Integer) = OurRational(n,one(n))

#=
为 ⊘ 算符定义一系列的方法，之后就可以使用 `⊘` 算符来写分数，（比如 `1 ⊘ 2`）
在做上述定义之前，`⊘` 是一个无意的且未被定义的算符
定义之后，它的行为与在有理数一节中描述的一致——注意它的所有行为都是那短短几行定义的
=#
⊘(n::Integer, d::Integer) = OurRational(n,d)

⊘(x::OurRational, y::Integer) = x.num ⊘ (x.den*y)

⊘(x::Integer, y::OurRational) = (x*y.den) ⊘ y.num

#=
让 ⊘ 作用于复数，用来创建一个类型为 Complex{<:OurRational} 的对象——即一个实部和虚部都是分数的复数：
=#
⊘(x::Complex, y::Real) = complex(real(x) ⊘ y, imag(x) ⊘ y)

⊘(x::Real, y::Complex) = (x*y') ⊘ real(y*y')

function ⊘(x::Complex, y::Complex)
	xy = x*y'
	yy = real(y*y')
	complex(real(xy) ⊘ yy, imag(xy) ⊘ yy)
end



julia> z = (1 + 2im) ⊘ (1 - 2im);

julia> typeof(z)
Complex{OurRational{Int64}}

julia> typeof(z) <: Complex{<:OurRational}
true
```

## 仅外部的构造函数
正如我们所看到的，典型的参数类型都有一个内部构造函数，它仅在全部的类型参数都已知的情况下才会被调用。例如，可以用 `Point{Int}` 调用，但 `Point` 就不行。我们可以选择性的添加外部构造函数来自动推导并添加类型参数，比如，调用 `Point(1,2)` 来构造 `Point{Int}`。外部构造函数调用内部构造函数来实际创建实例。然而，在某些情况下，我们可能并不想要内部构造函数，从而达到禁止手动指定类型参数的目的。

例如，假设我们要定义一个类型用于存储向量以及其累加和：
```julia-repl
julia> struct SummedArray{T<:Number,S<:Number}
           data::Vector{T}
           sum::S
       end

julia> SummedArray(Int32[1; 2; 3], Int32(6))
SummedArray{Int32, Int32}(Int32[1, 2, 3], 6)
```

问题在于我们想让 `S` 的类型始终比 `T` 大，这样做是为了确保累加过程不会丢失信息。例如，当 `T` 是 `Int32` 时，我们想让 `S` 是 `Int64`。所以我们想要一种接口来禁止用户创建像 `SummedArray{Int32,Int32}` 这种类型的实例。一种实现方式是只提供一个 `SummedArray` 构造函数，当需要将其放入 `struct` 块中，从而不让 Julia 提供默认的构造函数：
```jl
struct SummedArray{T<:Number,S<:Number}
	data::Vector{T}
	sum::S
	function SummedArray(a::Vector{T}) where T
		S = widen(T)
		new{T,S}(a, sum(S, a))
	end
end



julia> SummedArray(Int32[1; 2; 3], Int32(6))
ERROR: MethodError: no method matching SummedArray(::Vector{Int32}, ::Int32)
Closest candidates are:
  SummedArray(::Vector{T}) where T at none:4
...
```

此构造函数将会被 `SummedArray(a)` 这种写法触发。`new{T,S}` 的这种写法允许指定待构建类型的参数，也就是说调用它会返回一个 `SummedArray{T,S}` 的实例。`new{T,S}` 也可以用于其它构造函数的定义中，但为了方便，Julia 会根据正在构造的类型自动推导出 `new{}` 花括号里的参数（如果可行的话）。

[^1]: https://docs.juliacn.com/latest/manual/types/
[^2]: https://docs.juliacn.com/latest/manual/constructors/
