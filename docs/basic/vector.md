# 一维数组
Julia 内置了一维[**数组（array）**](../knowledge/array.md)（按作用可称**列表（list）**）。
它的类型名是 `Vector`，是[任意维数组 Array](array.md) 的一个特例。

## 赋值
```julia-repl
julia> [1, 2, 3] # 生成一个数组，其中的元素可以用undef表示不初始化
3-element Vector{Int64}:
 1
 2
 3

julia> zeros(Int, 3)
3-element Vector{Int64}:
 0
 0
 0

julia> ones(Int, 3)
3-element Vector{Int64}:
 1
 1
 1

julia> collect(1:4)
4-element Vector{Int64}:
 1
 2
 3
 4

julia> collect("a" => 1)
2-element Vector{Union{Int64, String}}:
  "a"
 1

julia> Vector{Int}(undef, 3) # 相当于C中未初始化的数组
3-element Vector{Int64}:
         1
 470028848
         1
```

## 索引/切片访问
基于**索引（index）**的访问是数组最基本的功能。
由于一维数列 `a` 的第 `i` 个元素在数学上记作 $a_i$，索引也被称为「下标」。

不同于部分语言的是，Julia 中的索引从 1 开始。
```julia-repl
julia> a = collect(1:10);

julia> a[2]
2

julia> a[2:5]
4-element Vector{Int64}:
 2
 3
 4
 5

julia> length(a) # 查看长度
10

julia> a[end] # 局部使用 end 表示 length(a)
10

julia> a[2]=20
20

julia> a[1:2]=[10,20]
2-element Vector{Int64}:
 10
 20

julia> a[:] # 表示范围整个范围，可以用于多维数组
10-element Vector{Int64}:
...
```

## 相关常用函数
!!! tips
	可以使用 `methodswith(Vector)` 获取 `Vector` 特有的相关函数列表。
	若希望查看所有可应用于 `Vector` 的函数，可使用 `methodswith(Vector;supertypes=true)`。

以下表格中，参数列表第一个均为 `v::Vector{T}`，将被省略

| 函数名 | 参数列表 | 描述 |
| :-: | :-: | :-: |
| `empty!` | | 清空 |
| `isempty` | | 是否为空 |
| `first` | | 获得第一个元素 |
| `popfirst!` | | 获得并弹出第一个元素 |
| `pushfirst!` | `items...` | 在v最前推入`items`，推入后顺序与`items`排列顺序一致 |
| `last` | | 获得最后一个元素 |
| `pop!` | | 获得并弹出最后一个元素 |
| `push!` | `items...` | 在v最后推入`items`，推入后顺序与`items`排列顺序一致 |
| `popat!` | `i::Integer, [default]` | 弹出v中第i个元素；若不存在则返回`default`（若有），抛出错误（若无） |
| `deleteat!` | `i::Integer` 或 长度与v相同的Bool数组 或 可以表明若干个索引的东西 | 删除指定的一个或多个数据 |
| `insert!` | `i::Integer, item` | 在`v[i]`前插入`item` |
| `append!` | `collections::AbstractVector{T}...` | 在末尾添加数组中的数据，顺序与传参顺序一致（对于添加多个数组的支持需要Julia 1.6） |
| `prepend!` | `collections::AbstractVector{T}...` | 在开头添加数组中的数据，顺序与传参顺序一致（对于添加多个数组的支持需要Julia 1.6） |
| `resize!` | `n::Integer` | 将v的长度修改为n，多截少[undef](../advanced/undef.md)补 |
| `sizehint!` | `n::Integer` | 建议v修改容纳范围至n以便之后使用 |
| `splice!` | `index, [replacement]` | 在给定位置移除并插入 |

## 边界检查
使用 `[]` 或类似方法访问时，Julia 会默认进行边界检查，若越界会抛出 `BoundsError`。
如果你十分确信需求范围在边界内，可以在前面加上 `@inbounds` 宏修饰。此时越界可能会得到错误结果或奔溃等。

## 向量点运算
Julia 中，每个二元运算符都有一个 “点” 运算符与之对应，例如 `^` 就有对应的 `.^` 存在。这个对应的 `.^` 被 Julia 自动地定义为逐元素地执行 `^` 运算。比如 `[1,2,3] ^ 3` 是非法的，因为数学上没有定义数组的立方。但 `[1,2,3] .^ 3` 在 Julia 里是合法的，它会逐元素地执行 `^` 运算（或称向量化运算），得到 `[1^3, 2^3, 3^3]`。类似地，`!` 或 `√` 这样的一元运算符，也都有一个对应的 `.√` 用于执行逐元素运算。
```julia-repl
julia> [1,2,3] .^ 3
3-element Vector{Int64}:
  1
  8
 27

julia> @. sqrt([1,2,3])
3-element Vector{Float64}:
 1.0
 1.4142135623730951
 1.7320508075688772
```

更确切地说，`a .^b` 被解析为 “点运算” 调用 `(^).(a,b)`，这会执行 [广播](https://docs.juliacn.com/latest/manual/arrays/#Broadcasting) 操作\
除了点运算符，我们还有逐点赋值运算符，类似 `a .+= b`。
将点运算符用于数值字面量可能会导致歧义，如`1.+x`，因此遇到这种情况时，必须明确地用空格消除歧义。[^1]

你可以阅读[相关日报](../blog/daily/about.md?search="向量化编程与广播")以深入了解

[^1]: https://docs.juliacn.com/latest/manual/mathematical-operations/#man-dot-operators
