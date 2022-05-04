# 字符与字符串
最常用的字符类型是`Char`（32位），可以存储一个unicode字符，用单引号包含\
有8位字符类型`Cchar`、`Cuchar`，16位字符类型`Cwchar_t`
```jl
julia> c='猫'
'猫': Unicode U+732B (category Lo: Letter, other)

julia> c='猫猫' # 只允许单个字符
ERROR: syntax: character literal contains multiple characters
...

julia> Int(c)
29483
```

## 字符串
`String`是基于`Char`的字符串

### 定义
可以使用双引号定义\
也可以使用一对`"""`表示多行字符串
```jl
julia> s="猫猫"
"猫猫"

julia> s="""
       ## 字符串
       `String`是基于`Char`的字符串，可以使用双引号定义
       """
"## 字符串\n`String`是基于`Char`的字符串，可以使用双引号定义\n"
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

### 常用技巧
```jl
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
```

### 转义
