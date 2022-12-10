# 子字符串
[子字符串与String都是AbstractString的子类型](../lists/typetree1.6.txt#L94-L96)，这意味着它们的许多函数都可以通用

```julia-repl
julia> sub=SubString("Cats!",2,4)
"ats"

julia> sub[1]
'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)

julia> SubString(sub,1,2)
"at"
```
