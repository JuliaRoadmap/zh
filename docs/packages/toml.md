# TOML
[关于 TOML 文本格式](../knowledge/toml.md)

## 类型
`TOML.Parser` 是 TOML 解释器类型。
`TOML.ParserError` 是表示解释错误的类型。

## 工具
- `parse([p::Parser], x::Union{AbstractString, IO})` 解释 TOML，失败时会抛出 `ParserError`
- `print([io::IO], x::AbstractDict)` 将数据转化为 TOML 格式
- `parsefile([p::Parser], f::AbstractString)` 解释 `f` 文件中的 TOML，失败时会抛出 `ParserError`

同时，也存在 `tryparse` 和 `tryparsefile`，它们在解释失败时会将 `ParserError` 作为返回值

```julia-repl
julia> TOML.parse("""
       [num]
       a=nan
       """)
Dict{String, Any} with 1 entry:
  "num" => Dict{String, Any}("a"=>NaN)

julia> TOML.parse("""
       [num]
       a=nan*
       """)
ERROR: TOML Parser error:
none:3:-1 error: expected newline after key value pair
  a=nan*

Stacktrace:
...
```
