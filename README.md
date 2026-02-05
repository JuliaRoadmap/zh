## 关于
![](https://img.shields.io/badge/LICENSE-CC%20BY--NC--SA%204.0-lightgrey)

欢迎阅读 Julia 中文导航！这是一个社区支持的计划，旨在帮助学习者更好地了解、掌握和精通 Julia 语言，并提供学习路径、资料整合、现有经验及练习。

更多内容见[主页](https://learn.juliacn.com/)。

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
julia> using DoctreePages

julia> DoctreePages.generate("./zh", "./zh-output");
```

构建的自动化流程为（commit message 含 `[nobuild]` 表示不构建）
1. 调用 `DoctreePages` 生成目标结果
2. 同步到 juliacn 服务器

如果 workflow 运行失败，应确认原因后尝试 re-run

## TODO
文档覆盖
- [ ] [Modern Julia Workflows](https://modernjuliaworkflows.org/)
- [x] Julia DataScience
- [x] [Road2Coding](https://github.com/rd2coding/Road2Coding)
- [ ] [noob-data-analysis](https://github.com/noob-data-analaysis/data-analysis)
	- [x] 数据分析
	- [ ] 数据变换
	- [ ] Plots
	- [ ] ~~DataFrames~~

建议参考
- [ ] [中文文档](https://docs.juliacn.com/latest/)

介绍覆盖
- [ ] 介绍[部分包分类](docs/workflow/classify.md) 中的各包文档

其它
- [ ] 提供足够的练习
