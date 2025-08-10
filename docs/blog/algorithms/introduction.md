# 简介
## 导航
一般来说，在实际使用时不建议自己实现算法而应使用包中现成的算法。

以下是一些相关学习资源：
* [oi-wiki](https://oi-wiki.org/)：获得更专业的信息
* [DataStructures](https://github.com/JuliaCollections/DataStructures.jl)：代码是数据结构类算法的实例
* [TheAlgorithms](https://github.com/thealgorithms/julia)：有实例，**但代码质量无法保证**

## 交换变量
交换变量基础且涉及 Julia 特性，在此特别讨论。

可以使用中间变量：
```julia-repl
julia> x, y = ([0], [1])
([0], [1])

julia> t = deepcopy(x)
1-element Vector{Int64}:
 0

julia> x = deepcopy(y)
1-element Vector{Int64}:
 1

julia> y = t
1-element Vector{Int64}:
 0

julia> x, y
([1], [0])
```

另可使用语法糖：
```julia-repl
julia> x, y = ([0], [1])
([0], [1])

julia> x, y = (y, x)
([1], [0])

julia> x
1-element Vector{Int64}:
 1
```

由于该功能较为常用，之后的文章中默认如下定义
```julia
function swap(v::Vector, x::Int, y::Int)
    v[x], v[y] = (v[y], v[x])
end
```
