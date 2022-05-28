# 交换
## 基本方法
### 中间变量
```jl
julia> x,y=([0],[1])
([0], [1])

julia> t=deepcopy(x)
1-element Vector{Int64}:
 0

julia> x=deepcopy(y)
1-element Vector{Int64}:
 1

julia> y=t
1-element Vector{Int64}:
 0

julia> x,y
([1], [0])
```

### 语法糖
```jl
julia> x,y=([0],[1])
([0], [1])

julia> x,y=(y,x)
([1], [0])

julia> x,y
([1], [0])
```

## 封装
由于该功能较为常用，对其进行封装
```jl
function swap(v::Vector,x::Int,y::Int)
    v[x],v[y]=(v[y],v[x])
end
```
