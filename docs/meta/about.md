# 主页
## 关于
![JuliaRoadmap-soft-gold](https://img.shields.io/badge/JuliaRoadmap-soft-gold) 是一个社区支持的计划，旨在帮助学习者更好地了解、掌握和精通 Julialang 语言，并提供学习路径、资料整合、现有经验及练习。[^1]

## 许可
本项目文档部分采用[知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议](https://creativecommons.org/licenses/by-nc-sa/4.0/)进行许可（来源通常以脚注形式标注在相应页面末）；代码部分采用 MIT license 进行许可。更多信息请参见 [README](https://github.com/JuliaRoadmap/zh#README)

## 网站说明
- 文中的链接可能指向相关知识、您已读过或未读过的内容。[^2]
- 上方的齿轮状按钮可以用于调节亮暗色模式
- 侧边栏表示推荐的阅读顺序，可以用于跳转到指定页面与二级标题（其中章节名跳转到索引页面：**部分文档不在侧边栏中显示**）
- 下方的讨论区可以在注册 [Github](../knowledge/github.md) 后使用

## 特性指南
文档中部分链接可能在已学知识的后面，可以提前了解或抱着“这东西迟早读到”的心态继续阅读。
下方的设置决定了是否添加“新手友好”信息。这个设置会被存储在浏览器缓存中。[^3]

```insert-setting
type = "select-is"
content = "您是否有使用编程语言的相关经验？"
default = "yes"
choices = {"yes"="是", "no"="否"}
store = {"yes"="!is-newbie", "no"="is-newbie"}
```

## 已知问题
- 讨论区可能由于网络不稳定而加载失败，此时可以尝试重试
- 部分表格解析有问题，这是上游 CommonMark 的 bug

[^1]: [在此阅读如何贡献](https://github.com/JuliaRoadmap/zh/blob/master/CONTRIBUTING.md)
[^2]: 如果不想点开，可利用许多浏览器支持的在鼠标悬停时预览目标地址的功能判断
[^3]: 如果有 javascript 基础，可以手动配置 `localStorage` 的 `is-newbie` 项
