# 未定义
`UndefInitializer`是表示未定义初始化的[单例类型](struct.md#字段)，它的唯一实例是`undef`\
当它被用于容器构造时，可以指定值的类型。若该类型是[纯数据类型](ref.md#纯数据类型)，则内存被直接分配，得到的值未被覆盖，可能是其它程序写入并释放的
```julia-repl
julia> Vector{Pair{Int,Int}}(undef,1)
1-element Vector{Pair{Int64, Int64}}:
 0 => 434257936

julia> mutable struct P x::Int; y::Pair{UInt8,UInt8} end

julia> v=Vector{P}(undef,1) # 由于P不是纯数据类型
1-element Vector{P}:
 #undef

julia> isassigned(v,1)
false

julia> v[1]
ERROR: UndefRefError: access to undefined reference

julia> r=Ref{P}()
Base.RefValue{P}(#undef)

julia> r[]
ERROR: UndefRefError: access to undefined reference
```
