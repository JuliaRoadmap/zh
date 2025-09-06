# 开发技巧
## REPL 高级运用
REPL 结合了 [InteractiveUtils.jl](https://docs.juliacn.com/latest/stdlib/InteractiveUtils/)，包含许多对于开发和调试有用的功能。

可以查看与类型有关的信息。参考[类型系统](../advanced/typesystem.md)。
```julia-repl
julia> supertypes(Int64)
(Int64, Signed, Integer, Real, Number, Any)

julia> subtypes(Integer)
3-element Vector{Any}:
 Bool
 Signed
 Unsigned

julia> methodswith(Integer)[2]
Float16(x::Integer)
     @ Base float.jl:234
```

可以查看含有指定关键词/模式的文档。
```julia-repl
julia> apropos("bold")
Base.text_colors
Base.printstyled
StyledStrings.StyledMarkup.@styled_str
StyledStrings.eachregion
StyledStrings.Face
```

使用[宏](../advanced/macro.md)来获取源代码位置信息。
```julia-repl
julia> @which exp(1)
exp(x::Real)
     @ Base.Math math.jl:1528
```

此外，我们在环境配置一节中提到过 `versioninfo()`，如果你在向他人求助某个 Julia 程序的问题，提供这一信息可能十分有用。

[InteractiveCodeSearch.jl](https://github.com/tkf/InteractiveCodeSearch.jl)，[InteractiveErrors.jl](https://github.com/MichaelHatherly/InteractiveErrors.jl) 和 [CodeTracking.jl](https://github.com/timholy/CodeTracking.jl) 提供了更多的辅助功能。

## 日志输出
使用日志输出宏可以得到完整表达式的信息。

```julia-repl
julia> a = 0.7
0.7

julia> b = 0.3
0.3

julia> @show a + b
a + b = 1.0
1.0

julia> @warn "This is bad" a + b
┌ Warning: This is bad
│   a + b = 1.0
└ @ Main REPL[14]:1
```

与 `@warn` 类似的还有 `@debug`，`@info` 和 `@error`

可以更进一步使用 [ProgressLogging.jl](https://github.com/JuliaLogging/ProgressLogging.jl) 提供的 `@progress` 去显示进度条，使用 [Suppressor.jl](https://github.com/JuliaIO/Suppressor.jl) 抑制一些消息。

## 热更新
可以使用 [Revise.jl](https://github.com/timholy/Revise.jl) 在运行时热更新一些代码。

许多 Julia 开发者会在 `.julia/config/startup.jl` 中填入如下代码：
```julia
try
    using Revise
catch e
    @warn "Error initializing Revise"
end
```

## 调试
[Infiltrator.jl](https://github.com/JuliaDebug/Infiltrator.jl) 允许你给自己的代码加入断点。

[Debugger.jl](https://github.com/JuliaDebug/Debugger.jl) 的功能更强：它甚至允许你给别人的代码加入断点。
