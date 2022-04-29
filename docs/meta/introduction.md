# 简介
!!! note
	你暂时没必要看懂这些东西

Julia 是一门支持过程式、函数式和面向对象的多范式语言。它简单，在高级数值计算方面有丰富的表现力，并且支持通用编程。它以数学编程语言为基础，同时也参考了不少流行的动态语言。

## 优势
- 免费[开源](https://github.com/julialang/julia)
- 用户[自定义类型](../advanced/struct.md)的速度与兼容性和内建类型一样好
- 无需特意编写向量化的代码
- 为并行计算和分布式计算设计
- 轻量级的[“绿色”线程](../advanced/task.md)
- 优雅的[类型系统](../advanced/type.md)
- 可扩展的类型转换和类型提升
- [对 Unicode 的有效支持，包括但不限于 UTF-8](../basic/string.md)
- [直接调用 C 函数，无需封装或调用特别的 API](../tips/lang_call.md#C)
- [像 Shell 一样强大的管理其他进程的能力](../advanced/cmd.md)
- [像 Lisp 一样的宏和其他元编程工具](../advanced/macro.md)

## 缺陷
- （在[JIT](https://discourse.juliacn.com/t/topic/4203#just-in-time-compilation)模式下）预热较慢（这是所有基于JIT的语言的共有特点），1.6版本相较之前版本有了明显的提升
- 生态环境不太友好，包较少（Julia仍然是一门新兴语言）

## 与传统动态语言区别
- 核心语言很小：标准库是用 Julia 自身写的，包括整数运算这样的基础运算
- 丰富的基础类型：既可用于定义和描述对象，也可用于做可选的类型标注
- 通过[多重派发](https://discourse.juliacn.com/t/topic/4203#multiple-dispatch)，可以根据类型的不同，来调用同名函数的不同实现
- 为不同的参数类型，自动生成高效、专用的代码
- [接近 C 语言的性能](https://julialang.org/assets/benchmarks/benchmarks.svg)

## 前景
- 应用包括但不限于数值优化、生物信息、机器学习、数据科学、计算物理

[^1]: https://docs.juliacn.com/latest/
[^2]: https://julialang.org/blog/2012/02/why-we-created-julia-zh_CN/
