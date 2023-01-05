# 正则表达式
[什么是正则表达式](https://github.com/ziishaned/learn-regex/blob/master/translations/README-cn.md)

## regex
```julia-repl
julia> r=r"a|b"
r"a|b"

julia> findall(r, "abc")
2-element Vector{UnitRange{Int64}}:
 1:1
 2:2
```

先前链接指向的文档中的「标志/模式修正符」对应正则表达式第二个参数
```julia-repl
julia> r=Regex("a|b", "i")
r"a|b"i

julia> findall(r, "AB")
2-element Vector{UnitRange{Int64}}:
 1:1
 2:2
```

## 运算
```julia-repl
julia> r"a|b"==r"b|a" # 逻辑上相同，但不会区分
false

julia> r"a"*r"b"
r"(?:a)(?:b)"

julia> r"a"*"b"
r"(?:a)\Qb\E"

julia> r"a"^2
r"(?:a){2}"
```
