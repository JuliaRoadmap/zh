# 内容组织
* 通过阅读各`setting.json`了解已有的计划、了解作用
* 当前对于新建操作在[此](https://github.com/JuliaRoadmap/zh/discussions/1)规划，修改操作直接推即可

# 文档结构规范
如你所见，`docs/`中每个目录下都存在一个`setting.json`
* 键`names`表示各文件（仅包含文件名）、目录的中文名
* 键`order`表示文件、目录在大纲上的显示顺序（没有的表示不显示，可能出现整个键没有的情况）
* 键`tags`表示标签，每个名对应一个数组，该键仅应出现在`algorithms`、`pieces`、`packages`、`tips`中
* 在键`tag`存在时，有键`tagnames`表示每个原tag可能的中文翻译和变形
* 文件、目录（除去后缀）后名不应相同，且仅由小写字母、数字、下划线组成
* 严格分类，如创建新分类最好在issue中讨论

# 接受的文档示例
* vscode的安装 => `meta/tools/vscode.md`
* task的使用 => `advanced/task.md`
* 如何把markdown导出成pdf => `tips/transform/markdown2pdf.md`
* 2011年julia加入了… => `ecosystem/history/2011.md`
* 关键字列表 => `lists/keywords.md`
* Cairo的基础使用 => `packages/cairo.md`
* 实用代码片段：正则表达式处理url => `pieces/regex_url.md`
* 在julia中写快速排序 => `algorithms/basic/sort.md#quicksort`

# 格式规范
* 文档开头使用`h1`的标题，内容与`setting.json : names`对应内容相同
* 如果文档信息有来源，请以脚注形式加在页面底端，如果是该信息是结论，则应在该结论后标记对应的脚注链接
* 参照[样例](docs/meta/introduction.md)
* 较专业性的内容第一次出现使用`翻译名(原名/缩写)`
* 如果文档有相关练习资源，在末尾（脚注前）添加`## 练习`，然后使用列表
	* 对于hydrooj习题，格式为`[Hydro 域名 题目id](完整链接)`
	* 对于leetcode习题，格式为·`Leetcode 题目id`
	* 对于lightlearn，格式为`LightLearn 关卡id`
	* 欢迎增加资源
* 使用反斜杠`\`换行
* （尽量）使用`Tab`缩进
