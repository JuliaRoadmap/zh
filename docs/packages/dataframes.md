# DataFrames的使用
## 简介
`DataFrames`可以用来处理表格式数据（类似于Python中的`Pandas`），即每一列数据有相同的属性（[类型](../advanced/typesystem.md)相同），不同列可以有不同的属性
!!! note
	Excel，数据库（如SQL）也可以用来处理这样的数据。Excel的优势是明显，但是如果将提取出来的数据用作其它地方不方便，而且只能固定xls格式；SQL非常适用于大数据量的情况下，效率会比DataFrames高出很多，但是其体积较大。相比之下，DataFrames比较适用于非固定格式、中小批量数据的分析、处理与转化

## DataFrame类型
DataFrame 类型是由若干个向量构成的数据表，每一个向量对应于一列或变量。创建 DataFrame 类型最简单的方法是传入若干个关键字-向量对，如下所示：
```jl
julia> df=DataFrame(;A=1:4, B=["C","O","D","E"])
4×2 DataFrame
 Row │ A      B
     │ Int64  String
─────┼───────────────
   1 │     1  C
   2 │     2  O
   3 │     3  D
   4 │     4  E

julia> DataFrame() # 构造空类型

julia> DataFrame([(a=1,b=2), (a=3,b=4)]) # 从NamedTuples构造
2×2 DataFrame
 Row │ a      b
     │ Int64  Int64
─────┼──────────────
   1 │     1      2
   2 │     3      4
```

## 基本操作
### 列数据获取
!!! note
	列数据的索引方法随着版本的更新不断变化，《Julia数据科学应用》中的许多API已经无法弃用

1. `df.colName`
2. `df."colName"`
3. `df[ : , :colName ]`
4. `df[ : , "colName" ]`
5. `df[ ! , :colName ]`
6. `df[ ! , "colName" ]`

- 方法1,2,5,6不会copy数据，而3,4会
- 上述列名也可以直接用列的位置代替

### 增加列
```jl
julia> df.C=2:5; df
4×3 DataFrame
 Row │ A      B       C
     │ Int64  String  Int64
─────┼──────────────────────
   1 │     1  C           2
   2 │     2  O           3
   3 │     3  D           4
   4 │     4  E           5
```

### 增加一行
!!! note
	这种方法性能较差，不太适用于大量的行数据插入
```jl
julia> push!(df,(0,"_",6))
5×3 DataFrame
 Row │ A      B       C
     │ Int64  String  Int64
─────┼──────────────────────
   1 │     1  C           2
   2 │     2  O           3
   3 │     3  D           4
   4 │     4  E           5
   5 │     0  _           6

julia> push!(df,Dict(:A=>1, :B=>"Str", :C=>7))
6×3 DataFrame
 Row │ A      B       C
     │ Int64  String  Int64
─────┼──────────────────────
   1 │     1  C           2
   2 │     2  O           3
   3 │     3  D           4
   4 │     4  E           5
   5 │     0  _           6
   6 │     1  Str         7
```

### 获取所有列名
```jl
julia> names(df)
3-element Vector{String}:
 "A"
 "B"
 "C"

julia> propertynames(df)
3-element Vector{Symbol}:
 :A
 :B
 :C
```

### 获取尺寸
```jl
julia> size(df)
(6, 3)

julia> size(df,1) # 行数
6
```

### 数据的导入与导出
可以使用[CSV](csv.md)或[Excel - XLSX](xlsx.md)或SQLite

### 显示数据
- 默认 df 根据屏幕大小打印若干行数据（并非所有）。如果需要显示所有数据，需要手动设置`allrows=true`、`allcols=true`，也可以利用`first`和`last`获得子集

### 获取DataFrame的子集
#### 普通索引
| 代码 | 用途描述 |
| --- | --- |
| `df[1:3, :]` | 1-3行，所有列 |
| `df[[1,2,4], :]` | 1、2、4行，所有列 |
| `df[:, [:A,:B]]` | 所有行，A和B列 |
| `df[:, :C]` | C列所有行，是`Vector`的实例 |
| `df[[3,1], [:B,:A]]` | 获取，得到的顺序与参数顺序相同 |
| `@view df[1:3, :A]` | 使用view宏而不返回拷贝 |
| `df[BitVector((true,false)), :]` | 逐个选择，需注意长度一致 |

其中单独的`:`可被`!`代替

