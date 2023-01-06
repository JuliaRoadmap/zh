# Query的使用
此包用于方便地操作[DataFrame数据](dataframes.md)
!!! warn
	本文档未经过审查，可能存在错误或过时用法

query 操作起始于宏 `@from`，第一个参数 i 代表着 df 中每一行来执行 query 命令，df 代表数据源，`@where` 执行过滤（filter）指令，`@select` 指令将源数据的列映射为新的列，后方接的是 `{}`，代表具名元组；
`@collect` 决定了返回的数据结构类型。当没有这一项时，返回的是一个 julia 标准的迭代数据类型；collect 后面不接类型时，返回一个 Array
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
