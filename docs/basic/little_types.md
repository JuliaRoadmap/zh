# 小类型
## 无
`Nothing`，具有唯一值`nothing`，用于对应`C`中的`void`\
`nothing`不会被REPL特别显示
```jl
julia> "a";nothing

julia> x=nothing
```

## 未定义
`UndefInitializer`，通常用于数组初始化，可以用`undef`替代`UndefInitializer()`，[详细信息见此](../advanced/undef.md)

## 元组
`Tuple`一个容纳任意有限多个数据的类型
```jl
julia> tup=(1,2,3)
(1, 2, 3)

julia> typeof(tup) # 这表明tup的3个参数类型均为Int64
Tuple{Int64, Int64, Int64}

julia> Tuple{Vararg{Int64,3}} # 一种仅对Tuple有效的简写方式
Tuple{Int64, Int64, Int64}

julia> isa(tup,NTuple{3,Int}) # 另一种写法
true

julia> tup[1] # 获取第一个数据
1

julia> (1,2,3)==(1,2,4) # 多个元素比较的一种简便方法
false
```

## 对
```jl
julia> pair=Pair(1,2)
1 => 2

julia> pair.first
1

julia> pair.second
2
```

注意不要将元组与对搞混

## 共用
可以使用`Union{类型1,类型2}`声明一个新[类型](../advanced/typesystem.md)，它的实例是类型1，类型2之一
```jl
julia> MyType=Union{Bool,Int,Float64}
Union{Bool, Int64}

julia> isa(true,MyType)
true
```
