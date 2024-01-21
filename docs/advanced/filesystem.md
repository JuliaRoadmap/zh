# 文件系统
!!! note
	[相关知识](../knowledge/filesystem.md)

文件系统的相关内容在 `Base.Filesystem` 中，可以查看帮助文档。
函数名通常与 Linux 中一致，例如：
```julia-repl
julia> cd("D:/")

julia> pwd()
"D:\\"

julia> mkdir("1")
"1"
```

## joinpath
`joinpath` 可以用于将路径拼接，但不会检测路径是否存在。
```julia-repl
julia> joinpath("/dev","null") # 一些操作系统下默认使用 "\" 分隔
"/dev\\null"

julia> joinpath("/dev","/null/1") # 后者是绝对路径，覆盖前者
"/null/1"
```
