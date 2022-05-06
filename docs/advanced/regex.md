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
