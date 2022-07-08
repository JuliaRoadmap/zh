# 简介
!!! note
	没必要看懂部分专业性的东西

Julia 是一门支持过程式、函数式和面向对象的多范式语言。它简单，在高级数值计算方面有丰富的表现力，并且支持通用编程。它以数学编程语言为基础，同时也参考了不少流行的动态语言。

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
- [像 Lisp 一样的宏和其他元编程工具](../advanced/macro.md)

## 缺陷
- （在[JIT](https://discourse.juliacn.com/t/topic/4203#just-in-time-compilation)模式下）预热较慢（这是所有基于JIT的语言的共有特点），1.6版本相较之前版本有了明显的提升
- 生态环境不太友好，包较少（Julia仍然是一门新兴语言）
- [讨论：Julia及其生态的现状与发展问题](https://discourse.julialang.org/t/discussion-on-why-i-no-longer-recommend-julia-by-yuri-vishnevsky/81151)

## 与传统动态语言区别
- 核心语言很小：标准库是用 Julia 自身写的，包括整数运算这样的基础运算
- 丰富的[基础类型](../lists/typetree1.6.txt)：既可用于定义和描述对象，也可用于做可选的类型标注
- 通过[多重派发](https://discourse.juliacn.com/t/topic/4203#multiple-dispatch)，可以根据类型的不同，来调用同名函数的不同实现
- 为不同的参数类型，自动生成高效、专用的代码
- [接近 C 语言的性能](../../assets/svg/benchmarks.svg)

## 前景 & 当下
- 应用包括但不限于数值优化、生物信息、机器学习、数据科学、计算物理
- [2021年的调查结果](../ecosystem/survey/2021.md)
- [加入 Petaflop Club](https://www.hpcwire.com/off-the-wire/julia-joins-petaflop-club/)
- NASA 使用 Julia 在超级计算机上分析了 [迄今为止发现的最大一批地球尺寸的行星](https://exoplanets.nasa.gov/news/1669/seven-rocky-trappist-1-planets-may-be-made-of-similar-stuff/) ，并且实现了惊人的 1,000 倍加速，在 15 分钟内分类了1.88 亿个天体
- [气候建模联盟(Climate Modeling Alliance，CliMa)](https://clima.caltech.edu/) 在 GPU 和 CPU 上模拟天气。该项目启动于 2018 年，与加州理工大学、 NASA 喷气推进实验室以及海军研究生院的研究人员合作，CliMa 项目组采用最近的计算科学进展来开发一个地球系统模型，该模型能够以前所未有的精度和速度预测干旱、热浪和降雨。
- [美国联邦航空管理局 (FAA) 正在使用 Julia 开发一种 空中防碰撞系统 ](https://youtu.be/19zm1Fn0S9M)。这也是一个「两语言问题」的好例子：之前的方案是使用 Matlab 开发算法 并使用 C++ 编写高性能实现；现在，FAA 使用 Julia 语言完成所有的事。
- [使用 Julia 在 GPU 上 175 倍加速 辉瑞的药理学模型](https://juliacomputing.com/case-studies/pfizer/)。这是一份第11届美国定量药理学会议的[海报](https://chrisrackauckas.com/assets/Posters/ACoP11_Poster_Abstracts_2020.pdf)，它还获得了[quality award](https://web.archive.org/web/20210121164011/https://www.go-acop.org/abstract-awards)。
- [巴西卫星亚马逊 1 号的姿态和轨道控制子系统 (AOCS) 100% 使用 Julia 编写](https://discourse.julialang.org/t/julia-and-the-satellite-amazonia-1/57541) ，它的作者是 [Ronan Arraes Jardim Chagas](https://ronanarraes.com/)
- [巴西国家发展银行 (BNDES) 放弃了付费解决方案，转而选择开源 Julia 模型并获得 10 倍加速](https://youtu.be/NY0HcGqHj3g)

如果觉得这些仍不够，[Julia 计算网站](https://juliacomputing.com/case-studies/) 上还有更多的例子。[^3]

[^1]: https://docs.juliacn.com/latest/
[^2]: https://julialang.org/blog/2012/02/why-we-created-julia-zh_CN/
[^3]: https://github.com/JuliaCN/JuliaDataScience/blob/467a3375180a991d9b721ee4cce168e2583c4acb/contents/why_julia.md?plain=1#L368-L380
