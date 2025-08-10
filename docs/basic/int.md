# 整数
**整数**是用于运算的最基本的数据类型之一。整数被广泛使用，例如它可以用于：
* 纯粹的整数运算
* 控制循环次数
* 控制索引位置

## 整数类型
Julia 中的整数类型包含了所有常见的[位数](../knowledge/bits.md#位)。以下是常见的整数类型。
| 类型 | 带符号 | 位数 |
| :-: | :-: | :-: |
| `Int8` | Y | 8 |
| `UInt8` | N | 8 |
| `Int16` | Y | 16 |
| `UInt16` | N | 16 |
| `Int32` | Y | 32 |
| `UInt32` | N | 32 |
| `Int64` | Y | 64 |
| `UInt64` | N | 64 |
| `Int128` | Y | 128 |
| `UInt128` | N | 128 |

整数类型的命名是有规律的。
* `int` 是 `integer` 的缩写。
* `u` 是**无符号**（unsigned）的缩写。`U` 开头的表示无符号类型，即该类型的值保持在**非负**整数。
* 末尾的数字表示类型的位数。

Julia 提供了一些辅助函数来检查整数类型的相关属性。
```julia-repl
julia> typeof(1) # typeof 可以查看一个值的类型；如果显示的是 Int32，你可能在使用古老的 32 位机器
Int64

julia> typemin(Int64) # 查看一个类型的最小值
-9223372036854775808

julia> typemax(Int64) # 查看一个类型的最大值
9223372036854775807
```

## 整数字面表示
有符号整数以标准形式表示；若能用 32 位表示则会依据系统位数，否则使用 64 位。特别地，当输入的数足够大时，会使用[高精度整数](#高精度整数)类型。
```julia-repl
julia> typeof(1234)
Int64
```

无符号整数以十六进制、二进制或八进制表示（后 2 个基本没人用），会根据数据大小自动改变类型位数
```julia-repl
julia> typeof(0xbeef)
UInt16

julia> typeof(0xBeef) # 允许大小写混用
UInt16

julia> typeof(0x0)
UInt8
```

如果你没有得到你期望的结果，可以强制类型转化
```julia-repl
julia> x=UInt8(100)
0x64

julia> typeof(x)
UInt8
```

如果你有在数字间加 `,` 的习惯，可以改用 `_`

## 其它预定义类型
预定义了 `Int` 与 `UInt` 类型，位数对应系统位数（通常是 64）

!!! note
	如果你熟悉 C 语言，那么 Julia 提供了以 C 中 `int` 等类型命名的类型，它们是以上整数类型的别名。
	`Cint`，`Cintmax_t`，`Clong`，`Clonglong`，`Cshort`，`Csize_t`，`Cssize_t`，`Cptrdiff_t`，
	`Cuint`，`Cuintmax_t`，`Culong`，`Culonglong`，`Cushort`。

## 高精度整数
高精度整数的类型名为 `BigInt`，它们可以使用 `big(值)` 定义。这可以表示相当大的整数。
```julia-repl
julia> big(2)^100
1267650600228229401496703205376
```

## 数学运算
| 表达式 | 名称 | 注 |
| :-: | :-: | :-: |
| `+x` | 一元加法运算符 | 主要用于标注 |
| `-x` | 一元减法运算符 | 将值变为其相反数 |
| `x + y` | 加法 |  |
| `x - y` | 减法 |  |
| `x * y` | 乘法 |  |
| `x ÷ y` | 除法（取商） | 使用 `\div` 打出 |
| `x ^ y` | 幂 | x 的 y 次幂 |
| `x % y` | 取余 | 等价于 `rem(x, y)`，会保留 x 的正负号 |
| `mod(x, y)` | 取模 | 得到非负数 |

数学运算的混合使用与通用数学规则相同
```julia-repl
julia> 1 + 2 + 3
6

julia> 1 - 2
-1

julia> 3 * 2 / 12
0.5

julia> x = 2 ^ 3
8

julia> 2(x-1)
14
```

在样例 `2(x-1)` 中，`*` 号被省略了，这是 Julia 用以更符合数学书写习惯的设计 [^3]

可以在**二元**运算符后加 `=`，变成复合赋值操作符，会对前者进行改变
```julia-repl
julia> a = 1
1

julia> b = 2
2

julia> a + b
3

julia> a, b
(1, 2)

julia> a += b
3

julia> a, b
(3, 2)
```

你可能会发现，一些变量在操作后类型发生了改变
```julia-repl
julia> v = Int16(0)
0

julia> v += 1
1

julia> typeof(v)
Int64
```

这是因为 Julia 会进行[类型转换和类型提升](../advanced/conpro.md)

## 位运算
[什么是位运算](../knowledge/bits.md#位运算)

| 表达式 | 名称 | 注 |
| --- | --- | --- |
| `~x` | 按位取反 |  |
| `x & y` | 按位与 |  |
| `x | y` | 按位或 |  |
| `x ⊻ y` | 按位异或 | 也可以使用 `xor(x,y)` |
| `x ⊼ y` | 按位非与 |
| `x ⊽ y` | 按位非或 |
| `x >>> y` | 逻辑右移 |  |
| `x >> y` | 算术右移 |  |
| `x << y` | 逻辑/算术左移 |  |

!!! compat "Julia 1.7"
	`nand` 和 `nor` 的支持至少需要 Julia 1.7

## 比较
| 操作符 | 名称 |
| --- | --- |
| `==` | 相等 |
| `!=`, `≠` | 不等 |
| `<` | 小于 |
| `<=`, `≤` | 小于等于 |
| `>` | 大于 |
| `>=`, `≥` | 大于等于 |

```julia-repl
julia> 1<2
true
```

得到的结果是[**布尔**](bool.md)类型的 `true` 和 `false` 之一。

Julia 允许链式比较：
```julia-repl
julia> 1 < 2 <= 2 < 3 == 3 > 2 >= 1 == 1 < 3 != 5
true

julia> left <= x <= right # 你通常会这样用它
```

## 练习
- 试计算 $5^{40}$

[^1]: 更多内容参见 <https://docs.juliacn.com/latest/manual/mathematical-operations/>
[^3]: 但是不会存在诸如把 `xy` 解析成 `x * y` 的情况
