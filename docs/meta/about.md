# 主页
## 关于本项目
欢迎阅读 Julia 中文导航。这是一项由社区共同维护的**开源文档计划**：把分散在官方手册、论坛帖子和个人博客里的入门路径，整理成一条可以按顺序阅读、也可以按需跳转的学习路线，降低中文读者上手 Julia 时的信息成本。

### 目标与定位
- **面向谁**：以自学与课堂教学为主要场景，兼顾已经会一门其它语言、希望迁移到 Julia 的开发者；不假设你事先熟悉科学计算或数值分析的全部背景。
- **做什么**：解释语言核心概念与惯用法，标出「先读这里再读那里」的依赖关系，并补充 Git、命令行、Unicode 等周边话题；在[包的概述](../packages/index.md)与[工作流程](../workflow/introduction.md)中对接真实开发中会遇到的包管理与协作实践。
- **不做什么**：本文档不是官方手册的逐段翻译，也不追求覆盖每一个标准库函数；遇到需要查 API 细节时，应结合[中文文档](https://docs.juliacn.com/latest/)与[英文文档](https://docs.julialang.org/)使用。

### 如何使用本站
不同人适用的学习方法可能不同，但一般来说，建议先设定一个明确的、可评价目标（如「在项目中学习」：用 Julia 完成一件你真正想完成的事）。先把小目标跑通，再按需深入语法与性能细节，而不是在一开始就陷入旁支。[^h]

- 新手常见问题可先浏览帖子 [Julia 语言入门指引](https://discourse.juliacn.com/t/topic/159)。
- 建议阅读顺序：先在[语言简介](introduction.md)建立整体印象，在[学习资源](resources.md)里收藏备用资料；完成可选的[工作环境配置](setup_workspace.md) 与必要的 [Julia 环境配置](../basic/setup_environment.md)后，[开始学习之旅](../basic/hello.md)。

### 内容结构说明
- **语言基础**：变量、类型、控制流、函数、集合与 I/O 等，与多数现代语言有对应关系，读完即可获得日常脚本与小项目所需的基本能力。
- **语言进阶**：多重派发、模块与元编程、异步与并行等 Julia 中较突出、也常被误用的部分，适合在写过一定代码后再读。
- **工作流程**：文档、测试、性能与包开发等主题；结合[包简介](../workflow/introduction.md)可以学会检索、安装与发布包。若你从事数据类工作，可进一步查阅 `Dates`、`DataFrames`、`Makie` 等方向的专题与包页。[^ds]
- **专题**：专题。

## 关于本文档
!!! compat "Julia 1.10"
	除非重要，本文档不会特别注明 Julia 1.10 及以下引入的特性。

本项目的一部分页面不会展现在侧边栏中，你会在一些链接处遇到它们。

讨论区可以在注册 [Github](../knowledge/github.md) 后使用。**不要吝啬你的反馈**：若某节难以理解、示例无法运行或与当前 Julia 行为不符，不妨在讨论区中指出，或给我提 [Issue](https://github.com/JuliaRoadmap/zh/issues/new)。

内容来自贡献者与读者的持续修订。[在此阅读](https://github.com/JuliaRoadmap/zh/blob/master/CONTRIBUTING.md)如何贡献。

## 许可
本项目文档部分采用[知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议](https://creativecommons.org/licenses/by-nc-sa/4.0/)进行许可（来源通常以脚注形式标注在相应页面末）；代码部分采用 MIT license 进行许可。更多信息请参见 [README](https://github.com/JuliaRoadmap/zh#README)。

[^h]: https://discourse.juliacn.com/t/topic/5944/4
[^ds]: https://cn.julialang.org/JuliaDataScience
