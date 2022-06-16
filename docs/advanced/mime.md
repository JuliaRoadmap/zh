# MIME
[MIME相关知识](../knowledge/mime.md)

```jl
julia> isa(MIME("text/plain"), MIME"text/plain") # 后者生成一个类型
true

julia> show(stdout, MIME("text/plain"), "<>")
"<>"
julia> show(stdout, MIME("text/csv"), "<>")
<
>
```

MIME被允许作为[show](typesystem.md#自定义显示)的第二个参数
