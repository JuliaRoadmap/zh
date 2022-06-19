# 变量引用机制
对于[可变复合类型](struct.md#可变复合类型)（使用`ismuttable(类型)`判断），在赋值与传参时使用引用机制，即
```jl
julia> mutable struct MS
           v::Int
       end

julia> a=MS(3)
MS(3)

julia> b=a
MS(3)

julia> b.v=4
4

julia> a
MS(4)
```

对b的字段（直接或间接）进行修改时，a的值也会“同步”更改，这是因为它们绑定了相同的数据块
```jl
julia> b=MS(0)
MS(0)

julia> a
MS(4)
```

对于上面的操作，由于b重新绑定了数据块，不会对a造成影响

## 拷贝
`copy`函数可以对数组进行`浅拷贝(shallow copy)`，它只会复制外壳而不会复制内部数据
```jl
julia> a=[MS(0)]
1-element Vector{MS}:
 MS(0)

julia> b=copy(a)
1-element Vector{MS}:
 MS(0)

julia> push!(b, MS(1)); a
1-element Vector{MS}:
 MS(0)

julia> b[1].v=1; a
1-element Vector{MS}:
 MS(1)
```

`deepcopy`函数可以对物体进行`深拷贝(deep copy)`，它会复制所有东西
