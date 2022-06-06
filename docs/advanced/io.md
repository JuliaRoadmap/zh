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

## 管道
`Pipe`函数可以创建一个未初始化的Pipe实例
