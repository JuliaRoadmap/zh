# MIME
[MIME相关知识](../knowledge/mime.md)

```jl
julia> isa(MIME("text/plain"), MIME"text/plain") # 后者生成一个类型
true

julia> show(stdout, MIME("text/plain"), [1 2;3 4])
2×2 Matrix{Int64}:
 1  2
 3  4
julia> show(stdout, MIME("text/csv"), [1 2;3 4])
1,2
3,4
```

MIME被允许作为[show](typesystem.md#自定义显示)的第二个参数
