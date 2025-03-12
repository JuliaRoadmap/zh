# 正则表达式
**正则表达式（regex，regular expression）**是一种按顺序匹配字符串的模式。例如，使用 `^julia>.*$` 匹配本页面中所有以 `julia>` 左起的行。

在[这里](https://github.com/ziishaned/learn-regex/blob/master/translations/README-cn.md)阅读中文版的“Learn Regex the Easy Way”。

## regex
```julia-repl
julia> r = r"a|b"
r"a|b"

julia> findall(r, "abc")
2-element Vector{UnitRange{Int64}}:
 1:1
 2:2
```

先前文档中提及的「标志/模式修正符」对应正则表达式构建时的第二个参数
```julia-repl
julia> r = Regex("a|b", "i")
r"a|b"i

julia> findall(r, "AB")
2-element Vector{UnitRange{Int64}}:
 1:1
 2:2
```

## 运算
```julia-repl
julia> r"a|b" == r"b|a" # 逻辑上相同，但不会区分
false

julia> r"a" * r"b"
r"(?:a)(?:b)"

julia> r"a" * "b"
r"(?:a)\Qb\E"

julia> r"a" ^ 2
r"(?:a){2}"
```
