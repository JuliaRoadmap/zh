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
- `version`当前[版本](../advanced/versionnumber.md)
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

## 手动测试
`add`命令允许参数是一个本地路径，从而在安装本地包，以模拟包环境\
需注意的是，该路径指向的资源必须是一个git仓库，且读取最近的commit数据

## 命名规范
* 包名应该对大多数Julia用户来说是合理的，甚至对那些不是领域专家的用户也是如此
* 避免使用（信息技术以外的）`术语(jargon)`，特别是首字母缩写，除非混淆的可能性极小
* 名字中不应包含`Julia`，也不应以`Ju`开头
* 若提供某新类型占大部分功能的包，名称应是复数，如`DataFrames`
* 不应与已有名字太接近，这是为了防止[类似事件](https://blog.rust-lang.org/2022/05/10/malicious-crate-rustdecimal.html)
* 包裹外部库/项目的包应有相同名称 [^1]

## 注册
若需要在[General](https://github.com/JuliaRegistries/General)中注册，请登录juliahub后在[此](https://juliahub.com/ui/Registrator)输入信息\
可以注册新包或版本更新，但应注意：
1. 不能注册pre-release
2. 不能跳过版本

[FAQ](https://github.com/JuliaRegistries/General#faq)

## 最佳实践
包应该避免改变自己的状态（写入包目录中的文件）。一般来说，包不应该假定它们位于可写的位置，甚至不应该假定它们位于稳定的位置（例如，如果它被捆绑到一个系统映像中）。为了支持Julia包生态系统中的各种用例，Pkg开发人员创建了许多辅助包和技术，以帮助包作者创建自包含的、不可变的和可重定位的包：

### Artifacts
Julia 1.3以后，`Artifacts`可以用于将数据块与包捆绑在一起，甚至允许按需下载它们。优先选择`Artifacts`，而不是试图通过路径，因为这是不可重定位的：一旦你的包被预编译，`@__DIR__`的结果将被嵌入到预编译的包数据中，如果你试图分发这个包，它将试图在错误的位置加载文件

### Scratch
Julia 1.5以后，[Scratch](scratch.md)提供了*临时空间*的概念，即包的可变数据容器。Scratch空间是为完全由包管理的数据缓存设计的，应该在包本身卸载时删除。对于重要的用户生成的数据，包应该继续写入到一个用户指定的路径，该路径不是由`Julia`或`Pkg`管理的

### Preferences
Julia 1.6以后，`Preferences`允许包读写首选项到顶级的`Project.toml`。这些首选项可以在运行时或编译时读取，以启用或禁用包行为的不同方面（以前，包会将文件写入到它们自己的包目录中以记录由用户或环境设置的选项，但现在不鼓励该行为）

[^1]: https://pkgdocs.julialang.org/v1/
