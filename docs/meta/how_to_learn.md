# 如何学习
!!! note
	请根据[环境配置](../basic/setup_environment.md)的指示准备 Julia 环境，并可以选用一个[下方工具部分](#工具)的编辑器。

> 最好设定一个明确的、可评价目标。先把小目标实现了，再去学习细节，而不是陷入其中。[^3]
>
> 例如，您可以利用这个语言去做一些你想做的事，把它作为目标。

## 文档结构
* `basic` 目录下包含 Julia 语言的基础内容，这与大部分其它语言是相似的。阅读该部分能够提供使用此语言的基本开发能力。
* `advanced` 目录下包含 Julia 中较独特的特性和功能。
* 你可以根据[包简介](../blog/packages/introduction.md)的指示学会寻找、使用与制作你专业所需的包。例如数据科学可能需要阅读 `Dates`，`DataFrames`，`Makie` 的相关内容。[^4]

## 其它文档
推荐程度基本按照顺序，但是你可能有特定的需求；部分内容即由它们中的一些整合而来

| 名称 & 链接 | 主题 | 内容 |
| :-: | :-: | :-: |
| [中文文档](https://docs.juliacn.com/latest/) | 标准文档 | 语法、标准库、指导、开发 |
| [完善的“Julia语言入门”](https://www.math.pku.edu.cn/teachers/lidf/docs/Julia/html/_book/basics.html) | 充分学习、常见应用 | 语言基础、语言概述、包 |
| [Julia DataScience 中文版](https://cn.julialang.org/JuliaDataScience) | 数据科学 | 语言基础、包 |
| [概览与高性能编程](https://www.tongyuan.cc/docs/syslab/2025a/Help/JuliaLanguage/index.html#/Doc/JuliaLanguage/JuliaOverview.html#%E4%BB%80%E4%B9%88%E6%98%AFjulia) | 科学计算环境 | 语言概述、性能建议 |
| [Julia (Programming) Basics](https://www.bookstack.cn/read/hyper0x-JuliaBasics/README.md) | 电子书 | 语言基础 |
| [各领域 Julia 库的 awesome 列表](https://github.com/svaksha/Julia.jl) | 信息 | 包 |
| [cheatsheet](https://juliadocs.github.io/Julia-Cheat-Sheet/zh-cn/) | 快速学习 | 语言基础 |
| [菜鸟教程](https://www.runoob.com/julia/julia-tutorial.html) | 在线实例（大概） | 语言概述 |
| [Matlab-Python-Julia 对照](https://cheatsheets.quantecon.org/) | 对照、线代、快速学习 | 语言概述 |
| learn-julia-in-y-minutes [A](https://discourse.juliacn.com/t/topic/611) [B](https://learnxinyminutes.com/docs/zh-cn/julia-cn/) | 快速学习 | 语言概述 |
| [一本编程指南](https://rogerluo.dev/Brochure.jl/dev/) | 工程实践 | 语言概述、实践指导 |
| [将 Julia 作为数值计算器](https://krasjet.com/rnd.wlk/julia/) | 数据科学 | 语言基础、包 |
| [Modern Julia Workflows](https://modernjuliaworkflows.org/) | 工作流 | 现代的值得推荐的工作流程 |

## 视频教程
* [Julia 教程从入门到进阶](https://www.bilibili.com/video/BV1yt411c7Gm/)
* [Julia 入门系列之一起读文档](https://space.bilibili.com/356692611/channel/seriesdetail?sid=501523)
* [MIT《计算思维导论》2020秋季 18.S191 Introduction to Computational Thinking](https://www.bilibili.com/video/BV12V411m7zU/)
* [Julia for Data Science](https://www.bilibili.com/video/BV1XC4y1a7t3/)
* [同元的Julia教程](https://www.bilibili.com/video/BV1paNteWE1h/)

## 提出问题
* [中文论坛](https://discourse.juliacn.com/) | [国际论坛](https://discourse.julialang.org/) | [StackOverflow](https://stackoverflow.com/) | [快速非正式通信 - Slack](https://julialang.org/slack/) | [Forem](https://forem.julialang.org/logankilpatrick/the-julia-forem-what-it-is-why-we-made-one-and-how-to-use-it-52e5)
* [提问的艺术](https://blog.csdn.net/weixin_30587025/article/details/96616932) & 避免[X-Y问题](https://coolshell.cn/articles/10804.html)

## AI 辅助
* [在线使用 AskAI](https://juliahub.com/ui/AskAI) 官方为 Julia 特调的大语言模型
* [本地部署模型ollama](https://ollama.com/library/qwen2.5-coder) 7B的一些模型已经能回答得不错

## 工具
以下均是可选的
* 本地工作（下载 IDE）：[vscode（官方推荐）](../knowledge/vscode.md) | [julia-emacs](https://github.com/JuliaEditorSupport/julia-emacs) | [julia-vim](https://github.com/JuliaEditorSupport/julia-vim) | [sublime](https://www.luogu.com.cn/blog/acking/sublime)
	* [更多编辑器配置法可参阅](https://www.math.pku.edu.cn/teachers/lidf/docs/Julia/html/_book/basics.html#basics-inst)
* 版本控制：[git](../knowledge/git.md)
	* [Github](../knowledge/github.md)
	* Gitee 等
* 在线工作与共享：[Google colab](https://colab.research.google.com/) [(说明)](https://github.com/googlecolab/colabtools/issues/5151)
  
## 练习
以下均是可选的
* 本文档提供的文字描述或可交互的习题（少量页面有）
* 在线习题 [Hydro 平台](../knowledge/hydrooj.md) | 本地习题 [LeetCode 平台](../packages/leetcode.md)
* 本地游戏 [LightLearn](../packages/lightlearn.md)
* [欧拉计划](http://pe-cn.github.io/)

请注意，这不总是必要的，有时花在注册账号、找习题上的时间会很长。
建议使用这些平台练习算法或解决问题的思路而非「如何使用标准库提供的功能」。
对简单的问题，自己设计几组数据（需要覆盖各种情况）测试也是可以的。

## 相关链接
### 重要链接
- [相关Github组织列表](https://julialang.org/community/organizations/)
- [性能建议](https://docs.juliacn.com/latest/manual/performance-tips/)
- [帖子 - 自底向上理解Julia中的并行计算](https://discourse.juliacn.com/t/topic/462)

### 博客系列
* [The Julia Language Blog](https://julialang.org/blog/)
* [Modern Julia Workflows](https://modernjuliaworkflows.org/) - 选用什么包，如何优化，更多链接

### 中文媒体
* 微信公众号：JuliaCN
* bilibili：[JuliaLang中文社区](https://space.bilibili.com/356692611)

### 翻译计划
* [帖子 - 翻译计划](https://discourse.juliacn.com/t/topic/6810)

## 其它说明
如果您喜欢纸质书，当然可以阅读各式各样的资料，但此项目暂时还没有（可能不会有）任何书籍发售。

祝您顺利！

[^1]: https://discourse.juliacn.com/t/topic/159
[^2]: https://discourse.juliacn.com/t/topic/6002
[^3]: https://discourse.juliacn.com/t/topic/5944/4
[^4]: https://cn.julialang.org/JuliaDataScience
