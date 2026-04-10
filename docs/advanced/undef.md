# 未定义
`UndefInitializer` 是表示「初始值未定义」的[单例类型](struct.md#字段)，它的唯一实例是 `undef`。

当它被用于容器构造时，可以指定值的类型。若该类型是[纯数据类型](ref.md#纯数据类型)，则内存被直接分配，得到的值没有被指定，因此是随机的。[^1]直接使用该值是无意义的（它也不应作为随机数的来源）。
```@repl
Vector{Pair{Int, Int}}(undef, 1)
mutable struct P x::Int; y::Pair{UInt8, UInt8} end
v = Vector{P}(undef, 1) # P 不是纯数据类型
isassigned(v, 1)
v[1]
r = Ref{P}()
r[]
```

[^1]: 硬件中原有的值可能是其它程序写入并释放的
