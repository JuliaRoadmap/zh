# 字符串与基础 I/O
## 字符串基础
你将[在之后读到](string.md)关于字符串更详细的信息。

字符串可用于存储一串文字。

在一对 `""` 中放若干文字，它们可以构成字符串字面量：
```julia-repl
julia> "A quick brown fox jumps over the lazy dog."
"A quick brown fox jumps over the lazy dog."

julia> "喵(　o=^•ェ•)o"
"喵(　o=^•ェ•)o"
```

字符串与字符串中的内容通常是不相等的：
```julia-repl
julia> "0" == 0
false

julia> "sqrt(2)" == sqrt(2)
false

julia> "a" == a
ERROR: UndefVarError: `a` not defined in `Main`
```

## print
`print` 是最基本与常用的输出方式。在 REPL 中，输出结果会出现在代码后。
```julia-repl
julia> print(0)
0
julia> print(1, 2, 3) # 允许接受多个参数，它们的输出间没有空隙
123
julia> print("world.me.say_hello()") # 输出字符串
world.me.say_hello()
julia> print(1, " ", 2, " ", 3) # 手动填充空格
1 2 3
```

## println
`println` 除完成 `print` 的职责之外在末尾会多进行一次换行。

为了代码简洁和输出结果美观，有时会在输出时选择它而不是 `print`。两者配合也可以完成更好的输出效果。
```julia-repl
julia> print(0, "\n")
0

julia> println(0)
0

julia> println(1, 2, 3)
123

julia> println("╭╮"); println("╰╯")
╭╮
╰╯
```

## printstyled
`printstyled` 可以在环境允许的情况下输出有风格的文字。可配置的选项包括粗体、斜体、下划线、闪烁、前景背景反转、隐藏与色彩。
```julia-repl
julia> printstyled(1, 2, 3; color=:red)
123 # 如果系统支持，在 REPL 中显示红色
```

在控制台中，它基于的标准是广泛用于现代控制台的 `ansi-escape-code/sequence`，可参阅 [windows 的相关支持](https://docs.microsoft.com/zh-CN/windows/console/console-virtual-terminal-sequences)。

## 输入
既然有输出，就要有输入。Julia 中的 `readuntil` 与 `readline` 会读入字符串。

`readline` 会获取连续的字符，直到行尾。
```julia-repl
julia> a = readline();
read read read!

julia> a
"read read read!"
```

`readuntil` 会获取连续的字符，直到读到空格。
```julia-repl
julia> a = readuntil(stdin, ' ');
read buffered

julia> buffered
ERROR: UndefVarError: `buffered` not defined in `Main`
Suggestion: check for spelling errors or missing imports.

julia>

julia> a
"read"
```

上面的结果是在 REPL 中得到的。字符串 `buffered` 及回车没有被读取，因此仍在缓冲区中，自动变成了一行命令的输入。

两者也可以配合使用：
```julia-repl
julia> a = readuntil(stdin, ' '); b = readline()
first second
"second"

julia> a
"first"

julia> b
"second"
```

利用 `parse` 函数将字符串转为整数的功能，可以实现读入整数的效果。
```julia-repl
julia> a = parse(Int, readuntil(stdin, ' ')); b = parse(Int, readline());
2333 4

julia> a, b
(2333, 4)
```

## 练习
由于这可能是您第一次进行练习，注意参阅[练习平台说明与列表](../meta/resources.md#练习)。

- [Hydro H1000. A + B Problem](https://hydro.ac/p/H1000?lang=zh)
