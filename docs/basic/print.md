# 基本输出
## 字符串基础
[关于字符串的详细信息](string.md)\
此处你需要知道的是，你可以在一对`""`放若干字符，它们可以构成字符串
```jl
julia> "A quick brown fox jumps over the lazy dog."
"A quick brown fox jumps over the lazy dog."

julia> "喵(　o=^•ェ•)o"
"喵(　o=^•ェ•)o"
```

## print
`print`是基本的输出方式
```jl
julia> print(0)
0
julia> print(1,2,3) # 接受多个参数
123
julia> print("world.me.say_hello()")
world.me.say_hello()
julia>
```

## println
`println`与`print`相似，不同的是在末尾会多进行一次换行
```jl
julia> println(0)
0

julia> println(1,2,3)
123

julia>
```

## printstyled
`printstyled`允许你在控制台允许的情况下输出有风格的文字（例如彩色）
```jl
julia> printstyled(1,2,3;color=:red)
123 # 你看，这里不允许，使用输出没有特殊效果（
```

[windows的相关支持](https://docs.microsoft.com/zh-CN/windows/console/console-virtual-terminal-sequences)