#### 正则表达式、Not、All索引
```jl
julia> df = DataFrame(x1=1, x2=2, y=3);

julia> df[:, r"x"]
1×2 DataFrame
 Row │ x1     x2
     │ Int64  Int64
─────┼──────────────
   1 │     1      2

julia> df[:, Not(:x1)]
1×2 DataFrame
 Row │ x2     y
     │ Int64  Int64
─────┼──────────────
   1 │     2      3

julia> df[:, Cols(r"x", :)] # 将所有列名包含字符x的移动到最前方
1×3 DataFrame
 Row │ x1     x2     y
     │ Int64  Int64  Int64
─────┼─────────────────────
   1 │     1      2      3

julia> df[:, Cols(Not(r"x"), :)] # 将所有列名包含字符x的移动到最后方
1×3 DataFrame
 Row │ y      x1     x2
     │ Int64  Int64  Int64
─────┼─────────────────────
   1 │     3      1      2
```

#### 条件索引
利用`.`技巧可以做许多事：
```jl
julia> df=DataFrame(;A=100:100:500,B=[200,300,400,100,500]);

julia> df[df.A .> 300, :] # A列数据大于300的所有行和所有列数据
2×2 DataFrame
 Row │ A      B
     │ Int64  Int64
─────┼──────────────
   1 │   400    100
   2 │   500    500

julia> df[(df.A .> 300) .& (300 .< df.B .< 400), :]
0×2 DataFrame

julia> df[in.(df.A, Ref([300,100])), :]
2×2 DataFrame
 Row │ A      B
     │ Int64  Int64
─────┼──────────────
   1 │   100    200
   2 │   300    400
```

### 对每行数据进行处理
可以使用 `select`与`select!` 可以选择、重命名、变换列数据（对某列源数据进行处理）
```jl
julia> df = DataFrame(x1=[1, 2], x2=[3, 4], y=[5, 6]);

julia> select(df, Not(:x1)) # 丢弃列x1
2×2 DataFrame
 Row │ x2     y
     │ Int64  Int64
─────┼──────────────
   1 │     3      5
   2 │     4      6

julia> select(df, r"x")
2×2 DataFrame
 Row │ x1     x2
     │ Int64  Int64
─────┼──────────────
   1 │     1      3
   2 │     2      4

julia> select(df, :x1=>:a1, :x2=>:a2) # 重命名列名
2×2 DataFrame
 Row │ a1     a2
     │ Int64  Int64
─────┼──────────────
   1 │     1      3
   2 │     2      4

julia> select(df, :x1, :x2 => (x -> 2x)=>:x2) # 对列 x2 施加一个函数
2×2 DataFrame
 Row │ x1     x2
     │ Int64  Int64
─────┼──────────────
   1 │     1      6
   2 │     2      8

julia> select(df, :x2, :x2=>ByRow(sqrt)) # 对列 x2 中所有行数据求平方根
2×2 DataFrame
 Row │ x2     x2_sqrt
     │ Int64  Float64
─────┼────────────────
   1 │     3  1.73205
   2 │     4  2.0
```

默认 select 会拷贝原始数据返回一个新的 DataFrame 变量，若要使用[引用机制](varref.md)，传递关键字 `copycols=false` 或使用 `select!`\
`transform`、`transform!`与`select`、`select!` 的功能类似，但前两者会将源数据中的所有列显示在新的 DataFrame 变量中
```jl
julia> transform(df, All() => +) # All() 对每行的所有数据执行函数： + 
2×4 DataFrame
 Row │ x1     x2     y      x1_x2_y_+
     │ Int64  Int64  Int64  Int64
─────┼────────────────────────────────
   1 │     1      3      5          9
   2 │     2      4      6         12

julia> transform(df, AsTable(:)=>ByRow(argmax)=>:prediction) # 使用 ByRow 可以返回每行中满足函数 argmax 的列名，并不是返回数据
2×4 DataFrame
 Row │ x1     x2     y      prediction
     │ Int64  Int64  Int64  Symbol
─────┼─────────────────────────────────
   1 │     1      3      5  y
   2 │     2      4      6  y

using Statistics # 计算每行的和，个数，均值（忽略missing）
df = DataFrame(x=[1, 2, missing], y=[1, missing, missing]);
transform(df, AsTable(:) .=>
	ByRow.([sum∘skipmissing,
		x -> count(!ismissing, x),
		mean∘skipmissing])
	.=> [:sum, :n, :mean])

3×5 DataFrame
 Row │ x        y        sum    n      mean
     │ Int64?   Int64?   Int64  Int64  Float64
─────┼─────────────────────────────────────────
   1 │       1        1      2      2      1.0
   2 │       2  missing      2      1      2.0
   3 │ missing  missing      0      0    NaN
```

