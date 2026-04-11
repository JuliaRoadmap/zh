## 关于
![](https://img.shields.io/badge/LICENSE-CC%20BY--NC--SA%204.0-lightgrey)

欢迎阅读 Julia 中文导航。这是一项由社区共同维护的开源文档计划：把分散在官方手册、论坛帖子和个人博客里的入门路径，整理成一条可以按顺序阅读、也可以按需跳转的学习路线，降低中文读者上手 Julia 时的信息成本。

更多内容见于[主页](https://learn.juliacn.com/docs/meta/about.html)。

欢迎有贡献意向者阅读[贡献指南](./CONTRIBUTING.md)。

## 许可
本项目文档部分采用[知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议](https://creativecommons.org/licenses/by-nc-sa/4.0/)进行许可（来源标注在相应页面末），代码部分采用 MIT license 进行许可。

图像及部分内容的来源包括：
| 来源 | 说明 |
| :-: | :-: |
| <https://julialang.org/assets/images/benchmarks.svg>| 复制于 2022/5/23 |
| <https://github.com/noob-data-analaysis/data-analysis> | <https://discourse.juliacn.com/t/topic/6223/56> |
| <https://github.com/SAST-skill-docers/sast-skill-docs> | <https://github.com/SAST-skill-docers/sast-skill-docs/issues/33#issuecomment-1187707229> |

其余图像为原创，采用 MIT license 进行许可。

## 维护
本地测试文档生成效果的流程形如：
```julia
julia> using Pkg; Pkg.instantiate()

julia> include("make.jl")
```

构建输出在 `build/` 目录中，可以使用 `LiveServer` 进行实时预览：
```julia
julia> using LiveServer; serve(dir="build")
```

每次 push 到 GitHub 时会运行自动化构建脚本为（可以在 commit message 中标记 `[nobuild]` 表示不构建）
1. 调用 `Documenter.jl` 生成 HTML 文档到 `public/docs`
2. 将当前目录推送到 JuliaCN 服务器

如果 workflow 运行失败，应确认原因后尝试重新运行。

## TODO
- [ ] 提供足够的练习

文档覆盖：
- [x] [Modern Julia Workflows](https://modernjuliaworkflows.org/)
- [x] Julia DataScience
- [x] [Road2Coding](https://github.com/rd2coding/Road2Coding)
- [x] [noob-data-analysis](https://github.com/noob-data-analaysis/data-analysis)
	- [x] 数据分析
	- [ ] ~~数据变换~~
	- [ ] ~~Plots~~
	- [ ] ~~DataFrames~~
