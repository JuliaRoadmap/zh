# 关于
**JuliaRoadmap** 是一个计划，旨在帮助用户更好地了解、掌握和精通Julia，提供学习路径、资料整合和现有经验，提供对应练习，解决现有中文文档的不符合认知规律等问题。[如何贡献](https://github.com/JuliaRoadmap/zh/blob/master/CONTRIBUTING.md)\
本项目文档部分采用[知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议](https://creativecommons.org/licenses/by-nc-sa/4.0/)进行许可（来源标注在相应页面末），代码部分采用MIT license进行许可

## 网站功能
- 可以点击蓝色的链接，可能指向相关知识/您已读过的内容（许多浏览器支持在鼠标悬停时预览目标地址）
- 上方的齿轮状按钮可以用于调节亮/暗色模式
- 侧边栏可以用于跳转（其中章节名跳转到索引页面：**有许多文档不放在侧边栏**）
- 下方的讨论区可以在注册 github 后进行讨论

## 特性指南
- 文档中部分链接可能在已学知识的后面，你可以提前了解或抱着“这东西迟早读到”的心态继续阅读
- 下方的设置决定了是否添加部分内容，会被存储在浏览器缓存中。如果你有 javascript 基础，也可以配置 `localStorage` 的 `is-newbie` 项

## 设置
```insert-setting
type = "select-is"
content = "您是否有使用编程语言的相关经验？"
default = "yes"
choices = {"yes"="是", "no"="否"}
store = {"yes"="!is-newbie","no"="is-newbie"}
```

## 已知问题
- 讨论区可能由于网络不稳定而加载失败，此时可以尝试重试
- 部分表格解析有问题，这是上游 CommonMark 的 bug，已进行[反馈](https://github.com/MichaelHatherly/CommonMark.jl/issues/44)
