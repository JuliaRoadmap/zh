# 字符与字符串
字符与字符串分别是存储单个文字、一串文字的数据类型名称。

最常用的字符类型是`Char`（32位），可以存储一个 unicode 字符。声明字符字面量时，用一对单引号包含。
同时，有 8 位字符类型 `Cchar`、`Cuchar` 与 16 位字符类型 `Cwchar_t`，通常用于与 C 交互
```julia-repl
julia> c='猫'
'猫': Unicode U+732B (category Lo: Letter, other)

julia> Int(c)
29483
```

字符可以与整数相转化，请参考 ASCII 码表、扩展 ASCII 码表、Unicode 码表

## 字符串
`String` 是内置的字符串，使用 `utf-8` 格式编码，以 `Char` 的形式导出字符。

### 定义
字符串字面量通常使用一对双引号定义，也可以使用一对 `"""` 表示多行字符串
```julia-repl
julia> s="猫猫"
"猫猫"

julia> s="""
       ## 字符串
       可以使用双引号定义
       """
"## 字符串\n`可以使用双引号定义\n"
```

### 索引/切片访问
```julia-repl
julia> s="123456789"
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

Julia 中，你无法通过索引改变字符串内部数据，这与 Java 类似。如果你希望达成此操作，可以改用 `Vector{UInt8}`
```julia-repl
julia> v=Vector{UInt8}("cat")
3-element Vector{UInt8}:
 0x63
 0x61
 0x74

julia> write(stdout, v[1]);
c
```

!!! note
	对于非ASCII字符的下标访问与相关问题请参见[字符串编码](../advanced/string_code.md)

### 常用技巧
```julia-repl
julia> "" # 空字符串
""

julia> """""" # 也是空字符串，但不建议
""

julia> s*"abc" # 连接字符串
"123456789abc"

julia> s^2 # 将字符串重复n次
"123456789123456789"

julia> string(1) # 把其它类型转化成`String`
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
```check newbie
或许你会疑惑，假如要表示字符 `'` 之类的东西，应该怎么办？“转义”是几乎所有支持字符串的语言中支持的操作。
```

可以使用「`\`+若干指定字符」表示转义，包括
* `\\` => `\`
* `\"` => `"`
* `\'` => `'`
* 标准C escape序列 `\0\a\b\t\n\v\f\r\e`
* `\u`+1~4位16进制
* `\U`+1~8位16进制
* `\x`+1~2位16进制
* `\`+1~3位8进制

!!! note
	Julia 也提供了 `escape_string` 与 `unescape_string` 函数，可以帮助你在希望支持某些转义功能时进行处理
