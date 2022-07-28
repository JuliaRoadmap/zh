# 浮点数
浮点数是IEEE 754规定的，广泛用于数学运算的数据类型，用来表示实数\
以下是 Julia 预定义的浮点数类型

## 浮点数类型
| 类型 | 精度 | bit数 |
| --- | --- | --- |
| Float16 | half | 16 |
| Float32 | single | 32 |
| Float64 | double | 64 |

* 如你所见，没有非负实数类型

## 浮点数字面表示
* 使用标准格式表示，例如`1.234`，`1.3e8`（科学记数法），`.234`（省略0）
* 存在麻烦的16进制表示方式
* 也可以用`_`间隔

!!! note
	[一个查看浮点数相关结构信息的工具](https://float.exposed/)

## 特殊浮点数
根据IEEE 754的规定，存在2类特殊浮点数：\
`无穷(Inf)`：包括正无穷`Inf`和负无穷`-Inf`。它在部分运算中有奇怪的表现
```jl
julia> 1/0
Inf

julia> Inf*2
Inf

julia> Inf*Inf
Inf
```

`NaN(Not any Number)`：运算中若有NaN则结果往往也是NaN
```jl
julia> Inf*0
NaN

julia> Inf-Inf
NaN
```

同时需注意的是，`-0.0`与`0.0`是不同的
```jl
julia> -0.0
-0.0

julia> 0.0
0.0
```

## 高精度浮点数
高精度浮点数的类型名为 `BigFloat`，也可以使用 `big(值)` 定义
```jl
julia> v=BigFloat(3.14;precision=64)
3.14000000000000012434

julia> sin(v)
0.001592652916486828195720381619065341837458058698482280006965969939337509115206538
```

## 其它预定义类型
!!! note
	如果你熟悉C语言，那么 Julia 提供了\
	`Cdouble`和`Cfloat`，对应C中的`double`和`float`

## 数学运算
基本运算与[上一章中的](int.md#数学运算)相同\
没错，浮点数也支持取商、取余，只不过返回的是浮点数
```jl
julia> div(1.0,9.0)
0.0

julia> 1.0%9.0
1.0
```

若要使用正常除法，请使用`/`
```jl
julia> 1.0/9.0
0.1111111111111111
```

## 比较
* 有限数的大小顺序，和我们所熟知的相同
* `+0 == -0`
* `Inf` 等于自身，并且大于除了 NaN 外的所有数
* `-Inf` 等于自身，并且小于除了 NaN 外的所有数
* `NaN` 不等于、不小于且不大于任何数值，包括它自己

为了防止你搞晕，Julia 提供了
| 函数 | 测试是否满足 |
| --- | --- |
| isequal(x, y)	| x 与 y 是完全相同的 |
| isfinite(x) | x 是有限大的数字 |
| isinf(x) | x 是无穷 |
| isnan(x) | x 是 NaN |

当然，你也可以使用`内建(built-in)`的`===`，只有2个值完全无法分辨时才为true

## 数值转换
Julia 支持三种数值转换，它们在处理不精确转换上有所不同
1. `T(x)` 和 `convert(T,x)` 都会把 x 转换为 T类型
	* 如果 T 是浮点类型，转换的结果就是最近的可表示值， 可能会是正负无穷
	* 如果 T 为整数类型，当 x 不能由 T 类型表示时，会抛出 `InexactError`
2. `x % T` 将整数 x 转换为整型 T，与 x 模 `2^n` 的结果一致，其中 n 是 T 的位数。换句话说，在二进制表示下被截掉了一部分
3. [舍入函数](#舍入函数)接收一个 T 类型的可选参数

## 初等函数
### 舍入函数
| 函数 | 舍入方向 |
| --- | --- |
| round(x) | 最接近的整数 |
| floor(x) | 负无穷 |
| ceil(x) | 正无穷 |
| trunc(x) | 0 |

对于以上函数，可以在`x`前添加一个参数`T`表示目标类型

### 除法函数
| 函数 | 描述 |
| --- | --- |
| div(x,y), x÷y | 截断除法；商向0近似 |
| fld(x,y) | 向下取整除法；商向负无穷近似 |
| cld(x,y) | 向上取整除法；商向正无穷近似 |
| rem(x,y) | 取余；满足 x=`div(x,y)*y + rem(x,y)`；符号与 x 一致 |
| mod(x,y) | 取模；满足 x=`fld(x,y)*y + mod(x,y)`；符号与 y 一致 |
| mod1(x,y) | 偏移 1 的 mod；若 `y>0`，则返回 `r∈(0,y]`，若 `y<0`，则 `r∈[y,0)` 且满足 `mod(r, y)`=`mod(x, y)` |
| mod2pi(x) | 对 `2pi` 取模 |
| divrem(x,y) | 返回 `(div(x,y),rem(x,y))` |
| fldmod(x,y) | 返回 `(fld(x,y),mod(x,y))` |

```jl
julia> divrem(13,3)
(4, 1)
```

### 符号和绝对值函数
| 函数 | 描述 |
| --- | --- |
| abs(x) | x 的模 |
| abs2(x) | x 的模的平方 |
| sign(x) | 表示 x 的符号，返回 -1，0，或 +1 |
| signbit(x) | x 为负时返回`true`，否则返回`false` |
| copysign(x,y) | 返回一个数，其值等于 x 的模，符号与 y 一致 |
| flipsign(x,y) | 返回一个数，其值等于 x 的模，符号与 x*y 一致 |

### 幂指对
| 函数 | 描述 |
| --- | --- |
| sqrt(x), √x | x 的平方根 |
| cbrt(x), ∛x | x 的立方根 |
| hypot(x,y) | 当直角边的长度为 x 和 y时，直角三角形斜边的长度 |
| exp(x) | 自然指数函数在 x 处的值 |
| expm1(x) | 当 x 接近 0 时的 `exp(x)-1` 的精确值 |
| ldexp(x,n) | `x*2^n` 的高效算法，n 为整数 |
| log(x) | x 的自然对数 |
| log(b,x) | 以 b 为底 x 的对数 |
| log2(x) | 以 2 为底 x 的对数 |
| log10(x) | 以 10 为底 x 的对数 |
| log1p(x) | 当 x接近 0 时的 `log(1+x)` 的精确值 |
| exponent(x) | x 的二进制指数 |
| significand(x) | 浮点数 x 的二进制有效数（也就是尾数） |

[为何要有一些看似没用的函数](https://www.johndcook.com/blog/2010/06/07/math-library-functions-that-seem-unnecessary/)

### 三角和双曲函数
```plain
sin    cos    tan    cot    sec    csc
sinh   cosh   tanh   coth   sech   csch
asin   acos   atan   acot   asec   acsc
asinh  acosh  atanh  acoth  asech  acsch
sinc   cosc
```

所有这些函数都是单参数函数，不过 `atan` 也可以接收两个参数 来表示传统的 `atan2` 函数（即`atan(y,x)`=`arctan(y/x)`）\
`sinpi(x)` 和 `cospi(x`) 分别用来对 `sin(pi*x)` 和 `cos(pi*x)` 进行更精确的计算\
要计算角度而非弧度的三角函数，以 d 做后缀。 比如，`sind(x)` 计算 x 的 sine 值，其中 x 是一个角度值。列表：
```plain
sind   cosd   tand   cotd   secd   cscd
asind  acosd  atand  acotd  asecd  acscd
```

### 杂项
| 函数 | 描述 |
| --- | --- |
| `sum(x,y...)` | 和 |
| `max(x,y...)` | 最大值 |
| `min(x,y...)` | 最小值 |
| `gcd(x,y...)` | 最大公约数，只接受整数 |
| `lcm(x,y...)` | 最小公倍数，只接受整数 |

### 特殊函数
[特殊数学函数 - SpecialFunctions](../packages/specialfunctions.md)

## 扩展阅读
- [背景资料与参考文献](https://docs.juliacn.com/latest/manual/integers-and-floating-point-numbers/#%E8%83%8C%E6%99%AF%E7%9F%A5%E8%AF%86%E4%B8%8E%E5%8F%82%E8%80%83%E6%96%87%E7%8C%AE)
- [运算符的优先级与结合性](https://docs.juliacn.com/latest/manual/mathematical-operations/#运算符的优先级与结合性)
- [复数和有理数](https://docs.juliacn.com/latest/manual/complex-and-rational-numbers/)

[^1]: https://docs.juliacn.com/latest/manual/mathematical-operations/
