# 二叉树
```jl
mutable struct Tree{T} where T
	num::Vector{Int}
	par::Vector{Int}
	lch::Vector{Int}
	rch::Vector{Int}
	data::Vector{T}
end
```

```jl
mutable struct Tree{T} where T
	num::Int
	par::Union{Tree{T}, Nothing}
	lch::Union{Tree{T}, Nothing}
	rch::Union{Tree{T}, Nothing}
	data::T
end
```
