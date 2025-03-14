# 贡献规范
接受的内容包括新的章节、完善内容、补充信息、添加练习等

## 贡献流程
1. 按照说明找到对应文件/应新建的位置，若无法确定请在 issue 中提出
2. 根据格式规范写作
3. 提交 `pull request`，等待回复

## 文件结构
### 说明
| 块名 | 描述 |
| :-: | :-: |
| `meta` | 类似如何学习、相关工具介绍的文档 |
| `basic` | Julia 基础语法 |
| `advanced` | 语言进阶（除 `basic` 外的重要知识点） |
| `packages` | 各包使用方式 |
| `algorithms` | 算法介绍与相关实现 |
| `ecosystem` | Julia 生态环境 |
| `knowledge` | 相关常识/知识，包括但不限于[这些](https://discourse.juliacn.com/t/topic/4203) |
| `blog` | 更广泛的话题，包含日报部分 |
| `pieces` | 相关代码片段 |
| `lists` | 相关列表 |

## 格式规范
参照已有样例及 [DoctreePages 规范](https://github.com/JuliaRoadmap/DoctreePages.jl)，且应
* 使用 `utf-8`
* 中文与英文、数字间加空格，若有中文标点则可不加空格
* 诸如 Julia、Windows 等词不使用 ``` `` ``` 且首字母大写
* 如果文档信息有来源，请以脚注形式加在页面底端，如果是该信息是结论，则应在该结论后标记对应的脚注链接
* 建议用「这个」**适当**替代引号，可以设置输入法中「用户自定义短语」以方便输入
* 具有专业性的名词第一次出现使用 `**翻译名（原名或缩写，别名）**` 标注其各个常见名词，之后出现时使用 `「翻译名」`
* 如果有希望用户阅读而不出现在脚注中的文档，应在末尾（脚注前）添加 `## 参阅` ，然后使用无序列表
* 如果文档有相关练习资源，在末尾（脚注前）添加标题 `## 练习`，然后使用无序列表
	* 对于 HydroOJ 习题，格式为 `[Hydro 域名 题目id](完整链接)`
	* 对于 Leetcode 习题，格式为 `Leetcode 题目id`
	* 欢迎增加练习来源

允许按照实情进行一定程度的改动
