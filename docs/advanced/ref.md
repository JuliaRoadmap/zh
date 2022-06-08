# 引用
[Ref相关类型层级关系](../lists/typetree1.6.txt#L947-L953)

## 纯数据类型
纯数据类型指不可变且仅所有字段均是纯数据类型的类型，原始类型也是纯数据类型\
可以用`isbitstype`判断类型是否是纯数据类型，用`isbits`判断是否为其实例

## Ref
`RefValue`和`RefArray`都保证指向的数据可用\
使用`Ref(x)`创建对于`x`的引用，它是`RefValue`的实例，也可以使用`Ref{T}()`创建对T类型值的引用而不初始化，此时引用指向[未定义值](undef.md)
```jl
julia> x=0; ref=Ref(x)
Base.RefValue{Int64}(0)

julia> ref[]=3; ref[] # 用[]加载或存储
3

julia> x
0
```

可以用`Ref(arr,i)`创建对于arr的第i个元素的引用
```jl
julia> v=[1 2 3;4 5 6];ref=Ref(v,4)
Base.RefArray{Int64, Matrix{Int64}, Nothing}([1 2 3; 4 5 6], 4, nothing)

julia> ref[], v[4]
(5, 5)

julia> ref[]=3; v
2×3 Matrix{Int64}:
 1  2  3
 4  3  6
```

作为调用[ccall](ccall.md)的参数传递时，Ref对象将被转换为指向它引用的数据
