# 关于
![JuliaRoadmap-soft-gold](https://img.shields.io/badge/JuliaRoadmap-soft-gold) 是一个计划，旨在帮助学习者更好地了解、掌握和精通 Julialang，并提供学习路径、资料整合、现有经验及练习，解决现有中文文档的不符合认知规律等问题。[在此阅读如何贡献](https://github.com/JuliaRoadmap/zh/blob/master/CONTRIBUTING.md)

## 许可
本项目文档部分采用[知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议](https://creativecommons.org/licenses/by-nc-sa/4.0/)进行许可（来源通常以脚注形式标注在相应页面末）；代码部分采用 MIT license 进行许可。更多信息请参见 [README](https://github.com/JuliaRoadmap/zh#README)

## 网站说明
- 链接可能指向相关知识/您已读过的内容（许多浏览器支持在鼠标悬停时预览目标地址）
- 上方的齿轮状按钮可以用于调节亮暗色模式
- 侧边栏可以用于跳转（其中章节名跳转到索引页面：**有许多文档不放在侧边栏**）
- 下方的讨论区可以在注册 [github](../knowledge/github.md) 后进行讨论

## 特性指南
- 文档中部分链接可能在已学知识的后面，可以提前了解或抱着“这东西迟早读到”的心态继续阅读
- 下方的设置决定了是否添加部分内容。这个设置会被存储在浏览器缓存中，如果您有 javascript 基础，也可以手动配置 `localStorage` 的 `check newbie` 项

```insert-setting
type = "select-is"
content = "您是否有使用编程语言的相关经验？"
default = "yes"
choices = {"yes"="是", "no"="否"}
store = {"yes"="!check newbie", "no"="check newbie"}
```

## 已知问题
- 讨论区可能由于网络不稳定而加载失败，此时可以尝试重试
- 部分表格解析有问题，这是上游 CommonMark 的 bug，可能会在近期修复
- 若当前网址为纯的 “learn.juliacn.com”，下方小箭头无法使用，请使用侧边按钮
