# Makie的使用
## 做数据可视化
> Maki-e 来源于日语， 它指的是一种在漆面上撒金粉和银粉的技术。
> 数据就是我们这个时代的金和银，让我们在屏幕上制作美丽的数据图吧！
>
> _Simon Danisch,  `Makie.jl` 创始人_

[Makie](http://makie.juliaplots.org/stable/index.html) 是高性能，可扩展且跨平台的 Julia 语言绘图系统，是 [Plots](plots.md) 外的另一选择

与其他绘图包一样，该库的代码分为多个包。
- `Makie.jl` 是绘图前端，它定义了所有创建绘图对象需要的函数。虽然这些对象存储了绘图所需的全部信息，但还未转换为图片。因此，我们需要一个 Makie 后端。
- 默认情况下，每一个后端都将 `Makie.jl` 中的API都重新导出了，因此只需要安装和加载所需的后端包即可。

目前主要有三个后端实现了 Makie 中定义的所有抽象类型的渲染功能。
- `CairoMakie.jl` 能够绘制 2D 非交互式的出版物质量级矢量图
- `GLFW.jl`（支持 GPU），`GLMakie.jl` 是交互式 2D 和 3D 绘图库
- `WGLMakie.jl`是基于 WebGL 的交互式 2D 和 3D 绘图库，运行在浏览器中

[查阅 Makie 文档了解更多](http://makie.juliaplots.org/stable/documentation/backends_and_output/)。

以下将只介绍一些 `CairoMakie.jl` 和 `GLMakie.jl` 的例子。

使用任一绘图后端的方法是 `using` 该后端并调用 `activate!` 函数。示例如下：

```jl
using GLMakie
GLMakie.activate!()
```

现在可以开始绘制出版质量级的图。
但是，在绘图之前，应知道如何保存。
`save` 图片 `fig` 的最简单方法是 `save("filename.png", fig)`。
`CairoMakie.jl` 也支持保存为其他格式，如 `svg` 和 `pdf`。
通过传递指定的参数可以轻松地改变图片的分辨率。
对于矢量格式，指定的参数为 `pt_per_unit`。例如：

```jl
save("filename.pdf", fig; pt_per_unit=2)
```

或

```jl
save("filename.pdf", fig; pt_per_unit=0.5)
```

对于 `png`，则指定 `px_per_unit`。
查阅 [后端 & 输出](https://makie.juliaplots.org/stable/documentation/backends_and_output/) 可获得更多详细信息。

另一重要问题是如何可视化输出数据图。
在使用 `CairoMakie.jl` 时，Julia REPL 不支持显示图片， 所以你还需要 IDE（Integrated Development Environment，集成开发环境），例如支持 `png` 或 `svg` 作为输出的 VSCode，Jupyter 或 Pluto。
另一个包 `GLMakie.jl` 则能够创建交互式窗口，或在调用 `Makie.inline!(true)` 时在行间显示位图。

还需注意的是，由于 Julia 是即时编译的，因此绘制第一张图需要等待较长时间，之后调用就会快很多，你也可以考虑调用 `precompile` 函数

## CairoMakie
我们开始绘制的第一张图是标注了散点的直线：
```jl
using CairoMakie
CairoMakie.activate!()
```

![](https://cn.julialang.org/JuliaDataScience/im/firstplot.svg)

注意前面的图采用默认输出样式，因此需要使用轴名称和轴标签进一步调整。

同时注意每一个像 `scatterlines` 这样的绘图函数都创建了一个 `FigureAxisPlot` 列表，其中包含 `Figure`， `Axis` 和 `plot` 对象。
这些函数也被称为 `non-mutating` 方法。
另一方面， `mutating` 方法（例如 `scatterlines!`，注意多了 `!`) 仅返回一个 plot 对象，它可以被添加到给定的 `axis` 或 `current_figure()` 中。

## 属性
使用 `attributes` 可以创建自定义的图，实现改变颜色或标记等。
设置属性可以使用多个关键字参数。
每个 plot 对象的 `attributes` 列表可以通过以下方式查看：

```jl
fig, ax, pltobj = scatterlines(1:10)

julia> pltobj.attributes
Attributes with 15 entries:
  color => RGBA{Float32}(0.0,0.447059,0.698039,1.0)
  ...
```

或者调用 `pltobject.attributes.attributes` 返回对象属性的 `Dict`

对于任一给定的绘图函数，都能在 `REPL` 中以 `?lines` 或 `help(lines)` 的形式获取帮助。Julia将输出该函数的相应属性，并简要说明如何使用该函数。

不仅 plot 对象有属性，`Axis` 和 `Figure` 对象也有属性。
例如，Figure 的属性有 `backgroundcolor`，`resolution`，`font` 和 `fontsize` 以及 `figure_padding`。 其中 `figure_padding` 改变了图像周围的空白区域，如图中的灰色区域所示。
它使用一个数字指定所有边的范围，或使用四个数的元组表示上下左右。

`Axis` 同样有一系列属性，典型的有 `backgroundcolor`， `xgridcolor` 和 `title`。
使用 `help(Axis)` 可查看所有属性。

在接下来这张图里，我们将设置一些属性：

```jl
lines(1:10, (1:10).^2; color=:black, linewidth=2, linestyle=:dash,
    figure=(; figure_padding=5, resolution=(600, 400), font="sans",
        backgroundcolor=:grey90, fontsize=16),
    axis=(; xlabel="x", ylabel="x²", title="title",
        xgridstyle=:dash, ygridstyle=:dash))
current_figure()
```

![](https://cn.julialang.org/JuliaDataScience/im/custom_plot.svg)

此例已经包含了大多数用户经常会用到的属性。
或许在图上加一个 `legend` 会更好，这在有多条曲线时尤为有意义。
所以，向图上 `append` 另一个 `plot object` 并且通过调用 `axislegend` 添加对应的图例。
它将收集所有 plot 函数中的 `labels`， 并且图例默认位于图的右上角。
本例调用了 `position=:ct` 参数，其中 `:ct` 表示图例将位于 `center`和 `top`， 如图所示：

```jl
lines(1:10, (1:10).^2; label="x²", linewidth=2, linestyle=nothing,
    figure=(; figure_padding=5, resolution=(600, 400), font="sans",
        backgroundcolor=:grey90, fontsize=16),
    axis=(; xlabel="x", title="title", xgridstyle=:dash,
        ygridstyle=:dash))
scatterlines!(1:10, (10:-1:1).^2; label="Reverse(x)²")
axislegend("legend"; position=:ct)
current_figure()
```

![](https://cn.julialang.org/JuliaDataScience/im/custom_plot_leg.svg)

通过组合 `left(l), center(c), right(r)` 和 `bottom(b), center(c), top(t)` 还可以再指定其他位置。
例如，使用`:lt` 指定为左上角。

然而，仅仅为两条曲线编写这么多代码是比较复杂的。
所以，如果要以相同的样式绘制一组曲线，那么最好指定一个主题。
使用 `set_theme!()` 可实现该操作，如下所示。

使用 `set_theme!(kwargs)`定义的新配置，重新绘制之前的图：

```jl
set_theme!(; resolution=(600, 400),
    backgroundcolor=(:orange, 0.5), fontsize=16, font="sans",
    Axis=(backgroundcolor=:grey90, xgridstyle=:dash, ygridstyle=:dash),
    Legend=(bgcolor=(:red, 0.2), framecolor=:dodgerblue))
lines(1:10, (1:10).^2; label="x²", linewidth=2, linestyle=nothing,
    axis=(; xlabel="x", title="title"))
scatterlines!(1:10, (10:-1:1).^2; label="Reverse(x)²")
axislegend("legend"; position=:ct)
current_figure()
set_theme!()
caption = "Set theme example."
```

![](https://cn.julialang.org/JuliaDataScience/im/setTheme.svg)

倒数第二行的 `set_theme!()` 会将主题重置到 Makie 的默认设置。
有关 `themes` 的更多内容请转到 [主题](#主题)

在进入下节前， 值得先看一个例子：将多个参数所组成的 `array` 传递给绘图函数来配置属性。
例如，使用 `scatter` 绘图函数绘制气泡图。

本例随机生成 100 行 3 列的 `array` ，这些数据满足正态分布。
其中第一列表示 `x` 轴上的位置，第二列表示 `y` 轴上的位置，第三列表示与每一点关联的属性值。
例如可以用来指定不同的 `color` 或者不同的标记大小。气泡图就可以实现相同的操作。

```jl
using Random: seed!
seed!(28)
xyvals = randn(100, 3)
xyvals[1:5, :]
```

对应的图如下所示:

```jl
fig, ax, pltobj = scatter(xyvals[:, 1], xyvals[:, 2]; color=xyvals[:, 3],
    label="Bubbles", colormap=:plasma, markersize=15 * abs.(xyvals[:, 3]),
    figure=(; resolution=(600, 400)), axis=(; aspect=DataAspect()))
limits!(-3, 3, -3, 3)
Legend(fig[1, 2], ax, valign=:top)
Colorbar(fig[1, 2], pltobj, height=Relative(3 / 4))
```

![](https://cn.julialang.org/JuliaDataScience/im/bubble.svg)

为了在图上添加 `Legend` 和 `Colorbar`，需将 `FigureAxisPlot` 元组分解为 `fig, ax, pltobj`。
我们将在 [布局](#布局) 讨论有关布局选项的更多细节。

通过一些基本且有趣的例子，我们展示了如何使用`Makie.jl`，现在你可能想知道：还能做什么？
`Makie.jl` 都还有哪些绘图函数？
为了回答此问题，我们制作了一个 _cheat sheet_ ，如图所示：

![](https://cn.julialang.org/JuliaDataScience/images/makiePlottingFunctionsHide.png)

使用 `CairoMakie.jl` 后端可以轻松绘制这些图。

下图展示了 `GLMakie.jl` 的 _cheat sheet_ ，这些函数支持绘制大多数 3D 图。
这些将在后面的 `GLMakie.jl` 节进一步讨论。

![Plotting functions: Cheat Sheet. Output given by GLMakie.](https://cn.julialang.org/JuliaDataScience/images/GLMakiePlottingFunctionsHide.png)

现在，我们已经大致了解到能做什么。接下来应该掉过头来继续研究基础知识。
是时候学习如何改变图的整体外观了。

## 主题
有多种方式可以改变图的整体外观。你可以使用 [预定义主题](http://makie.juliaplots.org/stable/documentation/theming/predefined_themes/index.html) 或自定义的主题。例如，通过 `with_theme(your_plot_function, theme_dark())` 使用预定义的暗色主题。另外，也可以使用 `Theme(kwargs)` 构建你自己的主题或使用 `update_theme!(kwargs)` 更新当前激活的主题。

还可以使用 `set_theme!(theme; kwargs...)` 将当前主题改为 `theme`， 并且通过 `kwargs` 覆盖或增加一些属性。使用不带参数的 `set_theme!()` 即可恢复到之前主题的设置。在下面的例子中，我们准备了具有不同样式的测试绘图函数，以便于观察每个主题的大多数属性。

```jl
using Random: seed!
seed!(123)
y = cumsum(randn(6, 6), dims=2)
```

本例随机生成了一个大小为 `(20, 20)` 的矩阵，以便于绘制一张热力图（heatmap）。
同时本例也指定了 x 和 y 的范围。

```jl
using Random: seed!
seed!(13)
xv = yv = LinRange(-3, 0.5, 20)
matrix = randn(20, 20)
matrix[1:6, 1:6] # first 6 rows and columns
```

因此，新绘图函数如下所示：

```jl
function demo_themes(y, xv, yv, matrix)
    fig, _ = series(y; labels=["$i" for i = 1:6], markersize=10,
        color=:Set1, figure=(; resolution=(600, 300)),
        axis=(; xlabel="time (s)", ylabel="Amplitude",
            title="Measurements"))
    hmap = heatmap!(xv, yv, matrix; colormap=:plasma)
    limits!(-3.1, 8.5, -6, 5.1)
    axislegend("legend"; merge=true)
    Colorbar(fig[1, 2], hmap)
    fig
end
```

注意，`series` 函数的作用是同时绘制多条附带标签的直线图和散点图。另外还绘制了附带 colorbar 的 heatmap。如图所示，有两种暗色主题，一种是 `theme_dark()` ，另一种是 `theme_black()`。

```jl
with_theme(theme_dark()) do
    demo_themes(y, xv, yv, matrix)
end
with_theme(theme_black()) do
    demo_themes(y, xv, yv, matrix)
end
```

![](https://cn.julialang.org/JuliaDataScience/im/theme_dark.svg)
![](https://cn.julialang.org/JuliaDataScience/im/theme_black.svg)

另外有三种白色主题，`theme_ggplot2()`，`theme_minimal()` 和 `theme_light()`。这些主题对于更标准的出版图很有用。

```jl
with_theme(theme_ggplot2()) do
    demo_themes(y, xv, yv, matrix)
end
with_theme(theme_minimal()) do
    demo_themes(y, xv, yv, matrix)
end
with_theme(theme_light()) do
    demo_themes(y, xv, yv, matrix)
end
```

![](https://cn.julialang.org/JuliaDataScience/im/theme_ggplot2.svg)
![](https://cn.julialang.org/JuliaDataScience/im/theme_minimal.svg)
![](https://cn.julialang.org/JuliaDataScience/im/theme_light.svg)

另一种方案是通过使用 `with_theme(your_plot, your_theme())` 创建自定义 `Theme` 。
例如，以下主题可以作为出版质量图的初级模板：

```jl
publication_theme() = Theme(
    fontsize=16, font="CMU Serif",
    Axis=(xlabelsize=20, xgridstyle=:dash, ygridstyle=:dash,
        xtickalign=1, ytickalign=1, yticksize=10, xticksize=10,
        xlabelpadding=-5, xlabel="x", ylabel="y"),
    Legend=(framecolor=(:black, 0.5), bgcolor=(:white, 0.5)),
    Colorbar=(ticksize=16, tickalign=1, spinewidth=0.5),
)
```

为简单起见，在接下来的例子中使用它绘制 `scatterlines` 和 `heatmap`。

```jl
function plot_with_legend_and_colorbar()
    fig, ax, _ = scatterlines(1:10; label="line")
    hm = heatmap!(ax, LinRange(6, 9, 15), LinRange(2, 5, 15), randn(15, 15);
        colormap=:Spectral_11)
    axislegend("legend"; position=:lt)
    Colorbar(fig[1, 2], hm, label="values")
    ax.title = "my custom theme"
    fig
end
```

然后使用前面定义的 `Theme`，其输出如图所示
```jl
with_theme(plot_with_legend_and_colorbar, publication_theme())
```

![](https://cn.julialang.org/JuliaDataScience/im/plot_with_legend_and_colorbar.svg)

如果需要在 `set_theme!(your_theme)`后更改一些设置，那么可以使用 `update_theme!(resolution=(500, 400), fontsize=18)`。
另一种方法是给 `with_theme` 函数传递额外的参数：

```jl
fig = (resolution=(600, 400), figure_padding=1, backgroundcolor=:grey90)
ax = (; aspect=DataAspect(), xlabel=L"x", ylabel=L"y")
cbar = (; height=Relative(4 / 5))
with_theme(publication_theme(); fig..., Axis=ax, Colorbar=cbar) do
    plot_with_legend_and_colorbar()
end
```

![](https://cn.julialang.org/JuliaDataScience/im/plot_theme_extra_args.svg)

[^1]: https://cn.julialang.org/JuliaDataScience/DataVisualizationMakie
