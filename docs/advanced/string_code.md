# 字符串编码
Julia 中的 `String` 并不具有一个特定的编码类型，包括但不限于 `ASCII`、`Latin-1`、`UTF-8`、`UCS-2`、`UTF-16` 和 `UTF-32`，每个字符占据一定的连续空间，但仍以 `Char` 形式导出。

Julia 中 `String` 所采用的编码的基本假设是**自同步（self-synchronizing）**。

以该字符串 `s` 为例（`UTF-8`）：
| 直观编号 | `Char` | 所占字节数 |
| --- | --- | --- |
| 1 | `3` | 1 |
| 2 | `θ` | 2 |
| 3 | `猫` | 3 |

## 相关函数
| 函数原型 | 描述 | 举例 | 备注 |
| --- | --- | --- | --- |
| `length(s::AbstractString) -> Int` | s的直观字符数 | `length(s) = 3` | 时间复杂度与字符串长度线性正相关 |
| `ncodeunits(s::AbstractString) -> Int` | s的实际字节数 | `length(s) = 6` | 也可用 `sizeof` |
| `ncodeunits(c::Char) -> Int` | `UTF-8` 格式表示 `c` 所需字符数 | `ncodeunits('猫') = 3` | |
| `length(s::AbstractString, i::Integer, j::Integer) -> Int` | s 中实际字节 `i~j` 所包含的直观字节数（识别开头位置），特别地，当 i 为 `ncodeunits(s) + 1` 或 j 为 0 时返回 0 | `length(s, 3, 4) = 1` | |
| `isvalid(s::AbstractString, i::Integer) -> Bool` | s 的第 i 个字节是否是某个字符空间块的起点 | `isvalid(s,5) = false` | |
| `getindex(s::AbstractString, i::Int) -> Char` | 获取 s 的第 i 个字节所在字符，i 为该字符空间块的起点 | `s[4] = '猫'` | |
| `getindex(s::AbstractString, r::UnitRange{Integer}) -> String` | 通过实际字节索引获取 s 的子字符串，其中 `isvalid(s, r.start)`，`isvalid(r.stop)` | `s[2:4] = "θ猫"` | |
| `thisind(s::AbstractString, i::Integer) -> Int` | 获取第 i 个字节所在字符空间块的起点，特别地，当 i 为 0 或 `ncodeunits(s) + 1` 时返回 i | `thisind(s, 5)=4` | 错误抛出 `BoundsError` |
| `nextind(str::AbstractString, i::Integer, n::Integer=1) -> Int` | `n=1` 时返回 s 中跟随在下标 i 后面的合法字符字节下标，详见对应帮助 | `nextind(s,0,3) = 4` | 可以通过 `nextind(s, 0, i)` 获取第 i 个直观字符的空间块起点 |
| `prevind(str::AbstractString, i::Integer, n::Integer=1) -> Int` | `n=1`时返回 s 中跟随在下标 i 前面的合法字符字节下标，详见对应帮助 | / | |
| `codeunit(s::AbstractString) -> Type{<:Union{UInt8, UInt16, UInt32}}` | 导出 s 编码的 bit 数 | `codeunit(s) = UInt8` | |
| `codeunit(s::AbstractString, i::Integer) -> Union{UInt8, UInt16, UInt32}` | 导出 s 在实际编号 i 处的数据 | `codeunit(s, 1) = 0x33` | `codeunit(s, i)::codeunit(s)` |
| `codeunits(s::AbstractString)` | 导出 s 的全部字节数据 | `Vector{UInt8}(codeunits(s))[1] = 0x33` | |

!!! note
	通常来说，越界抛出 `BoundsError`，而不在字符空间块起点位置（使用 `isvalid` 检查）抛出 `StringIndexError`

[Unicode 中也提供了一些相关函数](../packages/unicode.md)

## 选择
- 如果处理的是纯标准 ASCII 内容，可以不使用以 `ind` 结尾的函数，只需进行「下标 += 1」等操作即可
- 如果处理英语、常见欧洲语言、中文等只需使用上述函数
- 如果需处理印度语、泰语、emoji 或其它复杂物体，可能需要注意下述[一些坑](../knowledge/unicode.md#坑)
