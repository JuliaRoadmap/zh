# 布尔
对于`Bool`的相关知识参见[布尔逻辑](bool_logic.md)

## 运算
| 表达式 | 名称 |
| !x | 否定 |
| x && y | 短路与 |
| x &#124;&#124; y | 短路或 |

```jl
julia> !true
false

julia> true && "foo"
"foo"

julia> false && "foo" # 短路意味着前一个表达式为否时，不会关心后一个表达式
false

julia> false || "foo"
"foo"

julia> true || "foo"
true
```

布尔在julia中其实是整数的一类（`Bool <: Integer`），即`false`可以被提升为0，而`true`可以被提升为1\
特别地，`false`可以用于
```jl
julia> NaN*0
NaN

julia> NaN*false
0.0
```

## 缺失
`缺失(Missing)`，具有唯一值`missing`，与一些语言的`null`相似，但不完全相似\
对于大部分操作，`missing`会传递
```jl
julia> missing==missing
missing

julia> missing+8
missing

julia> ismissing(missing) # 3种判断方式
true

julia> isequal(missing,missing)
true

julia> missing===missing
true
```

特别地，对于`isless`，`missing`被认为比任何其它值大

## 三值逻辑
三值逻辑是由`true`，`false`和`missing`共同组成的\
对于所有的短路运算，仍保持短路规则\
若有参数为`missing`，则返回`missing`
```jl
julia> true || missing # 短路原则
true

julia> false || missing # 缺失原则
missing
```
