# 子字符串
## 类型
子字符串类型名为 `SubString`。与直接截取并创建新的 `String` 不同，`SubString` **不复制数据**，而是在内部持有对原始字符串的引用，并记录起止字节偏移量。这样，对长字符串进行大量截取时可以显著减少内存分配。

需要注意的是，只要 `SubString` 对象存在，它所引用的原始字符串就不会被垃圾回收，即便该字符串在其他地方已经不再被使用。

`SubString` 和 `String` 都是 `AbstractString` 的子类型，这意味着 `length`、`uppercase`、正则匹配等绝大多数字符串函数均可通用，无需手动转换。如果确实需要一个独立的 `String`，可以调用 `String(sub)` 进行转换。

## 使用
```julia-repl
julia> sub = SubString("Cats!", 2, 4)
"ats"

julia> sub[1]
'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)

julia> SubString(sub, 1, 2)
"at"
```
