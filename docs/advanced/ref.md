# 引用
[Ref相关类型层级关系](../lists/typetree1.8.txt#L1042-L1048)

## 纯数据类型
纯数据类型指不可变且仅所有字段均是纯数据类型的类型，原始类型也是纯数据类型。
可以用 `isbitstype` 判断类型是否是纯数据类型，用 `isbits` 判断是否为其实例。

## Ref
`RefValue` 和 `RefArray` 都保证指向的数据可用。

使用 `Ref(x)` 创建对于 `x` 的引用，它是 `RefValue` 的实例，也可以使用 `Ref{T}()` 创建对 T 类型值的引用而不初始化，此时引用指向[未定义值](undef.md)
```julia-repl
julia> x=0; ref=Ref(x)
Base.RefValue{Int64}(0)

julia> ref[]=3; ref[] # 用[]加载或存储
3

julia> x
0
```

可以用 `Ref(arr,i)` 创建对于 arr 的第 i 个元素的引用
```julia-repl
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

## 指针
`Ptr{T}` 是指向T类型的指针，它的实例不保证地址可用/那里有所需数据。

使用 `Ptr{T}()` 获取 T 类型的空指针：
```julia-repl
julia> p=P(2,0x1=>0x3); ptr=pointer_from_objref(p)
Ptr{Nothing} @0x000000001992e550

julia> unsafe_pointer_to_objref(ptr)
P(2, 0x01 => 0x03)

julia> v=[1,2,3]; ptr2=pointer(v,1)
Ptr{Int64} @0x0000000076ed12b0

julia> unsafe_load(ptr2,1)
1
```

!!! note
	常量 `C_NULL` 是 `Ptr{Nothing}`，表示 C 的 NULL，C++11 的 nullptr

## unsafe

## 内存池
可以使用 `Libc.malloc(size)` 申请内存，需记得自己用 `Libc.free(ptr)` 释放内存
