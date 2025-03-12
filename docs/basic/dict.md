# 字典
`Dict` 可以创建一个**字典（dictionary）**，即一个**键**到**值**映射的结构，可以按照键名存放或取出数据。例如，你可以用它存储一个英文单词对应的翻译（这可能键的类型是字符串，值的类型是字符串数组）。

## 初始化
```julia-repl
julia> d = Dict("one" => 1, "two" => 2)
Dict{String, Int64} with 2 entries:
  "two" => 2
  "one" => 1
```

对于上例，可以更精确地指定 `Dict{String, Int}("one" => 1, "two" => 2)`

## 功能
```julia-repl
julia> d["one"] # 查字典
1

julia> d["one"]=100 # 改字典，若不存在则添加
100

julia> d.count # 字典长度
2

julia> keys(d) # 目录列表
KeySet for a Dict{String, Int64} with 2 entries. Keys:
  "two"
  "one"

julia> values(d) # 值列表
ValueIterator for a Dict{String, Int64} with 2 entries. Values:
  2
  100

julia> haskey(d, "one") # 是否在字典中
true

julia> delete!(d, "one") # 删除一项
Dict{String, Int64} with 1 entry:
  "two" => 2

julia> get(d, "three", 3) # 一个常用的功能：提供默认值
3
```

通过对 `Dict` 遍历得到的 `Pair` 实例称为「键值对」，其中 `pair.first` 是**键（key）**，`pair.second` 是**值（value）**。

类似 `Dict` 的结构也常以 `JSON`、`YAML`、`TOML` 等格式用于配置/设置中，此时「键」有时被称为「项」、「字段」、「节」，用于表达其在配置中的含义。
