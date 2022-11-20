# 范围
## UnitRange
利用 `:` 语法糖或调用 `UnitRange`，可以生成一个从 `start` 到 `stop`，包含其中所有整数的范围
```jl
julia> unit=1:3
1:3

julia> unit.start
1

julia> unit.stop
3

julia> for i in unit println(i) end
1
2
3

julia> "miao"[unit]
"mia"
```

## StepRange
生成一个 `start` 到 `stop`，步长为 `step` 的范围
```jl
julia> st=1:2:4 # 自我修复
1:2:3

julia> for i in st println(i) end
1
3
```

## LinRange
生成一个 `start` 到 `stop`，均匀切分（包括端点）为 `len` 段的范围
```jl
julia> lin=LinRange(1,4,5)
5-element LinRange{Float64}:
 1.0,1.75,2.5,3.25,4.0
```

## range
原型是 `range(start[, stop]; length, stop, step=1)`，可以生成需求、适当的范围
