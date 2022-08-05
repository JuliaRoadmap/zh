# 关于
贡献规范 `v1.4.1`

## 贡献流程
1. 按照说明找到对应文件/应新建的位置，若无法确定请在issue中提出
2. 根据格式规范写作
3. 提交`pull request`，等待回复（注：commit message含`[nobuild]`表示不构建pages）

## 文件结构
### 说明
| 块名 | 描述 |
| --- | --- |
| meta | 类似如何学习、相关工具介绍的文档 |
| basic | Julia 基础语法 |
| advanced | 语法进阶（除`basic`外的重要知识点，可以不限于语法） |
| packages | 包的介绍与各包使用方式 |
| algorithms | 算法介绍与相关实现 |
| ecosystem | Julia 生态环境 |
| knowledge | 相关常识/知识，包括但不限于[这些](https://discourse.juliacn.com/t/topic/4203) |
| blog | 更广泛的话题，包含日报部分 |
| pieces | 相关代码片段 |
| lists | 相关列表 |

## 格式规范
参照已有样例及 [DoctreePages规范](https://github.com/JuliaRoadmap/DoctreePages.jl)，且应
* 使用`utf-8`
* （尽量）使用 `Tab` 缩进
* 如果文档信息有来源，请以脚注形式加在页面底端，如果是该信息是结论，则应在该结论后标记对应的脚注链接
* 建议用「这个」适当替代引号
* 较专业性的内容第一次出现使用 `翻译名(原名/缩写)` ，``` `` ```可以改为「」
* 如果有希望用户阅读而不出现在脚注中的文档，应在末尾（脚注前）添加 `## 参阅` ，然后使用无序列表
* 如果文档有相关练习资源，在末尾（脚注前）添加`## 练习`，然后使用无序列表
	* 对于hydrooj习题，格式为`[Hydro 域名 题目id](完整链接)`
	* 对于leetcode习题，格式为`Leetcode 题目id`
	* 对于lightlearn，格式为`LightLearn 关卡id`
	* 欢迎增加资源

允许按照实情进行一定程度的改动
