# 迭代器
迭代器是一类为 `for ... in` 准备的，用于更方便控制遍历的工具。
`Iterators` 模块位于 `Base.Iterators`。

## eachindex
`eachindex` 通常用于得到数组索引的合适遍历工具。它比使用 `1:length(A)` 更有兼容性。

## enumerate
`enumerate` 遍历物品时，得到的值是一对 `(i, v)`，其中 `i` 是从 1 开始的计数器，`v` 是正常遍历物品得到的值。

## zip
`zip` 可用于合并多个可[遍历](iterate.md)的物品，一直遍历直到其中一个到达末尾
```julia-repl
julia> z = zip(1:3, "abcde")
zip(1:3, "abcde")

julia> length(z)
3

julia> first(z)
(1, 'a')

julia> collect(z)
3-element Vector{Tuple{Int64, Char}}:
 (1, 'a')
 (2, 'b')
 (3, 'c')
```

## filter
`filter` 用于生成满足特定要求的迭代器，需注意在使用时不与导出的另一个 `filter` 混淆
```julia-repl
julia> f = Iterators.filter(isodd, [1,2,3,4,5])
Base.Iterators.Filter{typeof(isodd), Vector{Int64}}(isodd, [1, 2, 3, 4, 5])

julia> collect(f)
3-element Vector{Int64}:
 1
 3
 5
```
