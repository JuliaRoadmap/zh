# 变量引用机制
对于[可变复合类型](struct.md#可变复合类型)（使用 `ismuttable` 判断），在赋值与传参时使用引用机制。
考虑以下代码：
```julia-repl
julia> x = [1, 2, 3];

julia> y = x;

julia> x = [4, 5, 6];

julia> y
3-element Vector{Int64}:
 1
 2
 3
```

再考虑如下代码
```julia-repl
julia> x = [1, 2, 3];

julia> y = x;

julia> x[1] = 0;

julia> y
3-element Vector{Int64}:
 0
 2
 3
```

第一例中，在 `x = [1, 2, 3]` 时，首先数据被分配到某个位置（记作 `h1`），然后创建 `x` 作为 `h1` 的引用/绑定

![](../../assets/svg/varref-1.svg)

`y = x` 意图将 y 指向 x 对应的数据，实际也是 `h1` 的引用

![](../../assets/svg/varref-2.svg)

`x = [4, 5, 6]` 操作产生新的数据块并更改 x 的绑定，而这不会影响到 y

![](../../assets/svg/varref-3.svg)

而第二例的操作改变了 `h1` 里的数据，显得 y “同步更改”了

## 拷贝
`copy` 函数可以对数组进行**浅拷贝**（shallow-copy），这只会复制外壳而不会复制内部数据。
```julia-repl
julia> a = [MS(0)]
1-element Vector{MS}:
 MS(0)

julia> b = copy(a)
1-element Vector{MS}:
 MS(0)

julia> push!(b, MS(1)); a
1-element Vector{MS}:
 MS(0)

julia> b[1].v = 1; a
1-element Vector{MS}:
 MS(1)
```

`deepcopy` 函数可以对物体进行**深拷贝（deep-copy）**，这会复制内部所有数据。

## 更新不可变值
有时使用与改变可变值相同的方法去更新不可变值是必要的。

利用 [Accessors.jl](https://github.com/JuliaObjects/Accessors.jl)，你可以更新不可变类型变量的指定字段。
