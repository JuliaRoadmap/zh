# Revise的使用
Revise 是开发包时的实用工具，可以边测试边修改程序（文件）而无需重启环境
```jl
(@v1.6) pkg> activate D:/MyPack

julia> using Revise

julia> using MyPack

julia> # 进行测试
```
