# 二叉树
二叉树是一种特殊的树

## 代码实现
一种方式是使用数组
```jl
mutable struct Tree{T} where T
	num::Vector{Int}
	par::Vector{Int}
	lch::Vector{Int}
	rch::Vector{Int}
	data::Vector{T}
end
```

一种是使用节点
```jl
mutable struct Tree{T} where T
	num::Int
	par::Union{Tree{T}, Nothing}
	lch::Union{Tree{T}, Nothing}
	rch::Union{Tree{T}, Nothing}
	data::T
end
```
