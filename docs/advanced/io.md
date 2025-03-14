# I/O
[IO相关类型层次关系](../lists/typetree1.8.txt#L695-L722)

## IO
`IO` 是最广义的输入输出抽象类型

## IO流
`IOStream` 描述了一个带缓存的、操作系统输入输出流的包裹，它通常用于表示 `open` 所得

## IO上下文
`IOContext` 提供给 `show` 传递输出配置设置的机制，它有两个域：`io` 包裹了一个 `IO` 示例，而 `dict` 是一个不可变字典（`::Base.ImmutableDict{Symbol, Any}`），保存了相关设置。
可以使用 `IOContext(io::IO, KV::Pair...)` 从给定 IO 实例创建 IO上下文，也可用 `IOContext(io::IO, context::IOContext)`，这会复制各项设置。
通常来说，用于 `show` 的有以下设置：
* `compat`（`Bool`）：输出应该更*兼容*且保证没有换行，例如数字应显示更少数位（这个设置会在显示数组元素时使用）
* `limit`（`Bool`）：容器的输出应被缩短（例如使用 `…`）
* `displaysize`（`Tuple{Int, Int}`）：标注文字输出的行列数限制，这一设置可能被**覆盖（override）**，因此建议使用 `displaysize` 获取窗口大小
* `typeinfo`（`Type`）：标注相关的类型信息，这使得 `Float16(0)` 被显示为 `Float16(0.0)` 而不是 `Float16(Float16(0.0))`
* `color`（`Bool`）：标注是否支持（且希望）允许[文字风格](../basic/basicio.md#printstyled)

## IO缓冲区
`Base.GenericIOBuffer` 可以将数组作为缓冲区进行包裹。
`IOBuffer` 可以用于快速生成一个 `Base.GenericIOBuffer{Vector{UInt8}}` 实例，这可以方便地将常用数据包裹成 I/O
```julia-repl
julia> buf = IOBuffer()
IOBuffer(data=UInt8[...], readable=true, writable=true, seekable=true, append=false, size=0, maxsize=Inf, ptr=1, mark=-1)

julia> write(buf, "foo")
3

julia> String(take!(buf))
"foo"
```

## 管道
`Pipe` 函数可以创建一个未初始化的 `Pipe` 实例，当它用于进程生成时恰当的端将被自动初始化，从而很好地与 `pipeline` 同时使用。
`pipeline` 可以用于生成 `OrCmds` 实例，它的一个原型是 `pipeline(command; stdin, stdout, stderr, append=false)`，用于给指定命令重定向 I/O，其中 `append` 参数指定是否对于文件使用补加而不是覆盖。

另一个原型是 `pipeline(from, to, ...)`，用于创建从一个「数据来源」到「目的地」的管线，本质是 `pipeline(from; stdout=to)`。参数可以是[命令](cmd.md)，IO实例或字符串（表示文件路径），且保证至少一个参数是命令。
当接受多个参数时，会将形如 `pipeline(a, b, c)` 的处理成 `pipeline(pipeline(a, b), c)`。

参阅：[Julia使用命名管道进行跨进程通信的示例（PowerShell）](https://discourse.juliacn.com/t/topic/2687)

## 通用函数
| 名称 | 描述 |
| --- | --- |
| `read(io::IO, T)` | 从 `io` 中读取 `T` 类型的单个值，使用标准二进制表示，需手动使用 `ntoh`，`ltoh` 调整[大小端](https://www.ruanyifeng.com/blog/2022/06/endianness-analysis.html) |
| `read(io::IO, String)` | 将整个 `io` 作为字符串读入 |
| ` read(s::IO, nb=typemax(Int))` | 从 `s` 中读入最多 `nb` 个字符，返回 `Vector{UInt8}` 实例 |
| `read!(stream::IO, array::AbstractArray)` | 从 `io` 中读取二进制数据填充 `array` |
| `write(io::IO, x)` | 将 `x` 的二进制表示写入 `io` |
| `print([io::IO], xs...)` | 将若干个参数 `xs` 中的文字表示写入 `io` |
| `show` | [自定义显示](typesystem.md#自定义显示) |
| `flush` | 提交所有缓存 |

## 标记
许多 I/O 类型支持以下标记处理函数：
| 函数名 | 功能 |
| :-: | :-: |
| `mark` | 在当前位置作标记 |
| `unmark` | 取消标记（若有） |
| `ismarked` | 查看是否有标记 |
| `reset` | 跳到上一个标记（无标记则抛出错误） |
