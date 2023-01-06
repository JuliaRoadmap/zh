# 布尔
## 布尔代数
通常来说，布尔代数指布尔逻辑，可参照[此处的介绍](../knowledge/bool_logic.md)。

`Bool` 是 Julia 中的布尔类型名，其值只能为 `true`、`false` 之一。

## 运算
| 表达式 | 名称 |
| --- | --- |
| `!x` | 否定 |
| `x && y` | 短路与 |
| `x || y` | 短路或 |

```julia-repl
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

布尔在 Julia 中其实是整数的一类（`Bool <: Integer`），即 `false` 可以被提升为 0，而 `true` 可以被提升为 1。

特别地，`false` 可以用于如下功能：
```julia-repl
julia> NaN*0
NaN

julia> NaN*false
0.0
```

## 缺失
「缺失(Missing)」，具有唯一实例 `missing`。它用于表示字面意思，即“值缺失”。[^1]

“值缺失”这一语义在数据科学中常被用到。
对于大部分数学函数，`missing` 会传递：
```julia-repl
julia> missing==missing
missing

julia> missing+8
missing
```

`missing` 有三种判断方式：
```julia-repl
julia> ismissing(missing)
true

julia> isequal(missing, missing)
true

julia> missing===missing
true
```

特别地，对于 `isless`，`missing` 被认为比任何其它值大

## 三值逻辑
三值逻辑是由 `true`，`false` 和 `missing` 共同组成的，对于二元运算，有：
- 对于所有的短路运算，仍保持短路规则
- 若有参数为 `missing`，则返回 `missing`

```julia-repl
julia> true || missing # 短路原则
true

julia> false || missing # 缺失原则
missing
```

[^1]: 这与一些语言的 `null` 相似，但不完全相同
