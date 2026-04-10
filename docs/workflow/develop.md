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

### PkgTemplates.jl
[PkgTemplates.jl](https://github.com/JuliaCI/PkgTemplates.jl) 可以自动化完成创建包时的常见配置，生成比 `generate` 更丰富的项目框架（包含 `.gitignore`、`LICENSE`、GitHub Actions 工作流等）。[^2]

```julia-repl
julia> using PkgTemplates
julia> t = Template(user="myuser", interactive=false)
julia> t("MyAwesomePackage")
```

之后将生成的目录推送到 GitHub 仓库即可。[PackageMaker.jl](https://github.com/Eben60/PackageMaker.jl) 提供了 PkgTemplates.jl 的图形化封装，操作更加便捷。

也可以参照：
- [官方提供的包示例](https://github.com/JuliaLang/Example.jl)
- [包模板生成器文档](https://juliaci.github.io/PkgTemplates.jl/stable/)

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

## GitHub Actions 与 CI
[PkgTemplates.jl](https://github.com/JuliaCI/PkgTemplates.jl) 会在 `.github/workflows/` 目录下自动生成 [GitHub Actions](https://docs.github.com/en/actions/quickstart) 工作流文件（YAML 格式）。其中 `CI.yml` 会在每次 pull request、tag 或推送到 `main` 分支时自动运行测试。对于公开仓库，GitHub 提供免费的无限工作流配额。[^2]

还可以通过 PkgTemplates.jl 的[插件](https://juliaci.github.io/PkgTemplates.jl/stable/user/#Plugins-1)启用更多功能，如文档构建、代码覆盖率统计、格式化检查等。使用 `Template(..., interactive=true)` 可在交互模式下选择所需插件。

## 代码风格
为使代码易于阅读，建议遵循统一的代码风格规范。官方[风格指南](https://docs.julialang.org/en/v1/manual/style-guide/)比较简短，大多数人会使用第三方规范，如 [BlueStyle](https://github.com/JuliaDiff/BlueStyle) 或 [SciMLStyle](https://github.com/SciML/SciMLStyle)。[^2]

[JuliaFormatter.jl](https://github.com/domluna/JuliaFormatter.jl) 是 Julia 文件的自动格式化工具。在仓库根目录添加 `.JuliaFormatter.toml` 文件并指定风格，然后调用：

```julia-repl
julia> using JuliaFormatter
julia> JuliaFormatter.format(MyAwesomePackage)
true
```

VSCode 的默认格式化功能即基于 JuliaFormatter.jl 实现。也可通过 [julia-format action](https://github.com/julia-actions/julia-format) 在 GitHub pull request 中自动格式化代码。

## 代码质量
除格式之外，还有更多维度的代码质量检查工具。[^2]

[Aqua.jl](https://github.com/JuliaTesting/Aqua.jl) 提供一系列自动检查，涵盖未使用的依赖、方法二义性等问题，建议在测试中包含：

```julia-repl
julia> using Aqua, MyAwesomePackage
julia> Aqua.test_all(MyAwesomePackage)
```

[JET.jl](https://github.com/aviatesk/JET.jl) 是一个静态分析工具，通过类型推断在不运行代码的情况下检测错误和潜在问题，提供错误分析和优化分析两种模式：

```julia-repl
julia> using JET, MyAwesomePackage
julia> JET.test_package(MyAwesomePackage)
Test Passed
```

[ExplicitImports.jl](https://github.com/ericphanson/ExplicitImports.jl) 帮助消除泛化导入，明确每个名称的来源，增强代码对依赖项名称冲突的鲁棒性。

## 版本兼容性
Julia 社区采用[语义化版本控制](https://semver.org/)，每个包必须在 `Project.toml` 的 `[compat]` 节中指定依赖的版本兼容范围。可使用 REPL 中的 `]compat` 命令或 [PackageCompatUI.jl](https://github.com/GunnarFarneback/PackageCompatUI.jl) 来初始化这些范围。[^2]

随着依赖包发布新版本，[CompatHelper.jl](https://github.com/JuliaRegistries/CompatHelper.jl) GitHub Action 会自动监控并提交 PR 更新 `Project.toml`。[Dependabot](https://docs.github.com/en/code-security/dependabot) 则可监控 GitHub Actions 本身的依赖更新。两者均是 PkgTemplates.jl 的默认插件。

## 可重现性
获得一致且可重现的实验结果对科学研究至关重要。[DrWatson.jl](https://github.com/JuliaDynamics/DrWatson.jl) 是一个通用的实验管理工具箱，提供规范化运行和复现实验的功能。[^2]

其他常用工具：
- [StableRNGs.jl](https://github.com/JuliaRandom/StableRNGs.jl)：确保随机数流在不同 Julia 版本之间保持一致
- [DataDeps.jl](https://github.com/oxinabox/DataDeps.jl)、[DataToolkit.jl](https://github.com/tecosaur/DataToolkit.jl)：管理非代码资产（数据集等）的下载与绑定
- [PkgCite.jl](https://github.com/SebastianM-C/PkgCite.jl)：生成依赖包的学术引用信息
- [Zenodo](https://zenodo.org/)：为包分配 DOI，便于学术引用

## 互操作性
[Compat.jl](https://github.com/JuliaLang/Compat.jl) 是保证与旧版 Julia 兼容的最佳工具。[^2]

Julia 1.9 起支持[包扩展（Package Extensions）](https://pkgdocs.julialang.org/v1/creating-packages/#Conditional-loading-of-code-in-packages-(Extensions))，可根据环境中是否存在特定包来覆盖特定行为，实现包之间的互操作。[PackageExtensionTools.jl](https://github.com/cjdoris/PackageExtensionTools.jl) 简化了扩展的设置流程。

Julia 生态系统也与其他编程语言良好协作：
- C 和 Fortran：Julia 原生支持
- Python：[CondaPkg.jl](https://github.com/cjdoris/CondaPkg.jl) + [PythonCall.jl](https://github.com/cjdoris/PythonCall.jl) 组合
- R：[RCall.jl](https://github.com/JuliaInterop/RCall.jl)

更多语言互操作包可在 [JuliaInterop](https://github.com/JuliaInterop) 组织中找到。

## 协作规范
包规模增大后可能需要团队合作。[SciML ColPrac](https://github.com/SciML/ColPrac) 提供了一套被广泛采用的协作规范。同时，如果你喜欢某个 Julia 包，也非常欢迎通过提交 issue 或 pull request 来[参与贡献](https://julialang.org/contribute/)。[^2]

## 最佳实践
包应该避免改变自己的状态（写入包目录中的文件）。一般来说，包不应该假定它们位于可写的位置，甚至不应该假定它们位于稳定的位置（例如，如果它被捆绑到一个系统映像中）。为了支持 Julia 包生态系统中的各种用例，Pkg 开发人员创建了许多辅助包和技术，以帮助包作者创建自包含的、不可变的和可重定位的包：

### Artifacts
Julia 1.3 以后，`Artifacts` 可以用于将数据块与包捆绑在一起，甚至允许按需下载它们。优先选择 `Artifacts`，而不是试图通过路径，因为这是不可重定位的：一旦你的包被预编译，`@__DIR__` 的结果将被嵌入到预编译的包数据中，如果你试图分发这个包，它将试图在错误的位置加载文件

### Scratch
Julia 1.5 以后，[Scratch](../packages/scratch.md)提供了*临时空间*的概念，即包的可变数据容器。Scratch空间是为完全由包管理的数据缓存设计的，应该在包本身卸载时删除。对于重要的用户生成的数据，包应该继续写入到一个用户指定的路径，该路径不是由 `Julia` 或 `Pkg` 管理的

### Preferences
Julia 1.6 以后，`Preferences` 允许包读写首选项到顶级的 `Project.toml`。这些首选项可以在运行时或编译时读取，以启用或禁用包行为的不同方面（以前，包会将文件写入到它们自己的包目录中以记录由用户或环境设置的选项，但现在不鼓励该行为）

[^1]: https://juliaregistries.github.io/RegistryCI.jl/stable/guidelines/
[^2]: [Modern Julia Workflows - Sharing your code](https://modernjuliaworkflows.org/sharing/) by G. Dalle, J. Smit, A. Hill（CC BY-SA 4.0）