!!! note
	虽然可以使用上述语法进行简单的数据操作，但更推荐使用包 Query、DataramesMeta 来进行 DataFrame 的数据处理，其语法更简洁方便。

### 对每列数据进行处理
可以直接使用 `Statistics` 包对某列数据处理，如`mean(df.A)`\
也可以使用 `combine` 对每列数据进行处理
```jl
julia> df = DataFrame(A = 1:4, B = 4.0:-1.0:1.0);

julia> combine(df, names(df) .=> sum, names(df) .=> prod)
1×4 DataFrame
 Row │ A_sum  B_sum    A_prod  B_prod
     │ Int64  Float64  Int64   Float64
─────┼─────────────────────────────────
   1 │    10     10.0      24     24.0
```

### 数据描述
使用 `describe` 函数可以返回一个 DataFrame 的部分统计学特征量。
```jl
julia> df = DataFrame(A = 1:4, B = ["M", "F", "F", "M"])
4×2 DataFrame
 Row │ A      B
     │ Int64  String
─────┼───────────────
   1 │     1  M
   2 │     2  F
   3 │     3  F
   4 │     4  M

julia> describe(df)
2×7 DataFrame
 Row │ variable  mean    min  median  max  nmissing  eltype
     │ Symbol    Union…  Any  Union…  Any  Int64     DataType
─────┼────────────────────────────────────────────────────────
   1 │ A         2.5     1    2.5     4           0  Int64
   2 │ B                 F            M           0  String

julia> describe(df[:, [:A])) # 描述部分
1×7 DataFrame
 Row │ variable  mean     min    median   max    nmissing  eltype
     │ Symbol    Float64  Int64  Float64  Int64  Int64     DataType
─────┼──────────────────────────────────────────────────────────────
   1 │ A             2.5      1      2.5      4         0  Int64
```

### 替换数据
使用 `replace!` 替换修改一行源数据
```jl
julia> df = DataFrame(a = [0,1,0,1], b = 1:4); replace!(df.a, 1=>0); df
4×2 DataFrame
 Row │ a      b
     │ Int64  Int64
─────┼──────────────
   1 │     0      1
   2 │     0      2
   3 │     0      3
   4 │     0      4
```

利用`ifelse`与点运算可以替换多列数据
```jl
df[:, [:a, :b]] .= ifelse.(
	df[:, [:a, :b]] .< 3,
	-1,
	df[:, [:a, :b]]
)

julia> df
4×2 DataFrame
 Row │ a      b
     │ Int64  Int64
─────┼──────────────
   1 │    -1     -1
   2 │    -1     -1
   3 │    -1      3
   4 │    -1      4
```

上面的 `.=` 会修改df, 如果用 `=` 则会生成一个新 DataFrame。
如果想用 `missing` 替换缺失值时并且原有的DataFrame列不允许用`missing`时，就必须使用 `=` 或者对`df`使用`allowmissing!`

## 多个DataFrame的连接组合
这里的操作类似于关系数据库中的`join`操作，包括
- `innerjoin`：包含键存在所有DataFrame中的值
- `leftjoin`：包含键存在于左侧的参数中，不管是否在第二（右侧）参数
- `rightjoin`：包含键存在于第二（右侧的参数），不管左侧
- `outerjoin`：包含任意一个键值
- `semijoin`：类似innerjoin，但是输出严格限制在左侧参数所在列
- `antijoin`：仅包含左侧，不包含右侧。输出仅左侧的键
- `crossjoin`：所有DataFrame的笛卡尔积

