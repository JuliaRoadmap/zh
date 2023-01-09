# 子字符串
## 类型
子字符串类型名为 `SubString`。`SubString` 和 `String` 都是 `AbstractString` 的子类型（参考[此表](../lists/typetree1.8.txt#L98-L104)），这意味着许多函数都可以通用。

## 使用
```julia-repl
julia> sub = SubString("Cats!", 2, 4)
"ats"

julia> sub[1]
'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)

julia> SubString(sub, 1, 2)
"at"
```
