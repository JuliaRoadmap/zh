# 集合
`Set` 用于存储集合的结构，即用于存储一些值，然后判断是否属于这个集合。

它具有类似于数学中集合的无序性，不能规定或查看元素的顺序（根据算法预测顺序和操作的关系是不可取的）。顺序功能的牺牲为其它操作提升了效率。

## 创建
使用 `Set(iter)` 从可遍历的物品中创建集合，也可用 `Set()` 创建空集。
```jl
A = Set([1, 2, 3])
B = Set([1, 2, 4, 5]);
```

## 操作
```julia-repl
julia> A==B
false

julia> A∪B
Set{Int64} with 5 elements:
  5
  4
  2
  3
  1

julia> A∩B
Set{Int64} with 2 elements:
  2
  1

julia> push!(A, 4)
Set{Int64} with 4 elements:
  4
  2
  3
  1

julia> pop!(B, 5)
5

julia> push!(B, 3)
Set{Int64} with 4 elements:
  4
  2
  3
  1

julia> A==B
true
```

查看完整操作表请调用 `methodswith(Set)`。
