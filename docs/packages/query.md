# Query
此包用于方便地操作 [DataFrame 数据](dataframes.md)
!!! warn
	本文档未经过审查，可能存在错误或过时用法

Query 操作通常从宏 `@from` 开始：第一个参数 `i` 表示遍历 `df` 的每一行，`df` 表示数据源；`@where` 用于过滤（filter），`@select` 用于把源列映射为新列，后接 `{}` 表示返回具名元组。
`@collect` 决定返回的数据结构类型。不写 `@collect` 时，返回 Julia 标准的惰性迭代结果；写 `@collect` 但不指定类型时，默认返回 `Array`。
```julia-repl
julia> using DataFrames, Query

julia> df = DataFrame(name=["John", "Sally", "Roger"],
                      age=[54., 34., 79.],
                      children=[0, 2, 4])
3×3 DataFrame
│ Row │ name   │ age     │ children │
│     │ String │ Float64 │ Int64    │
├─────┼────────┼─────────┼──────────┤
│ 1   │ John   │ 54.0    │ 0        │
│ 2   │ Sally  │ 34.0    │ 2        │
│ 3   │ Roger  │ 79.0    │ 4        │

julia> q1 = @from i in df begin
            @where i.age > 40
            @select {number_of_children=i.children, i.name}
            @collect DataFrame
       end
2×2 DataFrame
│ Row │ number_of_children │ name   │
│     │ Int64              │ String │
├─────┼────────────────────┼────────┤
│ 1   │ 0                  │ John   │
│ 2   │ 4                  │ Roger  │

julia> q2 = @from i in df begin # 无@collect项
                   @where i.age > 40
                   @select {number_of_children=i.children, i.name}
              end;

julia> total_children = 0
0

julia> for i in q2
           global total_children += i.number_of_children
       end

julia> total_children
4

julia> y = [i.name for i in q2 if i.number_of_children > 0]
1-element Array{String,1}:
 "Roger"

julia> q3 = @from i in df begin
            @where i.age > 40 && i.children > 0
            @select i.name
            @collect
       end # 返回一个 Array类型
1-element Array{String,1}:
 "Roger"
```

[^1]: https://github.com/noob-data-analaysis/data-analysis/blob/master/%5B%E6%95%B0%E6%8D%AE%E8%8E%B7%E5%BE%97DataFrames%5D%40Andy.Yang/DataFrames.md
