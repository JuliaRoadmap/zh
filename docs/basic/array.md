# 多维数组
Julia 内置数组的类型名为 `Array`。不同于一些语言中只定义了类似 `Vector` 的结构，Julia 中的数组可以定义成任意维的。

## 类型
```julia-repl
julia> Vector # 一维数组 Vector 是数组的特例
Vector{T} where T (alias for Array{T, 1} where T)

julia> Array{Int, 3}(undef, 2, 2, 2) # 生成一个未初始化的 2×2×2 数组
2×2×2 Array{Int64, 3}:
[:, :, 1] =
 272741312  284121296
 272741312  284121296

[:, :, 2] =
 272755984  287668496
 272755984  426754624

julia> Matrix # 二维数组 Matrix 是数组的特例
Matrix{T} where T (alias for Array{T, 2} where T)
```

需要注意，数组的数组 `Vector{Vector}` 与二维数组 `Matrix` 是不同的。

一些静态语言中默认的数组都是不可变长数组，进行区分无太大意义，但在 Julia 中这有很大的区别。例如：数组的数组 `[[], [0], [0, 1]]`，它的各个元素（是数组）的长度可以是不同的，而 `Matrix` 则无法做到这一点。

## 字面量
```julia-repl
julia> v = [1 2 3] # 注意：生成的也是二维数组
1×3 Matrix{Int64}:
 1  2  3

julia> v = [1 2 3 ; 4 5 6 ; 7 8 9] # 二维数组
3×3 Matrix{Int64}:
 1  2  3
 4  5  6
 7  8  9

julia> [1 2 ; 3 4 ;;; 5 6 ; 7 8] # 在 Julia 1.7 以后，3 维或更多维的数组可以被字面量表示。
2×2×2 Array{Int64, 3}:
[:, :, 1] =
 1  2
 3  4

[:, :, 2] =
 5  6
 7  8

julia> [1 2 ;;;; 3 4]
1×2×1×2 Array{Int64, 4}:
[:, :, 1, 1] =
 1  2

[:, :, 1, 2] =
 3  4
```

此语法也可用于拼接多维数组

```julia-repl
julia> const a, b, c = fill(1, 1, 2, 1, 2), fill(2, 2, 2, 1, 2), fill(3, 3, 2, 1, 3);

julia> [a ; b ;;;; c]
3×2×1×5 Array{Int64, 4}:
[:, :, 1, 1] =
 1  1
 2  2
 2  2

[:, :, 1, 2] =
 1  1
 2  2
 2  2

[:, :, 1, 3] =
 3  3
 3  3
 3  3

[:, :, 1, 4] =
 3  3
 3  3
 3  3

[:, :, 1, 5] =
 3  3
 3  3
 3  3
```

## 索引
多维数组也可通过下标访问，在 `[]` 中填充所有维度的参数。
```julia-repl
julia> v[3, 2]
8

julia> v[2:3, 2:3] # 通过范围访问
2×2 Matrix{Int64}:
 5  6
 8  9

julia> v[1, 1] = 0 # 通过下标修改
0
```

## 杂项
```julia-repl
julia> size(v) # 各维度长度
(1, 3)

julia> size(v, 1) # 第一维长度
1

julia> mat = Matrix(undef, 0, 0)
0×0 Matrix{Any}

julia> mat == [[]]
false
```
