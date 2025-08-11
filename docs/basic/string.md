# 字符与字符串
字符与字符串分别是存储单个文字、一串文字的数据类型名称。

最常用的字符类型是 `Char`（32位），可以存储一个 Unicode 字符。声明字符字面量时，用一对单引号包含。

同时，有 8 位字符类型 `Cchar`、`Cuchar` 与 16 位字符类型 `Cwchar_t`，通常用于与 C 语言交互。
```julia-repl
julia> c = '猫'
'猫': Unicode U+732B (category Lo: Letter, other)

julia> Int(c)
29483
```

字符可以与整数相转化。这本质上是因为字符并没有什么特殊的，字符有其统一的编号（请参考 ASCII 码表、扩展 ASCII 码表及 Unicode 码表），而后终端通过安装的字体合理地显示字符。

字符类型不会被自动提升为整数类型：
```julia-repl
julia> c = 'A'
'A': ASCII/Unicode U+0041 (category Lu: Letter, uppercase)

julia> c += 1
'B': ASCII/Unicode U+0042 (category Lu: Letter, uppercase)

julia> typeof(c)
Char
```

## 字符串
`String` 是 Julia 内置的字符串，可以以 `Char` 的形式导出字符。

### 字面量
字符串字面量通常使用一对双引号 `"` 定义，也可以使用一对 `"""` 表示多行字符串
```julia-repl
julia> s = "猫猫"
"猫猫"

julia> s = """
       ## 字符串
       ……
       """
"## 字符串\n……\n"
```

### 索引/切片访问
```julia-repl
julia> s = "123456789"
"123456789"

julia> s[1]
'1': ASCII/Unicode U+0031 (category Nd: Number, decimal digit)

julia> s[1:2]
"12"

julia> s[7:end]
"789"

julia> length(s) # 获取长度
9
```

Julia 中，你无法通过索引改变字符串内部数据，这与 Java 类似。
如果你希望进行改变字符串的操作，可以改用 `Vector{UInt8}` 表示字符串。
```julia-repl
julia> v = Vector{UInt8}("cat")
3-element Vector{UInt8}:
 0x63
 0x61
 0x74

julia> v[1] = 0x65
0x65

julia> String(v)
"eat"
```

你将在[字符串编码](../advanced/string_code.md)一节读到有关非 ASCII 字符的下标访问与相关问题。

### 常用技巧
```julia-repl
julia> "" # 空字符串
""

julia> """""" # 也是空字符串，但不建议
""

julia> s*"abc" # 连接字符串
"123456789abc"

julia> s^2 # 将字符串内容重复两次
"123456789123456789"

julia> string(1) # 把其它类型的东西转化成字符串
"1"

julia> x=8
8

julia> "$x" # 插入值
"8"

julia> "$(x*2)" # 插入表达式
"16"

julia> raw"\\"
"\\"
```

### 转义
或许你会疑惑，假如要表示字符 `'` 之类的东西，应该怎么办？

“转义”是几乎所有支持字符串的语言中支持的特性。

在 Julia 可以使用 `\` + 若干特定字符完成，具体项目包括：
* `\\` => `\`
* `\"` => `"`
* `\'` => `'`
* 标准 C-escape 序列
	* `\0` NUL
	* `\a`
	* `\b`
	* `\t`
	* `\n` 换行
	* `\v`
	* `\f`
	* `\r`
	* `\e`
* `\u` + 1~4 位 16 进制数
* `\U` + 1~8 位 16 进制数
* `\x` + 1~2 位 16 进制数
* `\` + 1~3 位 8 进制数

后面 4 个对应的数字参考 Unicode 码表得到对应字符。

!!! note
	Julia 也提供了 `escape_string` 与 `unescape_string` 函数，可以帮助你在希望支持某些转义功能时进行处理

## 练习
- 试表示含有单个反斜杠的字符串。
- 凯撒加密的方法是：将 a~z 放在一个圆盘上，然后指定一个数字 n，将待加密字符串每个字符在圆盘上顺时针转 n 格。请使用 Julia 编写程序，解密 `htwwjhy` 到一个简单单词。
- （困难）了解什么是 Quine，并设计一个使用 Julia 的 Quine，参考答案[见此](https://github.com/JuliaAttic/Examples/blob/master/quine.jl)。
