# 代码优化
## 基本原则
编写高性能 Julia 代码的两条基本原则：[^1]

1. **确保编译器能推断出每个变量的类型**（避免类型不稳定）
2. **避免不必要的堆分配**（减少垃圾回收压力）

编译器的任务是将 Julia 代码翻译成高效的机器码。若某个变量的类型在运行前无法推断，编译器就无法为其生成优化代码，这种现象称为**类型不稳定**（type instability）。

**堆分配**（heap allocation）发生在创建大小未知的对象时（如可变长度的 `Vector`）。Julia 使用标记-清除式[垃圾回收器](https://docs.juliacn.com/latest/devdocs/gc/)（GC），GC 运行时会暂停代码执行，因此应尽量减少分配次数。

最常见的新手陷阱是使用[未注类型的全局变量](https://docs.juliacn.com/latest/manual/performance-tips/#Avoid-untyped-global-variables)而不将其作为参数传递——全局变量的类型可在函数体外部改变，导致类型不稳定，进而产生更多堆分配。

建议阅读官方的[性能提示](https://docs.juliacn.com/latest/manual/performance-tips/)以获取更全面的指导。

## 性能测量
### `@time` 与 `@timev`
最简单的性能测量方法是使用 `@time` 宏，它会返回代码结果并打印运行时间和分配量。注意：**第一次运行包含编译时间，应先预热再计时**：

```julia-repl
julia> sum_abs(vec) = sum(abs(x) for x in vec);
julia> v = rand(100);
julia> @time sum_abs(v);   # 不准确，包含编译时间
julia> @time sum_abs(v);   # 准确
0.000006 seconds (1 allocation: 16 bytes)
```

### BenchmarkTools.jl
[BenchmarkTools.jl](https://github.com/JuliaCI/BenchmarkTools.jl) 是最流行的重复测量工具包，通过多次运行消除偶发性误差。使用 `$` 对外部变量进行[插值](https://juliaci.github.io/BenchmarkTools.jl/stable/manual/#Interpolating-values-into-benchmark-expressions)可消除全局变量带来的额外开销：[^1]

```julia-repl
julia> using BenchmarkTools
julia> @btime sum_abs(v);       # 不插值
julia> @btime sum_abs($v);      # 插值，更准确
```

需要在每次样本前重新构造输入时，可使用 `setup` 阶段：

```julia-repl
julia> @btime my_matmul(A, b) setup=(
    A = rand(1000, 1000);
    b = rand(1000)
);
```

`@benchmark` 宏会展示性能分布直方图，提供更丰富的统计信息。

### Chairmarks.jl
[Chairmarks.jl](https://github.com/LilithHafner/Chairmarks.jl) 是另一个基准测试工具包，语法略有不同：

```julia-repl
julia> using Chairmarks
julia> @b sum_abs($v)
julia> @b v sum_abs       # 管道语法
```

支持 `init`、`setup`、`teardown` 等参数以精细控制基准过程，详见 [Chairmarks 文档](https://chairmarks.lilithhafner.com/)。[PrettyChairmarks.jl](https://github.com/astrozot/PrettyChairmarks.jl) 可展示性能分布直方图。

### 基准测试套件
若需追踪性能回归，以下工具可用于跨版本的持续性能监控：
- [PkgBenchmark.jl](https://github.com/JuliaCI/PkgBenchmark.jl)
- [AirSpeedVelocity.jl](https://github.com/MilesCranmer/AirspeedVelocity.jl)
- [PkgJogger.jl](https://github.com/awadell1/PkgJogger.jl)

[TimerOutputs.jl](https://github.com/KristofferC/TimerOutputs.jl) 可对代码的不同部分打标签并按标签汇总计时结果。[ProgressMeter.jl](https://github.com/timholy/ProgressMeter.jl) 或 [ProgressLogging.jl](https://github.com/JuliaLogging/ProgressLogging.jl) 可在等待较慢循环时显示进度条。

## 性能分析
基准测试测量整体性能，而**性能分析**（profiling）则逐函数找到瓶颈所在。

### 采样分析
Julia 内置了两种基于采样的分析器：[运行时分析器](https://docs.julialang.org/en/v1/stdlib/Profile/#lib-profiling)（`Profile` 模块）和[内存分析器](https://docs.julialang.org/en/v1/stdlib/Profile/#Memory-profiling)（`Profile.Allocs` 子模块）。分析结果最适合以**火焰图**（flame graph）的形式可视化——水平方向的每一层对应调用栈的一级，块的宽度表示在该函数中花费的时间比例。[^1]

### 可视化工具
[ProfileView.jl](https://github.com/timholy/ProfileView.jl) 和 [PProf.jl](https://github.com/JuliaPerf/PProf.jl) 都可以记录并交互式查看火焰图，后者基于 Google 维护的 [pprof](https://github.com/google/pprof) 工具，功能更强：

```julia-repl
using ProfileView
@profview do_work(some_input)
```

在 VSCode 中，直接在集成 REPL 中调用 `@profview` 即可打开交互式火焰图，无需单独安装 ProfileView.jl。

[ProfileSVG.jl](https://github.com/kimikage/ProfileSVG.jl) 和 [ProfileCanvas.jl](https://github.com/pfitzseb/ProfileCanvas.jl) 适合在 Jupyter/Pluto 中嵌入可视化结果。[StatProfilerHTML.jl](https://github.com/tkluck/StatProfilerHTML.jl) 可生成独立的 HTML 文件，便于分享。

!!! tip
	如果代码执行太快，采样器可能无法收集足够的样本，此时可将其放在循环中多次运行。

## 类型稳定性
### 何为类型稳定
某段代码被视为类型稳定，要求编译器推断出的类型为**具体类型**（concrete type），即其内存大小在编译时已知。抽象类型（如 `Any`、`AbstractVector`）和未指定参数的参数化类型不是具体类型：[^1]

```julia-repl
julia> isconcretetype(Any)
false
julia> isconcretetype(Vector{Int64})
true
```

类型稳定的函数调用编译为快速的 `GOTO` 指令，而类型不稳定的调用需要在运行时查找匹配的方法（动态分派），阻止进一步优化。

### 检测类型不稳定
使用内置宏 [@code_warntype](https://docs.juliacn.com/latest/manual/performance-tips/#man-code-warntype) 查看类型推断结果——若函数体的返回类型为 `Any` 等抽象类型，则存在类型不稳定（在标准 REPL 中以红色高亮显示）：

```julia-repl
julia> @code_warntype put_in_vec_and_sum(1)
```

`@code_warntype` 局限于当前函数体，无法展开内部调用。[JET.jl](https://github.com/aviatesk/JET.jl) 的[优化分析](https://aviatesk.github.io/JET.jl/stable/optanalysis/)可以更深入地检测类型不稳定：

```julia-repl
julia> using JET
julia> @report_opt put_in_vec_and_sum(1)
```

[Cthulhu.jl](https://github.com/JuliaDebug/Cthulhu.jl) 的 `@descend` 宏可交互式逐层下钻到各级函数的类型推断结果，是排查深层类型不稳定的利器（参考[视频演示](https://www.youtube.com/watch?v=pvduxLowpPY)）。

### 修复类型不稳定
参阅 Julia 手册中关于[改善类型推断](https://docs.juliacn.com/latest/manual/performance-tips/#Type-inference)的技巧。[DispatchDoctor.jl](https://github.com/MilesCranmer/DispatchDoctor.jl) 的 `@stable` 宏可在类型不稳定发生时直接抛出错误，帮助提前发现问题。

## 内存管理
在保证类型稳定后，下一步是减少堆分配次数。Julia 手册有一系列关于[数组与分配](https://docs.juliacn.com/latest/manual/performance-tips/#Memory-management-and-arrays)的技巧：[^1]
- 尽量原地修改数组而非分配新对象（注意数组切片的复制行为）
- 按列主序（column-major order）访问多维数组

[AllocCheck.jl](https://github.com/JuliaLang/AllocCheck.jl) 的 `@check_allocs` 宏可在函数发生分配时抛出错误，也可在测试集中断言函数无分配：

```julia-repl
@testset "非分配性" begin
    @test isempty(AllocCheck.check_allocs(my_func, (Float64, Float64)))
end
```

## 编译优化
Julia 存在较高的首次运行延迟（TTFX，Time To First X），以下工具可有效缓解这一问题。

### 预编译
[PrecompileTools.jl](https://github.com/JuliaLang/PrecompileTools.jl) 允许包作者提供一份"预热工作负载"，在包首次加载时预编译这些方法，之后用户调用它们时延迟大幅降低：[^1]

```julia
using PrecompileTools: @compile_workload

@compile_workload begin
    a = [MyType(1)]
    myfunction(a)
end
```

[SnoopCompile.jl](https://github.com/timholy/SnoopCompile.jl) 可用于诊断预编译效果及重新编译（invalidation）问题。

### 包编译（Sysimage）
[PackageCompiler.jl](https://github.com/JuliaLang/PackageCompiler.jl) 可生成包含预编译包的自定义 Julia 系统映像（sysimage），使 `using` 语句几乎瞬间完成：[^1]

```julia-repl
using PackageCompiler
create_sysimage(["Makie", "DifferentialEquations"]; sysimage_path="MySysimage.so")
# 使用：julia --sysimage=MySysimage.so
```

文件扩展名因系统而异：Linux 为 `.so`，macOS 为 `.dylib`，Windows 为 `.dll`。VSCode 的[系统映像工作流](https://www.julia-vscode.org/docs/stable/userguide/compilesysimage/)可进一步简化这一过程。

### 静态编译
PackageCompiler.jl 还支持将 Julia 模块编译为[独立应用](https://julialang.github.io/PackageCompiler.jl/stable/apps.html)或[可调用库](https://julialang.github.io/PackageCompiler.jl/stable/libs.html)，分发给未安装 Julia 的用户。[StaticCompiler.jl](https://github.com/tshort/StaticCompiler.jl) 是另一种生成更小二进制文件的替代方案（但不包含 GC，需手动管理内存）。

## 并行计算
### 多线程
Julia 使用 `Threads` 标准库提供多线程支持（共享内存并行）。启动时指定线程数：[^1]

```powershell
julia --threads 4
julia -t auto
```

运行 `Threads.nthreads()` 确认线程数。使用 `Threads.@threads` 并行化 for 循环：

```julia-repl
results = zeros(Int, 4)
Threads.@threads for i in 1:4
    results[i] = i^2
end
```

!!! warning
	多线程编程中需避免"竞态条件"（多个线程同时写同一内存位置）。通常建议用循环索引隔离内存访问，且[不应使用 `threadid()`](https://julialang.org/blog/2023/07/PSA-dont-use-threadid/)。

[OhMyThreads.jl](https://github.com/JuliaFolds2/OhMyThreads.jl) 提供了更高层、更易用的多线程接口，附有[迁移指南](https://juliafolds2.github.io/OhMyThreads.jl/stable/translation/)。[Polyester.jl](https://github.com/JuliaSIMD/Polyester.jl) 提供启动开销极低的轻量级线程。[ThreadPinning.jl](https://github.com/carstenbauer/ThreadPinning.jl) 可将 Julia 线程绑定到特定 CPU 核心以获得更稳定的性能。

### 分布式计算
Julia 的多进程/分布式计算依赖标准库 `Distributed`。与多线程的主要区别在于进程间不共享数据：[^1]

```julia-repl
using Distributed
addprocs(3)
@everywhere using SharedArrays
@everywhere f(x) = 3x^2

results = SharedArray{Int}(4)
@sync @distributed for i in 1:4
    results[i] = f(i)
end
```

`pmap` 可方便地并行化 `map` 操作。[MPI.jl](https://github.com/JuliaParallel/MPI.jl) 封装了 MPI 标准，适用于大规模 HPC 集群场景。

### GPU 编程
GPU 擅长大规模并行执行，Julia 的 GPU 生态由 [JuliaGPU](https://juliagpu.org/) 组织维护。最常用的是 [CUDA.jl](https://github.com/JuliaGPU/CUDA.jl)（NVIDIA GPU），通过 [KernelAbstractions.jl](https://github.com/JuliaGPU/KernelAbstractions.jl) 可编写硬件无关的 GPU 代码。[^1]

### SIMD 指令
单指令多数据（SIMD）是更细粒度的向量化并行。Julia 可在满足条件时自动向量化循环，`@simd` 和 `@inbounds` 等[性能注解](https://docs.juliacn.com/latest/manual/performance-tips/#man-performance-annotations)可进一步协助。[SIMD.jl](https://github.com/eschnett/SIMD.jl) 允许手动强制使用 SIMD 指令。

## 高效数据结构
### 静态数组
[StaticArrays.jl](https://github.com/JuliaArrays/StaticArrays.jl) 提供在类型中携带大小信息的数组。静态大小数组（`SArray`、`SMatrix`、`SVector`）是不可变的，可以栈分配，避免 GC 开销，且在线性代数等操作中能生成高效的特化方法：[^1]

```julia-repl
using StaticArrays, Accessors
sx = SA[1, 2, 3]          # 构造 SArray
@set sx[1] = 3            # 返回副本，不修改原变量
@reset sx[1] = 4          # 替换原变量
```

可变版本为 `MArray`、`MMatrix`、`MVector`，语法与普通数组一致。

### 经典数据结构
[DataStructures.jl](https://github.com/JuliaCollections/DataStructures.jl) 提供了栈、队列、堆、树等经典数据结构。[IterTools.jl](https://github.com/JuliaCollections/IterTools.jl) 和 [Memoize.jl](https://github.com/JuliaCollections/Memoize.jl) 提供迭代和记忆化工具。更多相关包可在 [JuliaCollections](https://github.com/JuliaCollections) 组织下找到。

[^1]: [Modern Julia Workflows - Optimizing your code](https://modernjuliaworkflows.org/optimizing/) by G. Dalle, J. Smit, A. Hill（CC BY-SA 4.0）
