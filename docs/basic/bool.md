# 布尔
## 布尔逻辑
[在此阅读](../knowledge/bool_logic.md)关于布尔逻辑的详细内容。

`Bool` 是 Julia 中的布尔类型名，其值只能为 `true` 与 `false` 之一。

## 运算
| 表达式 | 名称 |
| --- | --- |
| `!x` | 否定 |
| `x && y` | 短路与 |
| `x || y` | 短路或 |
| `x ⊻ y` | 异或 |
| `x ⊼ y` | 非与 |
| `x ⊽ y` | 非或 |

```julia-repl
julia> !true
false

julia> true && "foo"
"foo"

julia> false || "foo"
"foo"

julia> true || "foo"
true
```

后三者的使用与[整数的位运算](int.md#位运算)情况类似。

布尔在 Julia 中其实是整数的一类，其中 `false` 可以被提升为 0，而 `true` 可以被提升为 1。
```julia-repl
julia> Bool <: Integer
true

julia> Int(false)
0

julia> UInt8(false)
0x00

julia> Int(true)
1
```

特别地，`false` 可以用于移除 `NaN` 状态：
```julia-repl
julia> NaN * 0
NaN

julia> NaN * false
0.0
```

## 短路
短路是一个重要的特性，它是说：如果一个布尔逻辑表达式的第一个参数已经确定了整个表达式的值，则第二个参数根本不会被计算。

```julia-repl
julia> a = 0
0

julia> false && begin a=1; a==2 end
false

julia> a
0

julia> true || begin a=1; a==2 end
true

julia> a
0
```

上例中 `begin a=1; a==2 end` 没有被计算，因此没有进行 `a = 1` 的赋值操作。

## 缺失
**缺失**类型 `Missing` 具有唯一的实例 `missing`。它表示其字面意思，即“值缺失”。[^1]这一语义在数据科学中常被用到。

对于大部分数学函数，`missing` 会传递：
```julia-repl
julia> missing == missing
missing

julia> missing + 8
missing
```

`missing` 有三种判断方式：
```julia-repl
julia> ismissing(missing)
true

julia> isequal(missing, missing)
true

julia> missing === missing
true
```

特别地，对于 `isless`，`missing` 被认为比任何其它值大。

## 三值逻辑
三值逻辑是由 `true`，`false` 和 `missing` 共同组成的。这里 `missing` 可以视作“未知是 true 还是 false”

对于短路运算符 `||` 与 `&&`，禁止将 `missing` 放在左侧，并满足短路规则。

```julia-repl
julia> true || missing # 短路原则
true

julia> false || missing
missing
```

对其它逻辑运算，允许将 `missing` 放在左侧，并将它视作未知。
```julia-repl
julia> missing ⊻ true
missing

julia> missing ⊻ missing
missing

julia> missing ⊼ true
missing

julia> missing ⊼ false
true
```

[^1]: 这与一些语言的 `null` 相似，但不完全相同
