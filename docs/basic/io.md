# I/O
## 预定义值
`stdin`标准输入，通常指控制台输入\
`stdout`标准输出，通常指控制台输出\
`stderr`错误输出，通常指控制台输出，常用于错误输出

## 文本相关函数
`print`与`println`已在[print章节](print.md)提到
```jl
julia> s=readline()
喵
"喵"

julia> s=readuntil(stdin,'.')
A red fox. Fox!
"A red fox"

julia> c=read(stdin,Char)
读入
'读': Unicode U+8BFB (category Lo: Letter, other)
```

## 生成文件I/O
文字写示例
```jl
julia> name=readline() # 多个I/O可以同时用
Rratic
"Rratic"

julia> io=open("D:/test.txt","w") # 以写形式打开 D:/test.txt
IOStream(<file D:/test.txt>)

julia> isopen(io) # 判断是否成功打开
true

julia> print(io,"$(name)的文档") # 写入文字

julia> close(io) # 记得关闭
```

## 包裹
可以使用`IOBuffer(s)`将字符串包裹成IO形式
