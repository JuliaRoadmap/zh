# I/O
## 预定义值
- `stdin` 是标准输入，通常指控制台输入
- `stdout` 是标准输出，通常指控制台输出
- `stderr` 是错误输出，通常指控制台输出，常用于错误输出

## 文本相关函数
`print` 与 `println` 已在[基础 I/O](basicio.md) 提到
```julia-repl
julia> s=readline() # 默认从 stdin 读入
喵
"喵"

julia> s=readuntil(stdin, '.') # 这个函数没有定义默认值 stdin
A red fox. Fox!
"A red fox"

julia> c=read(stdin, Char) # 多余的字符会被忽略（保留在控制台的缓冲区）
读入
'读': Unicode U+8BFB (category Lo: Letter, other)
```

## 生成文件 I/O
文字写示例
```julia-repl
julia> name=readline() # 多个 I/O 可以同时存在
Rratic
"Rratic"

julia> io=open("D:/test.txt","w") # 以写形式打开 D:/test.txt
IOStream(<file D:/test.txt>)

julia> isopen(io) # 查看是否成功打开
true

julia> print(io, "$(name)的文档") # 写入文字数据

julia> close(io) # 记得关闭
```

更方便地，可以使用 `read(文件名)` 直接读入数据（返回 `UInt8` 数组，文本需调用 `String` 转化）。
可以使用 `write(文件名, 数据)` 直接写入数据。

通常来说，如果一个文件 I/O 流没有被关闭，那么操作系统不会允许其它程序对该文件进行「写」操作，并且部分数据可能丢失。
因此，许多函数内部会利用 [`try-finally`](error.md#finally) 结构保证调用 `close`
```jl
io = open(x, "w")
try
	f(io)
finally
	close(io)
end
```

## 包裹
可以使用 `IOBuffer(s)` 将字符串包裹成IO形式
```julia-repl
julia> io=IOBuffer("buf")
IOBuffer(data=UInt8[...], readable=true, writable=false, seekable=true, append=false, size=3, maxsize=Inf, ptr=1, mark=-1)

julia> String(take!(io))
"buf"
```

## 参阅
- [I/O 进阶内容](../advanced/io.md)
- [windows 新终端源码](https://github.com/microsoft/terminal)
