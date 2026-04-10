# 学习资源
## 社区与帮助
在开始编写代码之前，了解在哪里寻求帮助十分重要。Julia 的[官方帮助页面](https://julialang.org/about/help/)是很好的起点，Julia 社区十分欢迎初学者。[^3]

- [Discourse 国际论坛](https://discourse.julialang.org/) 及 [StackOverflow](https://stackoverflow.com/) 是提问的推荐场所，便于日后其他用户搜索到答案
- 中文社区可访问 [Julia 中文论坛](https://discourse.juliacn.com/)
- [Zulip](https://julialang.zulipchat.com/register/)（开源）或 [Slack](https://julialang.org/slack/) 适合实时交流
- [StartHere.jl](https://github.com/JuliaCommunity/StartHere.jl) 提供一份社区常用词汇概览
- [Forem](https://forem.julialang.org/logankilpatrick/the-julia-forem-what-it-is-why-we-made-one-and-how-to-use-it-52e5) 是一个内容分享平台

在提问前，建议参考阅读[提问的艺术](https://blog.csdn.net/weixin_30587025/article/details/96616932)与[避免X-Y问题](https://coolshell.cn/articles/10804.html)，使自己的问题更清晰明确，得到更有用的帮助。

在 AI 时代，也可向 AI 提问或者使用 AI 生成代码的功能。一个官方为 Julia 特调的大语言模型在 [AskAI](https://juliahub.com/ui/AskAI)，也可考虑[本地部署模型 ollama](https://ollama.com/library/qwen2.5-coder)（由于 AI 迭代速度相当快，此文档无法跟进最新的进展，读者可自行搜索）。

## 信息来源
### 文档教程
| 名称 & 链接 | 主题 | 内容 |
| :-: | :-: | :-: |
| [中文文档](https://docs.juliacn.com/latest/) | 标准文档 | 语法、标准库、指导、开发 |
| [完善的“Julia语言入门”](https://www.math.pku.edu.cn/teachers/lidf/docs/Julia/html/_book/basics.html) | 充分学习、常见应用 | 语言基础、语言概述、包 |
| [Modern Julia Workflows](https://modernjuliaworkflows.org/) | 工作流 | 写、分享、优化代码的一切 |
| [Julia DataScience 中文版](https://cn.julialang.org/JuliaDataScience) | 数据科学 | 语言基础、包 |
| [概览与高性能编程](https://www.tongyuan.cc/docs/syslab/2025a/Help/JuliaLanguage/index.html#/Doc/JuliaLanguage/JuliaOverview.html#%E4%BB%80%E4%B9%88%E6%98%AFjulia) | 科学计算环境 | 语言概述、性能建议 |
| [Julia (Programming) Basics](https://www.bookstack.cn/read/hyper0x-JuliaBasics/README.md) | 电子书 | 语言基础 |
| [cheatsheet](https://juliadocs.github.io/Julia-Cheat-Sheet/zh-cn/) | 快速学习 | 语言基础 |
| [菜鸟教程](https://www.runoob.com/julia/julia-tutorial.html) | 在线实例（大概） | 语言概述 |
| [Matlab-Python-Julia 对照](https://cheatsheets.quantecon.org/) | 对照、线代、快速学习 | 语言概述 |
| learn-julia-in-y-minutes [A](https://discourse.juliacn.com/t/topic/611) [B](https://learnxinyminutes.com/docs/zh-cn/julia-cn/) | 快速学习 | 语言概述 |
| [一本编程指南](https://rogerluo.dev/Brochure.jl/dev/) | 工程实践 | 语言概述、实践指导 |
| [将 Julia 作为数值计算器](https://krasjet.com/rnd.wlk/julia/) | 数据科学 | 语言基础、包 |

### 视频教程
* [Julia 教程从入门到进阶](https://www.bilibili.com/video/BV1yt411c7Gm/)
* [Julia 入门系列之一起读文档](https://space.bilibili.com/356692611/channel/seriesdetail?sid=501523)
* [MIT《计算思维导论》2020秋季 18.S191 Introduction to Computational Thinking](https://www.bilibili.com/video/BV12V411m7zU/)
* [Julia for Data Science](https://www.bilibili.com/video/BV1XC4y1a7t3/)
* [同元的 Julia 教程](https://www.bilibili.com/video/BV1paNteWE1h/)

### 自媒体/博客
* [Julia 英文社区的学习资料索引](https://julialang.org/learning/)
* [The Julia Language Blog](https://julialang.org/blog/)：官方的大事发布
* [Julia Community](https://forem.julialang.org/)
* [Julia Bloggers](https://www.juliabloggers.com/)
* 微信公众号：JuliaCN
* bilibili：[JuliaLang中文社区](https://space.bilibili.com/356692611)

### 其它
* [相关 Github 组织列表](https://julialang.org/community/organizations/)
* [帖子 - 翻译计划](https://discourse.juliacn.com/t/topic/6810)
* [Julia 技术翻译计划](https://docs.qq.com/sheet/DVFhYSUN6S2pxZERC?tab=BB08J2)（腾讯文档）

## 练习
对于把 Julia 语言作为学习的第一个语言的读者来说，可以参考以下平台上的问题，练习解决问题的思路：
* 知名平台 [LeetCode 力扣](https://leetcode.cn/)，可[在此看到使用 Julia 语言的解答](https://cn.julialang.org/LeetCode.jl/dev/)
* [HydroOJ](https://hydro.ac/)：算法竞赛为主，可提交 Julia 代码
* [欧拉计划](http://pe-cn.github.io/)：数学为主

在在线平台上递交时，建议将代码包裹进函数中以方便优化。[^3]
```jl
function main()
	# 代码
end

main()
```

[^1]: https://discourse.juliacn.com/t/topic/159
[^2]: https://discourse.juliacn.com/t/topic/6002
[^3]: [“写函数，而不是写脚本。”](https://docs.juliacn.com/latest/manual/performance-tips/#%E5%BD%B1%E5%93%8D%E6%80%A7%E8%83%BD%E7%9A%84%E5%85%B3%E9%94%AE%E4%BB%A3%E7%A0%81%E5%BA%94%E8%AF%A5%E5%9C%A8%E5%87%BD%E6%95%B0%E5%86%85%E9%83%A8)