```jl
people = DataFrame(ID = [1, 2], Name = ["Mr Law", "Mr Food"]);
jobs = DataFrame(ID = [1, 3], Job = ["Lawyer", "Teacher"]);

julia> innerjoin(people, jobs; on=:ID)
1×3 DataFrame
 Row │ ID     Name    Job
     │ Int64  String  String
─────┼───────────────────────
   1 │     1  Mr Law  Lawyer

julia> leftjoin(people, jobs; on=:ID)
2×3 DataFrame
 Row │ ID     Name     Job
     │ Int64  String   String?
─────┼─────────────────────────
   1 │     1  Mr Law   Lawyer
   2 │     2  Mr Food  missing

julia> rightjoin(people, jobs; on=:ID)
2×3 DataFrame
 Row │ ID     Name     Job
     │ Int64  String?  String
─────┼─────────────────────────
   1 │     1  Mr Law   Lawyer
   2 │     3  missing  Teacher

julia> outerjoin(people, jobs; on=:ID)
3×3 DataFrame
 Row │ ID     Name     Job
     │ Int64  String?  String?
─────┼─────────────────────────
   1 │     1  Mr Law   Lawyer
   2 │     2  Mr Food  missing
   3 │     3  missing  Teacher

julia> semijoin(people, jobs; on=:ID)
1×2 DataFrame
 Row │ ID     Name
     │ Int64  String
─────┼───────────────
   1 │     1  Mr Law

julia> antijoin(people, jobs; on=:ID)
1×2 DataFrame
 Row │ ID     Name
     │ Int64  String
─────┼────────────────
   1 │     2  Mr Food

julia> crossjoin(people, jobs; makeunique=true)
4×4 DataFrame
 Row │ ID     Name     ID_1   Job
     │ Int64  String   Int64  String
─────┼────────────────────────────────
   1 │     1  Mr Law       1  Lawyer
   2 │     1  Mr Law       3  Teacher
   3 │     2  Mr Food      1  Lawyer
   4 │     2  Mr Food      3  Teacher
```

如果要匹配的两列名不同，可以使用`left=>right`表示对应关系
```jl
a = DataFrame(ID = [1, 2], Name = ["Mr Law", "Mr Food"]);
b = DataFrame(IDNew = [1, 2], Job = ["Lawyer", "Teacher"]);

julia> innerjoin(a, b, on = :ID => :IDNew)
2×3 DataFrame
 Row │ ID     Name     Job
     │ Int64  String   String
─────┼─────────────────────────
   1 │     1  Mr Law   Lawyer
   2 │     2  Mr Food  Teacher

a = DataFrame(
	City = ["Amsterdam", "London", "London", "New York", "New York"],
	Job = ["Lawyer", "Lawyer", "Lawyer", "Doctor", "Doctor"],
	Category = [1, 2, 3, 4, 5]
);
b = DataFrame(
	Location = ["Amsterdam", "London", "London", "New York", "New York"],
	Work = ["Lawyer", "Lawyer", "Lawyer", "Doctor", "Doctor"],
	Name = ["a", "b", "c", "d", "e"]
);

julia> innerjoin(a, b, on = [:City=>:Location, :Job=>:Work])
9×4 DataFrame
 Row │ City       Job     Category  Name
     │ String     String  Int64     String
─────┼─────────────────────────────────────
   1 │ Amsterdam  Lawyer         1  a
   2 │ London     Lawyer         2  b
   3 │ London     Lawyer         3  b
   4 │ London     Lawyer         2  c
   5 │ London     Lawyer         3  c
   6 │ New York   Doctor         4  d
   7 │ New York   Doctor         5  d
   8 │ New York   Doctor         4  e
   9 │ New York   Doctor         5  e
```

## 数据分割与组合
许多数据分析任务需要将数据分割成group，然后对每个group应用函数，并将结果组成起来\
可以使用`groupby`与上午`combine`等函数完成这一策略。`groupby(df, cols)`将会返回一个 `GroupedDataFrame` 类型变量，从而针对每组使用上述函数。
```jl
julia> using CSV, Statistics

julia> iris = CSV.read(joinpath(dirname(pathof(DataFrames)), "../docs/src/assets/iris.csv"), DataFrame); # 导入鸢尾属植物数据

julia> gdf = groupby(iris, :Species); # 按照Species分类

julia> combine(gdf, :PetalLength => mean) # 求每个group的均值
3×2 DataFrame
 Row │ Species          PetalLength_mean
     │ String           Float64
─────┼───────────────────────────────────
   1 │ Iris-setosa                 1.464
   2 │ Iris-versicolor             4.26
   3 │ Iris-virginica              5.552

julia> combine(gdf, nrow) # 求每个group的数量
3×2 DataFrame
 Row │ Species          nrow
     │ String           Int64
─────┼────────────────────────
   1 │ Iris-setosa         50
   2 │ Iris-versicolor     50
   3 │ Iris-virginica      50

julia> combine(gdf, nrow, :PetalLength => mean => :mean) # 求每个group的数量，PetalLength的均值，并将结果列重命名为mean
3×3 DataFrame
 Row │ Species          nrow   mean
     │ String           Int64  Float64
─────┼─────────────────────────────────
   1 │ Iris-setosa         50    1.464
   2 │ Iris-versicolor     50    4.26
   3 │ Iris-virginica      50    5.552

julia> combine([:PetalLength, :SepalLength] => (p, s) -> (a=mean(p)/mean(s), b=sum(p)), gdf) # 将多列作为函数参数传递
# 错误 @todo

combine(gdf, # AsTable将两列作为namedtuple传递
	AsTable([:PetalLength, :SepalLength]) =>
	x -> std(x.PetalLength) / std(x.SepalLength)
)

3×2 DataFrame
 Row │ Species          PetalLength_SepalLength_function
     │ String           Float64
─────┼───────────────────────────────────────────────────
   1 │ Iris-setosa                              0.492245
   2 │ Iris-versicolor                          0.910378
   3 │ Iris-virginica                           0.867923

julia> combine(x -> std(x.PetalLength) / std(x.SepalLength), gdf)
3×2 DataFrame
 Row │ Species          x1
     │ String           Float64
─────┼───────────────────────────
   1 │ Iris-setosa      0.492245
   2 │ Iris-versicolor  0.910378
   3 │ Iris-virginica   0.867923

julia> combine(gdf, 1:2 => cor, nrow) # 第一列求函数cor（卷积）,第二列求数量
3×3 DataFrame
 Row │ Species          SepalLength_SepalWidth_cor  nrow
     │ String           Float64                     Int64
─────┼────────────────────────────────────────────────────
   1 │ Iris-setosa                        0.74678      50
   2 │ Iris-versicolor                    0.525911     50
   3 │ Iris-virginica                     0.457228     50
```

