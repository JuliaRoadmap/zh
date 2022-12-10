# TOML的使用
## 文本格式
[官方文档的翻译](https://github.com/LongTengDao/TOML/blob/%E9%BE%99%E8%85%BE%E9%81%93-%E8%AF%91/toml-v1.0.0.md)

## 类型
`TOML.Parser` TOML解释器类型\
`TOML.ParserError` 解释错误

## 工具
`parse([p::Parser], x::Union{AbstractString, IO})`解释TOML，失败时会抛出`ParserError`\
`print([io::IO], x::AbstractDict)`将数据转化为TOML格式\
`parsefile([p::Parser], f::AbstractString)`解释`f`文件中的TOML，失败时会抛出`ParserError`

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
