# 字符与字符串
最常用的字符类型是`Char`（32位），可以存储一个unicode字符，用单引号包含\
有8位字符类型`Cchar`、`Cuchar`，16位字符类型`Cwchar_t`
```jl
julia> c='猫'
'猫': Unicode U+732B (category Lo: Letter, other)

julia> Int(c)
29483
```

## 字符串
`String`是最常用的字符串，通常与`Char`交互

### 定义
可以使用双引号定义\
也可以使用一对`"""`表示多行字符串
```jl
julia> s="猫猫"
"猫猫"

julia> s="""
       ## 字符串
       可以使用双引号定义
       """
"## 字符串\n`可以使用双引号定义\n"
```

### 索引/切片访问
```jl
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

!!! note
	对于非ASCII字符的下标访问与相关问题请参见[字符串编码](../advanced/string_code.md)

### 常用技巧
```jl
julia> "" # 空字符串
""

julia> """""" # 不建议的行为
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
可以使用`\`+若干指定字符表示转义，包括
* `\\` => `\`
* `\"` => `"`
* `\'` => `'`
* 标准C escape序列 `\0\a\b\t\n\v\f\r\e`
* `\u`+1~4位16进制
* `\U`+1~8位16进制
* `\x`+1~2位16进制
* `\`+1~3位8进制

!!! note
	Julia 也提供了 `escape_string` 与 `unescape_string` 函数，可以帮助你的程序支持含转义的输入
