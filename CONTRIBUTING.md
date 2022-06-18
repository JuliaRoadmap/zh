# 关于
贡献规范`v1.2.0`

## 贡献流程
1. 按照说明找到对应文件/应新建的位置，若无法确定请在issue中提出
2. 根据格式规范写作
3. 提交`pull request`，等待回复

## 文件结构
### 说明
| 块名 | 描述 | 层级 |
| --- | --- | --- |
| meta | 类似如何学习、相关工具介绍的文档 | 多层 |
| basic | Julia 基础语法 | 单层 |
| advanced | 语法进阶（除`basic`外的重要知识点） | 单层 |
| packages | 包的介绍与各包使用方式 | 单层 |
| algorithms | 算法介绍与相关实现 | 多层 |
| ecosystem | Julia 生态环境 | 多层 |
| knowledge | 相关常识/知识，包括但不限于[这些](https://discourse.juliacn.com/t/topic/4203) | 单层 |
| tips | 解决`how-to`问题 [严格界定](docs/tips/about.md) | 多层 |
| pieces | 相关代码片段 | 单层 |
| lists | 相关列表 | 单层 |

## 格式规范
参照已有样例，允许按照实情进行一定程度的改动，\
参照[DoctreePages规范](https://github.com/JuliaRoadmap/DoctreePages.jl)
* 使用`utf-8`，允许`CRLF/LF`
* （尽量）使用`Tab`缩进
* 使用`Markdown`，特别地，是`julia-markdown`，使用反斜杠`\`换行
* 如果文档信息有来源，请以脚注形式加在页面底端，如果是该信息是结论，则应在该结论后标记对应的脚注链接
* 建议用「这个」替代引号
* 较专业性的内容第一次出现使用`翻译名(原名/缩写)`
* 如果有希望用户阅读而不出现在脚注中的文档，应在末尾（脚注前）添加`## 参阅`，然后使用列表
* 如果文档有相关练习资源，在末尾（脚注前）添加`## 练习`，然后使用列表
	* 对于hydrooj习题，格式为`[Hydro 域名 题目id](完整链接)`
	* 对于leetcode习题，格式为`Leetcode 题目id`
	* 对于lightlearn，格式为`LightLearn 关卡id`
	* 欢迎增加资源
