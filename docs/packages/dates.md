# Dates的使用
## 日期
了解如何处理日期和时间戳在数据科学中很重要。Python 中的 `pandas` 使用它自己的 `datetime` 类型处理日期；R 语言中 TidyVerse 的 `lubridate` 包中也是如此，它也定义了自己的 `datetime` 类型来处理日期。

在 Julia 软件包中，不需要编写自己的日期逻辑，因为 Julia 标准库中有一个名为 `Dates` 的日期处理模块。

首先，记得加载 `Dates` 模块到工作空间中：
```jl
using Dates
```

## Date与DateTime类型
`Dates` 标准库模块有两种处理日期的类型：
- `Date`：表示以天为单位的时间和
- `DateTime`：表示以毫秒为单位的时间。

构造 `Date` 和 `DateTime` 的方法是向默认构造器传递整数：
```julia-repl
julia> Date(2022)
2022-01-01

julia> Date(2022,3,14)
2022-03-14

julia> DateTime(2022,3,14,15,9,26)
2022-03-14T15:09:26
```

也可以向默认构造器传递 `Period` 子类型的实例。对于计算机来说，`Period` 类型是时间的等价表示。[这是Period的类型层次关系](../lists/typetree1.6.txt#L465-L478)，它们的用法都是不言自明的
```julia-repl
julia> DateTime(Year(2022),Month(3),Day(14),Hour(15),Minute(9),Second(26))
2022-03-14T15:09:26
```

## 序列化
多数情况下，我们不会从零开始构造 `Date` 或 `DateTime` 示例，而更可能是将字符串序列化为 `Date` 或 `DateTime` 类型。`Date` 和 `DateTime` 构造器可以接收一个数字字符串和格式字符串：
```julia-repl
julia> Date("19010101","yyyymmdd")
1901-01-01

julia> DateTime("[ 1901-01-01 23:59:59 ]", "[ yyyy-mm-dd HH:MM:SS ]")
1901-01-01T23:59:59
```

当只需调用几次时，这种方法显然是方便的，但如果需要处理大量相同格式的日期字符串，那么更高效的方法是先创建 `DateFormat` 类型，然后传递该类型而不是原始的格式字符串。
然后，先前的例子改为：
```julia-repl
julia> format=DateFormat("yyyymmdd")
dateformat"yyyymmdd"

julia> Date("19010101",format)
1901-01-01

julia> format==dateformat"yyyymmdd"
true
```

## 提取日期信息
很容易从 `Date` 和 `DateTime` 对象中提取想要的信息：
首先，创建一个具体日期的实例：
```julia-repl
julia> tm=Date(1949,10,1)
1949-10-01

julia> year(tm), month(tm), day(tm)
(1949, 10, 1)

julia> yearmonth(tm)
(1949, 10)

julia> dayofweek(tm)
6

julia> dayname(tm)
"Saturday"

julia> dayofweekofmonth(tm) # 十月第一个周六
1
```

!!! note
	利用`filter`可以方便地进行「提取工作日」操作

## 日期操作
可以对 `Dates` 实例进行多种操作：
例如，可以对一个 `Date` 或 `DateTime` 实例增加或减少天数。
请注意，Julia 的 `Dates` 将自动地对闰年以及 30 天或 31 天的月份执行必要的调整（这称为「日历算术」）
```julia-repl
julia> tm+Day(40)
1949-11-10

julia> tm-Day(2)
1949-09-29
```

可以对两个日期/时间求差值：
```julia-repl
julia> to=today()
2022-06-16

julia> to-tm
26556 days

julia> n=now(); sleep(1); now()-n # 部分运算需要时间，不是恰好 1000 毫秒
1042 milliseconds
```

## 日期区间
`Dates` 模块的一个好处在于可以轻松地构造日期和时间区间，它通过多重派发将为 `range` 定义的函数和操作扩展到 `Date` 类型，因此可以轻松地通过冒号 `:` 运算符实现：
```julia-repl
julia> r=Date("2021-01-01"):Day(3):Date("2021-01-07") # 以三天为间隔
Date("2021-01-01"):Day(3):Date("2021-01-07")

julia> collect(r)
3-element Vector{Date}:
 2021-01-01
 2021-01-04
 2021-01-07
```

[^1]: https://github.com/JuliaCN/JuliaDataScience/blob/main/contents/julia_basics.md?plain=1#L1893-L2173
