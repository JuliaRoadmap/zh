# 包开发
## 结构生成
设置好路径后，可以使用
```jl
(@v1.6) pkg> generate foo
```

在[相对路径](../knowledge/filesystem.md#路径)`./foo`处生成一个目录，包含包的基本结构：
- `src/foo.jl`，包含一个[模块](../advanced/module.md)的基本结构
- `Project.toml`，包含相关信息

[官方提供的包示例](https://github.com/JuliaLang/Example.jl)\
[一个包：包模板](https://invenia.github.io/PkgTemplates.jl/stable/)

## Project.toml
`Project.toml`使用[TOML格式](toml.md)，必须含有以下内容
- `name`表示包名，应与模块名一致
- `uuid`一个独一无二的UUID，可以使用[UUIDs](uuids.md)生成
- `version`当前[版本](../advanced/version.md)
- `[deps]`一个字典，包含`基于的包名 = "它的UUID"`
- `[compat]`一个字典，包含`包名 = "支持的版本"`，特别地，`julia`表示支持的Julia 版本

示例
```jl
name = "LightLearn"
uuid = "aea05ee4-eee8-4bb2-9be1-ccb376bfd141"
authors = ["Rratic"]
version = "1.1.0"

[deps]
ColorTypes = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
PNGFiles = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"

[compat]
julia = "1"
ColorTypes = "0.11"
PNGFiles = "0.3"
```

## build
该功能不是必要的\
当包第一次被安装或运行`build`命令时，会调用`deps/build.jl`的代码\
若`build`失败，会在终端显示

## test
该功能不是必要的\
运行`test`命令时，会调用`test/runtests.jl`的代码

## 命名规范

## 最佳实践

[^1]: https://pkgdocs.julialang.org/v1/
