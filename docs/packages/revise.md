# Revise的使用
Revise 是开发包时的实用工具，可以边测试边修改程序（文件）而无需重启环境
```jl
(@v1.6) pkg> activate D:/MyPack

julia> using Revise

julia> using MyPack

julia> # 进行测试
```

需注意的是，如果测试是已经构造了某类型的实例，而在修改文件时修改了该类型结构（或类似操作），Revise 没有能力完成，因而利用 Revise 修改程序时主要修改方法。
