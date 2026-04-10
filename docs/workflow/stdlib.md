# 标准库说明
可以在[中文文档](https://docs.juliacn.com/latest/)侧边栏“标准库”一列看到当前标准库的列表。

部分标准库是位于 `Base` 下的子[模块](../advanced/module.md)，部分标准库可能需要安装。

## 参阅
- [近来部分包被建议移出标准库的相关信息](https://discourse.juliacn.com/t/topic/6323)
- [What is a Julia standard library?](https://github.com/JuliaLang/julia/discussions/43116)

## CRC32c

CRC32c 提供了 CRC-32c 校验函数 `crc32c`，它的原型是 `crc32c(data, crc::UInt32=0x00000000)`，其中 `data` 可以是 `Array{UInt8}` 实例（或它的连续子数组）或字符串。crc 被传递用于与结果混合；在技术上，按照小端计算
!!! note
	`crc32c(data2, crc32c(data1))` 相当于 `crc32c([data1; data2])`

!!! warn
	校验结果可能与[大小端](https://www.ruanyifeng.com/blog/2022/06/endianness-analysis.html)、字符串编码有关

`crc32c(io::IO, [nb::Integer,] crc::UInt32=0x00000000)` 从 `io` 中读取至多 `nb` 个字节并返回 `CRC-32c` 校验结果（不指定 `nb` 时全部读入）

## 相关文档
- [Dates - 日期与时间](../packages/dates.md)
- [Downloads - 基本爬虫需求](../packages/downloads.md)
- [Markdown - Markdown 格式的解析与导出](../packages/markdown.md)
- Pkg - 包管理：<https://cn.julialang.org/Pkg.jl/dev/>
- [Random - 随机](../packages/random.md)
- [Sockets - 套接字](../packages/sockets.md)
- [TOML - 同名格式的解析和导出](../packages/toml.md)
- [Unicode - Unicode 工具](../knowledge/unicode.md)
- [UUIDs - 通用唯一辨识符的生成](../packages/uuids.md)
