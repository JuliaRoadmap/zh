# 小类型
## 无
`Nothing`，具有唯一值`nothing`，用于对应`C`中的`void`\
`nothing`不会被REPL特别显示
```jl
julia> "a";nothing

julia>
```

## 未定义
`UndefInitializer`，通常用于数组初始化，开源用`undef`替代`UndefInitializer()`

