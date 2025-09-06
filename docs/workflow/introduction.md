# 包的简介
Julia 中第三方库所对应的名称是 package，常称为**包**。

开源的第三方库使我们可以交流成熟的代码。对于使用者，可以借此调用经过别人检查、优化、调试的代码，[避免浪费时间](https://www.zhihu.com/question/407370305)。对于开发者，可以获得他人的建议与帮助。

包被安装后，其内容可以作为[模块](../../advanced/module.md)被调用。

在 REPL 中输入 `]` 可进入**包管理器**模式，此时可以输入命令。

该模式下常用指令包括：
* `help` 获取帮助及命令列表
* `add` 下载包，每天只会自动更新注册表一次
* `build` 手动构建包
* `remove` 移除包
* `update` 只更新指定的包，使用 `--preserve` 命令选项放松限制
* `gc` 回收包
* `preview` 预览
* `why` 告知包为何存在于清单中

基础示例
```julia-repl
(@v1.6) pkg> add LightLearn # 下载包
...
Precompiling project...
  1 dependency successfully precompiled in 7 seconds (173 already precompiled)
julia> using LightLearn # 导入
julia> init() # 使用
```

也可以在程序中使用 `Pkg` 模块进行管理：
```jl
import Pkg
Pkg.add(PackageSpec(name="Example", version="0.3.1"))
```

## 包查找
* [juliahub](https://juliahub.com/lp/)
* [juliaobserver](https://juliaobserver.com/packages)
* [svaksha - 按领域分类的包一览](https://svaksha.github.io/Julia.jl/)

## 包服务器
Julia 1.5 以上会默认使用[官方服务器](https://pkg.julialang.org)。

对于国内用户，官方服务器会自动导向北京、上海或者广州的服务器（[状态在此查看](https://status.julialang.org/)），可以通过修改环境变量 `JULIA_PKG_SERVER` 修改默认服务器。

可参阅 [Julia PkgServer 镜像服务及镜像站索引](https://discourse.juliacn.com/t/topic/2969)。

## 了解指定的包
1. 找到文档
    * 利用 Juliahub 搜索找到原仓库，看是否有提供文档
    * 本站点提供了少量的[中文的包概述](../packages/index.md)
    * 如果该包是一个其它语言的库的接口，原本的库很可能也有文档，并且网上可能找到相关教程
2. 获取 `docstring`
    * 在帮助模式中使用包名
    * 尝试使用 `apropos` 检索
3. 获取结构信息
    * 使用 `?包名.` + `Tab` 列出包中导出所有东西（也可使用 `names(包名)`）
    * 利用 `methods`、`methodsof`、`dump`、`functionloc` 等函数
4. 了解具体实现
    * 尝试阅读源代码
    * 在包所在仓库提问

## Pkg
`Pkg.jl` 是 Julia 标准库的一部分，用于管理包。REPL 中的命令也是通过调用 `Pkg.jl` 的函数实现的。

了解更多内容可参阅：
- [Pkg 文档](https://pkgdocs.julialang.org/v1/)
- [Pkg 文档中文翻译](https://cn.julialang.org/Pkg.jl/dev/)
