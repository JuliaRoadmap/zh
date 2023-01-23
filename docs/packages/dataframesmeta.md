# DataFramesMeta的使用
此包用于方便地操作 [DataFrame 数据](dataframes.md)
!!! warn
	本文档未经过审查，可能存在错误或过时用法
```julia-repl
julia> using DataFrames, DataFramesMeta

julia> df = DataFrame(name=["John", "Sally", "Roger"],
                      age=[54., 34., 79.],
                      children=[0, 2, 4]);
# 筛选 age 大于40的行，输出新列名为 number_of_childeren（原children列），name

julia> @linq df |>
           where(:age .> 40) |>
           select(number_of_children=:children, :name)
2×2 DataFrame
│ Row │ number_of_children │ name   │
│     │ Int64              │ String │
├─────┼────────────────────┼────────┤
│ 1   │ 0                  │ John   │
│ 2   │ 4                  │ Roger  │

julia> df = DataFrame(key=repeat(1:3, 4), value=1:12)
12×2 DataFrame
│ Row │ key   │ value │
│     │ Int64 │ Int64 │
├─────┼───────┼───────┤
│ 1   │ 1     │ 1     │
│ 2   │ 2     │ 2     │
│ 3   │ 3     │ 3     │
│ 4   │ 1     │ 4     │
│ 5   │ 2     │ 5     │
│ 6   │ 3     │ 6     │
│ 7   │ 1     │ 7     │
│ 8   │ 2     │ 8     │
│ 9   │ 3     │ 9     │
│ 10  │ 1     │ 10    │
│ 11  │ 2     │ 11    │
│ 12  │ 3     │ 12    │

julia> @linq df |>
           where(:value .> 3) |>
           by(:key, min=minimum(:value), max=maximum(:value)) |>
           select(:key, range=:max - :min)
3×2 DataFrame
│ Row │ key   │ range │
│     │ Int64 │ Int64 │
├─────┼───────┼───────┤
│ 1   │ 1     │ 6     │
│ 2   │ 2     │ 6     │
│ 3   │ 3     │ 6     │

julia> @linq df |>
           groupby(:key) |>
           transform(value0 = :value .- minimum(:value))
12×3 DataFrame
│ Row │ key   │ value │ value0 │
│     │ Int64 │ Int64 │ Int64  │
├─────┼───────┼───────┼────────┤
│ 1   │ 1     │ 1     │ 0      │
│ 2   │ 1     │ 4     │ 3      │
│ 3   │ 1     │ 7     │ 6      │
│ 4   │ 1     │ 10    │ 9      │
│ 5   │ 2     │ 2     │ 0      │
│ 6   │ 2     │ 5     │ 3      │
│ 7   │ 2     │ 8     │ 6      │
│ 8   │ 2     │ 11    │ 9      │
│ 9   │ 3     │ 3     │ 0      │
│ 10  │ 3     │ 6     │ 3      │
│ 11  │ 3     │ 9     │ 6      │
│ 12  │ 3     │ 12    │ 9      │
```

[^1]: https://github.com/noob-data-analaysis/data-analysis/blob/master/%5B%E6%95%B0%E6%8D%AE%E8%8E%B7%E5%BE%97DataFrames%5D%40Andy.Yang/DataFrames.md
