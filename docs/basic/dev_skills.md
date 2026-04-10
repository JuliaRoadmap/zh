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

!!! info
	`@debug` 消息默认被抑制。可通过设置环境变量 `JULIA_DEBUG` 为模块名（通常为 `Main` 或你的包模块名）来启用它们。

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

## 启动文件
Julia 每次启动时会自动执行位于 `.julia/config/startup.jl` 的**启动文件**。大多数 Julia 开发者会在此文件中加载一些常用的开发工具。[^1]

除了[热更新](#热更新)中提到的 Revise.jl，还可以加载影响 REPL 体验的包：

* [OhMyREPL.jl](https://github.com/KristofferC/OhMyREPL.jl)：为 REPL 提供语法高亮，被广泛使用
* [AbbreviatedStackTraces.jl](https://github.com/BioTurboNick/AbbreviatedStackTraces.jl)：缩短错误堆栈跟踪，避免信息过多淹没关键内容
* [Term.jl](https://github.com/FedeClaudi/Term.jl)：提供更美观的类型和错误显示方式

[StartupCustomizer.jl](https://github.com/abraemer/StartupCustomizer.jl) 可帮助配置和管理启动文件。

## 调试
[Infiltrator.jl](https://github.com/JuliaDebug/Infiltrator.jl) 允许你给自己的代码加入断点。调用命中断点的函数后，REPL 提示符会变为 `infil>`，输入 `?` 可查看可用命令。

`@exfiltrate` 宏可以将局部变量转移到全局存储 `safehouse` 中，便于断点外继续分析：[^1]
```julia-repl
infil> @exfiltrate k F   # 将 k、F 存入 safehouse
infil> @continue

julia> safehouse.k       # 在普通模式下访问
```

[Debugger.jl](https://github.com/JuliaDebug/Debugger.jl) 的功能更强：它甚至允许你给别人的代码加入断点。使用 `@enter` 宏进入函数调用，提示符变为 `1|debug>`，可使用导航命令单步执行，按反引号切换到 `` 1|julia> `` 模式后可在当前上下文中求值任意表达式。

VSCode 提供了[图形化调试界面](https://www.julia-vscode.org/docs/stable/userguide/debugging/)：点击行号左侧设置断点（显示为红色圆点），在 Julia 扩展的调试面板中点击 `Run and Debug` 启动调试器。程序在断点处暂停后，可通过顶部工具栏继续、单步跳过、单步进入或跳出。[^1]

[^1]: [Modern Julia Workflows - Writing your code](https://modernjuliaworkflows.org/writing/)
