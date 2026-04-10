# 爬虫
## 知识
- [Web 知识](https://developer.mozilla.org/zh-CN/)
- [Web 如何运作](https://developer.mozilla.org/zh-CN/docs/Learn/Getting_started_with_the_web/How_the_Web_works)

## 包
爬虫可以使用方便的 [Downloads](../packages/downloads.md) 包或选项多的 [HTTP](https://juliaweb.github.io/HTTP.jl/stable/) 包。

## 注意事项
1. 大多数网站的根目录存在 `robots.txt`，标注了管理者允许爬虫访问的范围，原则上应该履行。
2. 短时间大量访问或类似行为可能会被视作 [DOS/DDOS 攻击](https://www.bilibili.com/video/BV1KQ4y117nq)。

!!! warn
	不合理的爬虫使用可能违反相关法律

## 工具
善用浏览器的开发者工具
- [Edge 开发者工具文档](https://docs.microsoft.com/zh-cn/microsoft-edge/devtools-guide-chromium/network/)
