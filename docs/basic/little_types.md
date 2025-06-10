# 一些轻量类型
## 无
类型 `Nothing` 具有的唯一值是 `nothing`。
它对应 `C` 中的 `void`，也广泛用于普通变量的初始化、保留值等。

`nothing` 会被 REPL 显示为空：
```julia-repl
julia> "a"; nothing

julia> x = nothing
```

## 未定义
类型名为 `UndefInitializer`，通常用于数组初始化，可以用 `undef` 作为 `UndefInitializer()` 的缩写，[详细信息见此](../advanced/undef.md)。

## 元组
`Tuple` 类型的实例可以容纳任意有限多个数据，这在你不希望[创建新类型](../advanced/struct.md#复合类型)，而又想表达有一定复杂性的数据时显得尤为方便。对于更复杂的情况，则可以使用[](../advanced/typesystem.md#具名元组类型)。
```julia-repl
julia> tup = (1,2,3)
(1, 2, 3)

julia> typeof(tup) # 这表明 tup 的 3 个参数类型均为 Int64
Tuple{Int64, Int64, Int64}

julia> Tuple{Vararg{Int64, 3}} # 一种仅对 Tuple 有效的简写方式
Tuple{Int64, Int64, Int64}

julia> isa(tup, NTuple{3, Int}) # 另一种写法
true

julia> tup[1] # 获取第一个数据
1

julia> (1,2,3) == (1,2,4) # 多个元素比较的一种简便方法
false
```

除了按照索引获取数据外，还可以使用以下语法糖
```julia-repl
julia> a,b,c = (1,2,3)
(1, 2, 3)

julia> (a,b,c) = (1,2,3)
(1, 2, 3)

julia> _,d,_ = (1,2,3) # _ 不是合规的变量名，在此语法中表示缺失
(1, 2, 3)

julia> d
2
```

## 对
```julia-repl
julia> pair = Pair(1, 2)
1 => 2

julia> pair.first
1

julia> pair.second
2
```

注意不要将元组与对搞混

## 共用
可以使用 `Union{Type1, Type2...}` 声明一个新[类型](../advanced/typesystem.md)，它的实例是 `Type1`、`Type2`……之一。
```julia-repl
julia> MyType = Union{Bool,Int,Float64}
Union{Bool, Int64}

julia> isa(true, MyType)
true
```

## missing nothing undef 的区分
* `missing` 一般用于三值逻辑或在概率统计中，表明这个值是缺失的
* `undef` 用于数组的初始化，如 `Array{Float64,2}(undef, 4, 4)`，表示直接使用分配的内存里原先的数据
* `nothing` 一般用于表明函数没有返回值或参数不设定默认值

`nothing` 和 `missing` 具体的处理取决于工具箱内部的实现 [^1]

[^1]: https://discourse.juliacn.com/t/topic/6282/3
