# 环境配置
## 下载
### Julia 版本管理工具
* 如果已有 Python，可以使用 [jill.py 安装脚本](https://cn.julialang.org/downloads/#julia_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85) 
* 官方提供的基于 Rust 的跨平台安装工具 [juliaup](https://github.com/JuliaLang/juliaup)
	* Windows 商店搜索 julia 点击安装 或 打开（命令行） 输入：`winget install julia -s msstore`
	* Mac & Linux curl：`curl -fsSL https://install.julialang.org | sh`
	* Homebrew：`brew install juliaup`
	* [Arch Linux](https://aur.archlinux.org/packages/juliaup)
	* openSUSE：`zypper install juliaup`
	
	使用 juliaup 推荐参考设置环境变量 `JULIAUP_SERVER`
	``` bash
	export JULIAUP_SERVER=https://mirrors.ustc.edu.cn/julia-releases/
	```

### 一次性下载
* 可以在[官网](https://julialang.org/downloads/)根据提示下载
* 可以使用中文社区提供的[下载页面](https://cn.julialang.org/downloads/)
	* [中科大开源软件镜像站](https://mirrors.ustc.edu.cn/julia-releases/) - [镜像使用帮助](https://mirrors.ustc.edu.cn/help/julia.html)
	* [上海交通大学软件源镜像服务](https://mirrors.sjtug.sjtu.edu.cn/julia-releases/) - [镜像使用帮助](https://mirrors.sjtug.sjtu.edu.cn/docs/julia)
	* [清华大学开源软件镜像站](https://mirrors.tuna.tsinghua.edu.cn/help/julia-releases/) - [镜像使用帮助](https://mirrors.tuna.tsinghua.edu.cn/help/julia-releases/)
	* [北京外国语大学开源软件镜像站](https://mirrors.bfsu.edu.cn/help/julia-releases/) - [镜像使用帮助](https://mirrors.bfsu.edu.cn/help/julia-releases/)

### 从源代码构建
请参阅：[源代码进行构建](https://github.com/JuliaLang/julia#building-julia)，不建议新手尝试。

### 说明
通常建议选择最新稳定版本，或者对稳定性有需求可以选择**长期维护版（LTS a.k.a long-time support）**。
* [关于选择的详细信息](https://docs.juliacn.com/v1/manual/faq/#Do-I-want-to-use-the-Stable,-LTS,-or-nightly-version-of-Julia?)
* 对于过程中的细节问题，可以查看官网提供的针对操作系统的下载[帮助](https://julialang.org/downloads/platform/)

## 不下载
如果你不想下载且有恰当的网络环境，可以考虑使用 [JuliaHub](https://juliahub.com/)、[Nextjournal](https://nextjournal.com/)、[Replit](https://replit.com/languages/julia) 等网站，它们自身应有指引，此处不再阐述。

## 简单测试
### 运行
运行 Julia 的可执行文件（可能是菜单中的图标或快捷方式）或是（**[设置好默认路径](https://julialang.org/downloads/platform/)后**）[从命令行运行](../knowledge/cli.md#打开系统命令行) `julia`，可以启动**交互式会话（REPL）**。您或许会看到

```plain
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 版本号 (发布时间)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia>
```

即所谓的“显示一条横幅并提示用户输入”

### 使用
之后您可以
- 选中窗口同时按下 `Ctrl` 与 `D`（这一操作也写作 `CTRL+D`） 或输入 `exit()`、回车 退出交互式会话
- 输入一段完整的代码（如果代码不完整，换行后继续等待输入以续行（Julia 中没有特定的续行标识），连换多个空行表示停止输入代码），例如 `1+2`，按回车，交互式会话就会执行这段代码，并显示结果。（如果输入的代码以分号结尾，那么结果将不会显示出来）
- **在交互式会话中**，不管结果显示与否，`ans` 总会存储上一次执行代码的结果
- 在一段代码运行时，选中窗口并按 `CTRL+C` 可以强制停止运行，这可以用于防止卡死
- 亲测在 Windows 10 中按右键可以黏贴，可以用上下箭头调用历史记录

在 REPL 中，也可以在提示符后为空时输入特定字符进入特定模式
- `?` 进入帮助模式
- `]` 进入包管理模式
- `;` 进入shell模式
- 退格回到普通模式

示例
```julia-repl
julia> 1+2
3

(@v1.6) pkg> gc
      Active manifest files: 1 found
      Active artifact files: 82 found
      Active scratchspaces: 1 found
     Deleted no artifacts, repos, packages or scratchspaces

help?> ans
search: ans transpose transcode contains expanduser instances MathConstants readlines LinearIndices leading_ones

  ans

  A variable referring to the last computed value, automatically set at the interactive prompt.

shell> powershell
Windows PowerShell
版权所有 (C) Microsoft Corporation。保留所有权利。
```

在普通模式中，对于每一次输入的值，REPL 都会进行显示（`display`），可以在末尾添加 `;` 以不进行展示。

### 快捷键
参阅 <https://www.bookstack.cn/read/hyper0x-JuliaBasics/spilt.1.book-ch02.md>

## 命令行选项
如果想非交互式地执行文件中的代码，可以把文件路径作为 Julia 命令的第一个参数，形如 `julia foo.jl`，运行指定的 `foo.jl` 中的代码。
更多功能请参考[命令行选项](https://docs.juliacn.com/latest/manual/command-line-options/#command-line-options)

!!! note
	若你想在打开 REPL 后运行指定文件中的代码，可以使用 `include("文件路径")`

[^1]: https://discourse.juliacn.com/t/topic/159
[^2]: [USTCLUG Mirror 已经停止镜像](https://servers.ustclug.org/2023/07/julia-removal/)
