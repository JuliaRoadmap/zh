# 多维数组
数组称为`Array`

```jl
julia> Vector # 一维数组是数组的特例
Vector{T} where T (alias for Array{T, 1} where T)

julia> Array{Int,3}(undef,2,2,2) # 生成一个未初始化的2x2x2数组
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

julia> size([1 2 3;4 5 6]) # 各维度长度
(2, 3)
```

!!! note
	数组的数组与多维数组是不同的
