# 正则表达式
[泛使用](https://github.com/ziishaned/learn-regex/blob/master/translations/README-cn.md)

## regex
```jl
julia> r=r"a|b"
r"a|b"

julia> findall(r,"abc")
2-element Vector{UnitRange{Int64}}:
 1:1
 2:2
```

该文档中的「标志/模式修正符」对应正则表达式第二个参数
```jl
julia> r=Regex("a|b","i")
r"a|b"i

julia> findall(r,"AB")
2-element Vector{UnitRange{Int64}}:
 1:1
 2:2
```

## 运算
```jl
julia> r"a|b"==r"b|a" # 不会区分
false

julia> r"a"*r"b"
r"(?:a)(?:b)"

julia> r"a"*"b"
r"(?:a)\Qb\E"

julia> r"a"^2
r"(?:a){2}"
```