与combine不同，`select`和`transform`函数返回与源数据同样数量、次序的DataFrame实例
!!! info
	combine 是对列进行操作，而select和transform是对每行进行操作
```jl
julia> select(gdf, 1:2 => cor) # 求每行中列1-2的cor函数
150×2 DataFrame
 Row │ Species         SepalLength_SepalWidth_cor
     │ String          Float64
─────┼────────────────────────────────────────────
   1 │ Iris-setosa                       0.74678
...
 150 │ Iris-virginica                    0.457228
                                  129 rows omitted

julia> transform(gdf, :Species => x -> chop.(x, head=5, tail=0))
150×6 DataFrame
 Row │ SepalLength  SepalWidth  PetalLength  PetalWidth  Species         Species_function
     │ Float64      Float64     Float64      Float64     String          SubString…
─────┼────────────────────────────────────────────────────────────────────────────────────
   1 │         5.1         3.5          1.4         0.2  Iris-setosa     setosa
...
 150 │         5.9         3.0          5.1         1.8  Iris-virginica  virginica
                                                                          129 rows omitted
```

组的遍历：
```jl
julia> for subdf in groupby(iris, :Species)
           println(size(subdf, 1))
       end
50
50
50

julia> for (key, subdf) in pairs(groupby(iris, :Species))
           println("$(key.Species): $(nrow(subdf))")
       end
Iris-setosa: 50
Iris-versicolor: 50
Iris-virginica: 50
```

可以使用`Tuple`或`NamedTuple`索引`GroupedDataFrame`实例
```jl
julia> df = DataFrame(g = repeat(1:3, inner=5), x = 1:15); gdf=groupby(df, :g);

julia> gdf[(g=1,)]
5×2 SubDataFrame
 Row │ g      x
     │ Int64  Int64
─────┼──────────────
   1 │     1      1
   2 │     1      2
   3 │     1      3
   4 │     1      4
   5 │     1      5

julia> gdf[[(1, ), (3,)]]
GroupedDataFrame with 2 groups based on key: g
First Group (5 rows): g = 1
 Row │ g      x
     │ Int64  Int64
─────┼──────────────
   1 │     1      1
   2 │     1      2
   3 │     1      3
   4 │     1      4
   5 │     1      5
⋮
Last Group (5 rows): g = 3
 Row │ g      x
     │ Int64  Int64
─────┼──────────────
   1 │     3     11
   2 │     3     12
   3 │     3     13
   4 │     3     14
   5 │     3     15
```

将一个函数应用到所有列上：
```jl
gd = groupby(iris, :Species);
combine(gd, valuecols(gd) .=> mean); # 所有列求均值
combine(gd, valuecols(gd) .=> (x -> (x .- mean(x)) ./ std(x)) .=> valuecols(gd)); # 对所有列求标准差，输出的列名仍是原来的列名
```

[^1]: https://github.com/noob-data-analaysis/data-analysis/blob/master/%5B%E6%95%B0%E6%8D%AE%E8%8E%B7%E5%BE%97DataFrames%5D%40Andy.Yang/DataFrames.md
