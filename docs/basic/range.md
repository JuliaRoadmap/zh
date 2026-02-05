# 范围类型
## UnitRange
使用语法糖 `start:stop` 或调用 `UnitRange(start, stop)`，可以生成一个从 `start` 到 `stop`，每步增加 1 的范围。
```julia-repl
julia> unit = 2:4
2:4

julia> (unit.start, unit.stop)
(2, 4)

julia> "red fox"[unit]
"ed "

julia> unit[2:3]
3:4

julia> collect(1.7:4.3)
3-element Vector{Float64}:
 1.7
 2.7
 3.7
```

不建议让填入的参数满足 `start > stop`

## StepRange
使用语法糖 `start:step:stop` 或调用 `UnitRange(start, step, stop)` 可以生成一个从 `start` 到 `stop`，步长为 `step` 的范围。
```julia-repl
julia> st = 20:7:40 # 自行修复 `stop` 值
20:7:34

julia> collect(st)
3-element Vector{Int64}:
 20
 27
 34
```

## LinRange
生成一个 `start` 到 `stop`，均匀切分（包括端点）成 `len` 段的范围。
```julia-repl
julia> LinRange(1, 4, 5)
5-element LinRange{Float64}:
 1.0,1.75,2.5,3.25,4.0
```

## range
`range` 原型是 `range(start[, stop]; length, stop, step=1)`，可以用于便捷地生成恰当类型的范围。
