# Markdown
Markdown 是一种被广泛使用的轻量级标记语言。它的总体规范相近，但在不同平台上常有细节差异，例如 GitHub 的 GFM（GitHub Flavored Markdown）与常用标准 [CommonMark](https://spec.commonmark.org/)。Julia 代码内文档采用的规范可参见 [Julia Markdown](https://docs.juliacn.com/latest/stdlib/Markdown/)。

一些 Markdown 变体允许嵌入 [LaTeX](latex.md) 的变体来表达数学公式。

利用 [vscode](vscode.md#markdown-编辑) 或其它高级编辑器，可以轻松编辑 Markdown。你也可以使用一些网站[免费转为其它格式](https://www.easeconvert.com/markdown-to-pdf/)。

## 常用语法速查
类似的内容可以简单地在互联网中搜索得到，如 <https://docs.net9.org/basic/markdown/>。

| 效果 | 写法 |
| :-: | :-: |
| 一级标题 | `# 标题文字` |
| 二级标题 | `## 标题文字`（可继续增加 `#` 到六级） |
| **粗体** | `**文字**` 或 `__文字__` |
| *斜体* | `*文字*` 或 `_文字_` |
| ~~删除线~~ | `~~文字~~` |
| `行内代码` | 用反引号包裹：`` `代码` `` |
| 代码块 | 用三个反引号包裹，可在开头注明语言（如 ` ```julia `） |
| [链接](https://example.com) | `[显示文字](url)` |
| 图片 | `![描述文字](图片路径或url)` |
| > 引用块 | 每行以 `> ` 开头 |
| 无序列表 | `- 项目` 或 `* 项目` |
| 有序列表 | `1. 项目`（编号会自动处理） |
| 水平分割线 | `---` 或 `***` |
| 表格 | 见下方示例 |

表格的基本写法：

```plain
| 列1 | 列2 | 列3 |
| --- | :-: | --: |
| 左对齐 | 居中 | 右对齐 |
```

其中 `---` 表示左对齐（默认），`:-:` 表示居中，`--:` 表示右对齐。
