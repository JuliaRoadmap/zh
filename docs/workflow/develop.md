# 包开发
## Git 仓库
通常来说，包的全部数据应该是一个 [Git](../knowledge/git.md) 仓库，并且被置于 [Github](../knowledge/github.md)（或其它保证长期稳定的服务器）中。

按照惯例，建议在仓库中添加如下内容，特别是如果你想要开源你的包
* 一个名为 `README.md` 的文件介绍你的包（也可不用 Markdown）
* 一份[许可证](../knowledge/licenseknowledge.md)

如果需要团队合作，可以参考
- [约定式提交规范（中文）](https://www.conventionalcommits.org/zh-hans/v1.0.0/)
- [经典文：Angular 贡献规范](https://github.com/angular/angular.js/blob/main/CONTRIBUTING.md)
- [Contributor's Guide on Collaborative Practices for Community Packages](https://github.com/SciML/ColPrac)

## 包结构初始化
挑选好你的目标路径后，在包管理器模式下使用 `generate 名称` 生成包的基本框架。

例如 `generate foo` 将在[相对路径](../advanced/filesystem.md#路径) `./foo` 处生成一个目录，包含包的基本结构。
```julia-repl
(@v1.11) pkg> generate foo
  Generating  project foo:
    foo\Project.toml
    foo\src\foo.jl
```

`src/foo.jl` 文件包含一个[模块](../advanced/module.md)的基本结构。

如果还需初始化 Git，可使用 `git init` 命令。

也可以参照：
- [官方提供的包示例](https://github.com/JuliaLang/Example.jl)
- [包模板生成器](https://invenia.github.io/PkgTemplates.jl/stable/)

获得更丰富的模板。

## 包的配置
包的配置数据写在 `Project.toml` 文件中。这个文件使用 [TOML 格式](../knowledge/toml.md)

配置数据中必须含有以下内容：
- `name` 包名，应与模块名一致
- `uuid` 一个独一无二的 UUID，可以使用 [UUIDs](../packages/uuids.md) 生成
- `version` 包的当前[版本](../advanced/versionnumber.md)
- `[deps]` 一个字典，包含 `基于的包名 = "它的 UUID"`，后者可以通过查找对应仓库中填写的 `uuid` 项或其它调用了它的包中的 `[deps]` 项获取
- `[compat]` 一个字典，包含 `包名 = "支持的版本"`，特别地，`julia` 项表示支持的 Julia 版本

此外，还可选择填写 [`extras` 与 `target`](https://discourse.juliacn.com/t/topic/6341/2)

示例的文件内容如下：
```julia-repl
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

## 包的构建
这个功能仅在包比较复杂，需要主动控制包的构建流程时用到。

当包第一次被安装或运行 `build` 命令时，会调用 `deps/build.jl` 中的代码。

若构建失败，提示信息会在终端显示失败的详细信息。

## 包的测试
可参阅：如何编写有效的单元测试？

关于 `test` 命令，可参考 [Test 的使用](../packages/test.md)。

### 手动测试
`add` 命令允许参数是一个本地路径，从而在本地安装包，以模拟包环境。

该路径指向的资源必须是一个 `git` 仓库，且它会读取最近的 `commit` 数据。

Julia 1.9 开始，可以更改 REPL 的环境模块：
```julia-repl
julia> @__MODULE__
Main

# 输入 Base.Math 然后按 Alt+M
(Base.Math) julia> @__MODULE__
Base.Math
```

## 命名规范
* 包名应该对大多数 Julia 用户来说是合理的，甚至对那些不是领域专家的用户也是如此
* 避免使用（信息技术以外的）术语（jargon），特别是首字母缩写，除非混淆的可能性极小
* 名字中不应包含 `Julia`，也不应以 `Ju` 开头
* 若提供某新类型占大部分功能的包，名称应是复数，如 `DataFrames`
* 不应与已有名字太接近，这是为了防止[类似事件](https://blog.rust-lang.org/2022/05/10/malicious-crate-rustdecimal.html)
* 包裹外部库/项目的包应有相同名称 [^1]

## 注册
若需要在 [General](https://github.com/JuliaRegistries/General) 中注册，请登录 juliahub 后在[此](https://juliahub.com/ui/Registrator)输入信息（也可直接在 github issue 中发布 `@JuliaRegistrator register()`）。
可以注册新包或版本更新，但应注意：
1. 不能注册 pre-release
2. 不能跳过版本

[FAQ](https://github.com/JuliaRegistries/General#faq)

## 最佳实践
包应该避免改变自己的状态（写入包目录中的文件）。一般来说，包不应该假定它们位于可写的位置，甚至不应该假定它们位于稳定的位置（例如，如果它被捆绑到一个系统映像中）。为了支持 Julia 包生态系统中的各种用例，Pkg 开发人员创建了许多辅助包和技术，以帮助包作者创建自包含的、不可变的和可重定位的包：

### Artifacts
Julia 1.3 以后，`Artifacts` 可以用于将数据块与包捆绑在一起，甚至允许按需下载它们。优先选择 `Artifacts`，而不是试图通过路径，因为这是不可重定位的：一旦你的包被预编译，`@__DIR__` 的结果将被嵌入到预编译的包数据中，如果你试图分发这个包，它将试图在错误的位置加载文件

### Scratch
Julia 1.5 以后，[Scratch](../packages/scratch.md)提供了*临时空间*的概念，即包的可变数据容器。Scratch空间是为完全由包管理的数据缓存设计的，应该在包本身卸载时删除。对于重要的用户生成的数据，包应该继续写入到一个用户指定的路径，该路径不是由 `Julia` 或 `Pkg` 管理的

### Preferences
Julia 1.6 以后，`Preferences` 允许包读写首选项到顶级的 `Project.toml`。这些首选项可以在运行时或编译时读取，以启用或禁用包行为的不同方面（以前，包会将文件写入到它们自己的包目录中以记录由用户或环境设置的选项，但现在不鼓励该行为）

## 参阅
- [Modern Julia Workflows](https://modernjuliaworkflows.org/)

[^1]: https://juliaregistries.github.io/RegistryCI.jl/stable/guidelines/
