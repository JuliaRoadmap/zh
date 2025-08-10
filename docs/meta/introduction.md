# 语言简介
科学计算对性能一直有着最高的需求，但目前各领域的专家却大量使用较慢的动态语言来开展他们的日常工作。 偏爱动态语言有很多很好的理由，因此我们不会舍弃动态的特性。 幸运的是，现代编程语言设计与编译器技术可以大大消除性能折衷（trade-off），并提供有足够生产力的单一环境进行原型设计，而且能高效地部署性能密集型应用程序。 Julia 语言在这其中扮演了这样一个角色：它是一门灵活的动态语言，**适合用于科学计算和数值计算**，并且性能可与传统的静态类型语言媲美。[^1]

Julia 是一门支持过程式、函数式和面向对象的多范式语言，其类型系统是动态、主格[^nominal]、参数[^parametric]的，它以数学编程语言为基础，同时也参考了不少流行的动态语言。

它最常用的运行模式是 JIT，同时也支持解释与编译。

## 优势
Julia 的目标是创建一个前所未有的集易用、强大、高效于一体的语言。
- 免费[开源](https://github.com/julialang/julia)
- 用户[自定义类型](../advanced/struct.md)的速度与[兼容性](../advanced/method.md)和[内建类型](../advanced/typesystem.md#原始类型)一样好
- 无需特意编写[向量化](../basic/vector.md#向量点运算)的代码
- 为并行计算和分布式计算设计
- 轻量级的[“绿色”线程](../advanced/task.md)
- 优雅的[类型系统](../advanced/typesystem.md)
- [可扩展的类型转换和类型提升](../advanced/conpro.md)
- [对 Unicode 的有效支持，包括但不限于 UTF-8](../basic/string.md)
- [直接调用 C 函数，无需封装或调用特别的 API](../advanced/ccall.md)
- [像 Shell 一样强大的管理其他进程的能力](../advanced/cmd.md)
- [像 Lisp 一样的宏和其他元编程工具](../advanced/meta.md)

## 缺陷
- （在 [JIT](https://discourse.juliacn.com/t/topic/4203#just-in-time-compilation) 模式下）预热较慢（这是所有基于 JIT 的语言的共有特点），1.6 版本相较之前版本有了明显的提升
- 生态环境不太友好，包的数量与质量仍待提高（Julia 仍然是一门新兴语言）
- 有多种编译方式，但各有缺陷
- [讨论：Julia及其生态的现状与发展问题](https://discourse.julialang.org/t/discussion-on-why-i-no-longer-recommend-julia-by-yuri-vishnevsky/81151)

## 与传统动态语言区别
- 核心语言很小：[标准库](../workflow/stdlib.md)是用 Julia 自身写的，包括整数运算这样的基础运算
- 丰富的基础类型：既可用于[定义和描述对象](../advanced/struct.md)，也可用于做可选的[类型标注](../advanced/typesystem.md#类型声明)
- 通过[多重派发](https://discourse.juliacn.com/t/topic/4203#multiple-dispatch)，可以根据类型的不同，来调用同名函数的不同实现
- [为不同的参数类型，自动生成高效、专用的代码](../advanced/method.md)
- [接近 C 语言的性能](../../assets/svg/benchmarks.svg)

## 前景 & 当下
- 应用包括但不限于数值优化、生物信息、机器学习、数据科学、计算物理
- [2021 年的调查结果](../blog/ecosystem.md)
- [julia-matlab-python-r 比较](https://cepr.org/voxeu/columns/choosing-numerical-programming-language-economic-research-julia-matlab-python-or-r)
- [加入 Petaflop Club](https://www.hpcwire.com/off-the-wire/julia-joins-petaflop-club/)
- 可以在 [Julia 计算网站](https://juliacomputing.com/case-studies/) 上阅读更多更具体的例子。[^5]

[^1]: https://docs.juliacn.com/latest/
[^2]: https://julialang.org/blog/2012/02/why-we-created-julia-zh_CN/
[^nominal]: 类型兼容性基于显式声明的类型名称而非结构
[^parametric]: 支持泛型
[^5]: https://github.com/JuliaCN/JuliaDataScience/blob/467a3375180a991d9b721ee4cce168e2583c4acb/contents/why_julia.md?plain=1#L368-L380
