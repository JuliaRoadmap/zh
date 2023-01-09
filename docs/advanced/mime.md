# MIME
[MIME 相关知识](../knowledge/mime.md)

```jl
value = MIME("text/plain")
type = MIME"text/plain"
isa(value, type)
```

MIME 被允许作为 [show](typesystem.md#自定义显示) 的第二个参数，用于控制输出格式
```julia-repl
julia> show(stdout, MIME("text/plain"), [1 2;3 4])
2×2 Matrix{Int64}:
 1  2
 3  4
julia> show(stdout, MIME("text/csv"), [1 2;3 4])
1,2
3,4
```
