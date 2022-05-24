# 关于
贡献规范`v1.0.2`

## 贡献流程
1. 需要贡献什么？是否是大幅度修改（包括新建）？
	- 若是，请先在[Discussion处](https://github.com/JuliaRoadmap/zh/discussions/1)查看是否该计划已存在，若否，请写出你的计划并继续
	- 若否，完成后直接推`pull request`
2. 按照说明找到对应文件/应新建的位置，若无法确定请在issue中提出
3. 根据格式规范写作
4. 提交`pull request`，等待回复

## 文件结构
### 说明
| 块名 | 描述 | 层级 | outline | names | tags | tagnames | 备注 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| meta | 类似如何学习、相关工具介绍的文档 | 多层 | Y | Y | | | |
| basic | Julia 基础语法 | 单层 | Y | | | | |
| advanced | 语法进阶（除`basic`外的重要知识点） | 单层 | Y | | | | |
| packages | 包的介绍与各包使用方式 | 单层 | Y | | Y | Y | |
| algorithms | 算法介绍与相关实现 | 多层 | | Y | | | |
| ecosystem | Julia 生态环境 | 多层 | Y | | | |
| knowledge | 相关常识/知识，包括[这些](https://discourse.juliacn.com/t/topic/4203) | 单层 | | | | | |
| tips | 解决`how-to`问题 | 多层 | | Y | Y | Y | [严格界定](docs/tips/about.md) |
| pieces | 相关代码片段 | 单层 | | | | |
| lists | 相关列表 | 单层 | | | | | |

### setting
`outline`，`names`，`tags`，`tagnames`信息存在各`setting.toml`中，没有的应省略\
提到文件时应省略后缀

### outline
一个`Vector{String}`，表示提纲，以HTML导出时会作为侧边栏且安装原顺序和层级排列

### names
一个`Dict{String,String}`表示各目录的中文

### tags
一个`Dict{String,Vector{String}}`表示各文件的标签，仅应包含同级目录中的内容

### tagnames
一个`Dict{String,Vector{String}}`，表示每个原tag可能的其它表达形式

## 命名规范
- 除去后缀后名称不应相同，且
	- 仅由小写字母、数字、下划线组成
	- 目录命名名词使用复数
	- 文件命名名词使用单数
	- 不能是`index`（HTMLify时会被自动生成）

## 格式规范
参照已有样例，允许按照实情进行一定程度的改动
* 使用`utf-8`，允许`CRLF/LF`
* （尽量）使用`Tab`缩进
* 使用`Markdown`，特别地，是`julia-markdown`，使用反斜杠`\`换行
* 文档开头使用`h1`的标题，之后就不应有`h1`
* 如果文档信息有来源，请以脚注形式加在页面底端，如果是该信息是结论，则应在该结论后标记对应的脚注链接
* 较专业性的内容第一次出现使用`翻译名(原名/缩写)`
* 如果文档有相关练习资源，在末尾（脚注前）添加`## 练习`，然后使用列表
	* 对于hydrooj习题，格式为`[Hydro 域名 题目id](完整链接)`
	* 对于leetcode习题，格式为`Leetcode 题目id`
	* 对于lightlearn，格式为`LightLearn 关卡id`
	* 欢迎增加资源
* 对于代码块名称
	* 不能留空（使用`plain`）
	* Julia 代码和`REPL`均使用`jl`
