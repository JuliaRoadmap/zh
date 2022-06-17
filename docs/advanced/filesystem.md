# 文件系统
[相关知识](../knowledge/filesystem.md)\
文件系统的相关内容在`Base.Filesystem`中，可以查看帮助文档\
文件系统中最常用的函数是`joinpath`，用于将路径拼接，但不会检测存在性
```jl
julia> joinpath("/dev","null") # 一些操作系统下默认使用 "\" 分隔
"/dev\\null"

julia> joinpath("/dev","/null/1") # 后者是绝对路径，覆盖前者
"/null/1"
```
