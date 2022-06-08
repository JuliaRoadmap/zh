# I/O
[IO相关类型层次关系](../lists/typetree1.6.txt#L630-L657)

## IO
`IO`是最广义的输入输出抽象类型

## IO流
`IOStream`描述了一个带缓存的、操作系统输入输出流的包裹，它通常用于表示`open`所得

## IO上下文
`IOContext`提供给`show`传递输出配置设置的机制，它有两个域：`io`包裹了一个`IO`示例，而`dict`是一个不可变字典（`::Base.ImmutableDict{Symbol, Any}`），保存了相关设置\
可以使用`IOContext(io::IO, KV::Pair...)`从给定IO实例创建IO上下文 或 `IOContext(io::IO, context::IOContext)`，这会复制相关设置\
通常来说，用于`show`的有以下设置：
* `compat`（`Bool`）：输出应该更*兼容*且保证没有换行，例如数字应显示更少数位（这个设置会在显示数组元素时使用）
* `limit`（`Bool`）：容器的输出应被缩短（例如使用`…`）
* `displaysize`（`Tuple{Int,Int}`）：标注文字输出的行列数限制，它可能被`覆盖(override)`，因此建议使用`displaysize`获取窗口大小
* `typeinfo`（`Type`）：标注相关的类型信息，这使得`Float16(0)`被显示为`Float16(0.0)`而不是`Float16(Float16(0.0))`
* `color`（`Bool`）：标注是否支持（且希望）允许[文字风格](../basic/print.md#printstyled)

## IO缓冲区
`Base.GenericIOBuffer`可以将数组作为缓冲区包裹\
`IOBuffer`可以用于快速生成一个`Base.GenericIOBuffer{Vector{UInt8}}`实例，这可以方便地将常用数据包裹成I/O
```jl
julia> buf=IOBuffer()
IOBuffer(data=UInt8[...], readable=true, writable=true, seekable=true, append=false, size=0, maxsize=Inf, ptr=1, mark=-1)

julia> write(buf,"foo")
3

julia> String(take!(buf))
"foo"
```

## 管道
`Pipe`函数可以创建一个未初始化的Pipe实例，当它用于进程生成时恰当的端将被自动初始化，从而很好地与`pipeline`联动\
`pipeline`可以用于生成`OrCmds`实例，它的一个原型是`pipeline(command; stdin, stdout, stderr, append=false)`，用于给指定命令重定向I/O，其中`append`参数指定是否对于文件使用补加而不是覆盖\
另一个原型是`pipeline(from, to, ...)`，用于创建从一个「数据来源」到「目的地」的管线，本质是`pipeline(from; stdout=to)`。参数可以是[命令](cmd.md)，IO实例或字符串（表示文件路径），且保证至少一个参数是命令\
多个参数会将`pipeline(a,b,c)`处理成`pipeline(pipeline(a,b),c)`

## 通用函数
| 名称 | 描述 |
| --- | --- |
| `read(io::IO, T)` | 从io中读取T类型的单个值，使用标准二进制表示，需手动使用`ntoh`，`ltoh`调整[大小端](https://zhuanlan.zhihu.com/p/144718837) |
| `read(io::IO, String)` | 将整个io作为字符串读入 |
| ` read(s::IO, nb=typemax(Int))` | 从s中读入最多nb个字符，返回`Vector{UInt8}`实例 |
| `read!(stream::IO, array::AbstractArray)` | 从io中读取二进制数据填充array |
| `write(io::IO, x)` | 将x的二进制表示写入io |
| `print([io::IO], xs...)` | 将x（们）的文字表示写入io |
| show | [自定义显示](typesystem.md#自定义显示) |
| flush | 提交所有缓存 |

## 标记
可以使用`mark`在当前位置作标记，使用`unmark`取消标记（若有），使用`ismarked`查看是否有标记，使用`reset`跳到上一个标记（无标记抛出错误）
