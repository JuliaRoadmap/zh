# 基础I/O
## 字符串基础
[关于字符串的详细信息](string.md)。
此处你暂时只需要知道的是，你可以在一对 `""` 中放若干文字，它们可以构成字符串：
```julia-repl
julia> "A quick brown fox jumps over the lazy dog."
"A quick brown fox jumps over the lazy dog."

julia> "喵(　o=^•ェ•)o"
"喵(　o=^•ェ•)o"
```

字符串与字符串中的内容通常不是同一个东西：
```julia-repl
julia> "0"==0
false

julia> A quick brown fox jumps over the lazy dog.
ERROR: syntax: extra token "quick" after end of expression
```

## print
`print` 是基本的输出方式
```julia-repl
julia> print(0)
0
julia> print(1, 2, 3) # 允许接受多个参数
123
julia> print("world.me.say_hello()") # （这个字符串内容看上去像代码
world.me.say_hello()
julia>
```

## println
`println` 与 `print` 相似，不同的是在末尾会多进行一次换行。
为了美观，许多人会在输出时选择它而不是 `print`。两者配合也可以完成更好的输出效果。
```julia-repl
julia> println(0)
0

julia> println(1,2,3)
123

julia>
```

## printstyled
`printstyled` 可以在环境允许的情况下输出有风格的文字（当前功能包括彩色与粗体）
```julia-repl
julia> printstyled(1, 2, 3; color=:red)
123 # 你看，这里不允许这个功能，使用它输出没有特殊效果（
```

它基于的标准是广泛用于现代控制台的 `ansi-escape-code/sequence`（可追溯至 `VT100`），可参阅 [windows 的相关支持](https://docs.microsoft.com/zh-CN/windows/console/console-virtual-terminal-sequences)。

## 输入
为方便进行之后的练习，现提供以下代码
```julia-repl
julia> a=readuntil(stdin,' '); b=readline() # 前者读到空格为止，后者读到行尾
first second
"second"

julia> a
"first"

julia> b
"second"
```

利用 `parse` 函数将字符串转为整数的功能，你可以读入整数
```julia-repl
julia> a=parse(Int,readuntil(stdin,' ')); b=parse(Int,readline());
2333 4

julia> a, b
(2333, 4)
```

## 练习
由于这可能是您第一次进行练习，注意参阅[练习平台说明与列表](../meta/how_to_learn.md#练习)。

- [Hydro H1000. A + B Problem](https://hydro.ac/p/H1000?lang=zh)
