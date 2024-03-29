# 集合
`Set` 具备类似于数学中集合的无序性，而为其它操作提升了效率

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
