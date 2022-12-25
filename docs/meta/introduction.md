# 语言简介
Julia 是一门支持过程式、函数式和面向对象的多范式语言，其类型系统是动态、主格、参数的，它以数学编程语言为基础，同时也参考了不少流行的动态语言。[^4]

Julia 最常用的运行模式是 JIT，同时它也支持解释与编译。

## 优势
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
- 核心语言很小：[标准库](../blog/packages/stdlib.md)是用 Julia 自身写的，包括整数运算这样的基础运算
- 丰富的[基础类型](../lists/typetree1.8.txt)：既可用于[定义和描述对象](../advanced/struct.md)，也可用于做可选的[类型标注](../advanced/typesystem.md#类型声明)
- 通过[多重派发](https://discourse.juliacn.com/t/topic/4203#multiple-dispatch)，可以根据类型的不同，来调用同名函数的不同实现
- [为不同的参数类型，自动生成高效、专用的代码](../advanced/method.md)
- [接近 C 语言的性能](../../assets/svg/benchmarks.svg)

## 前景 & 当下
- 应用包括但不限于数值优化、生物信息、[机器学习](../blog/packages/classify.md#机器学习)、[数据科学](../blog/packages/classify.md#数据工具)、计算物理
- [2021年的调查结果](../ecosystem/survey/2021.md)
- [julia-matlab-python-r比较](https://cepr.org/voxeu/columns/choosing-numerical-programming-language-economic-research-julia-matlab-python-or-r)
- [加入 Petaflop Club](https://www.hpcwire.com/off-the-wire/julia-joins-petaflop-club/)
- 可以在 [Julia 计算网站](https://juliacomputing.com/case-studies/) 上阅读更多更具体的例子。[^3]

---

[^1]: https://docs.juliacn.com/latest/
[^2]: https://julialang.org/blog/2012/02/why-we-created-julia-zh_CN/
[^3]: https://github.com/JuliaCN/JuliaDataScience/blob/467a3375180a991d9b721ee4cce168e2583c4acb/contents/why_julia.md?plain=1#L368-L380
[^4]: 如果您并不熟悉专业性的内容，可以忽略那些东西。
