# 多维数组
内置数组的类型名为 `Array`。
Julia 中数组的一大特点是，它本身可以是任意维的，这类似于数学中的「张量」。
```jl
julia> Vector # 一维数组是数组的特例
Vector{T} where T (alias for Array{T, 1} where T)

julia> Array{Int,3}(undef,2,2,2) # 生成一个未初始化的 2x2x2 数组
2×2×2 Array{Int64, 3}:
[:, :, 1] =
 272741312  284121296
 272741312  284121296

[:, :, 2] =
 272755984  287668496
 272755984  426754624

julia> v=[1 2 3;4 5 6;7 8 9] # 快速生成二维数组
3×3 Matrix{Int64}:
 1  2  3
 4  5  6
 7  8  9

julia> Matrix # 二维数组是数组的特例
Matrix{T} where T (alias for Array{T, 2} where T)

julia> v[3,2] # 通过下标访问
8

julia> v[2:3,2:3] # 通过范围访问
2×2 Matrix{Int64}:
 5  6
 8  9

julia> v[1,1]=0 # 通过下标修改
0

julia> v=[1 2 3] # 注意：生成的也是二维数组
1×3 Matrix{Int64}:
 1  2  3

julia> size(v) # 各维度长度
(1, 3)

julia> size(v,1) # 第一维长度
1

julia> mat=Matrix(undef,0,0)
0×0 Matrix{Any}

julia> mat==[[]] # 数组的数组（此为Vector{Vector}）与多维数组（此为Matrix）是不同的
false
```
