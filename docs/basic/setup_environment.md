# Julia 环境配置
## 获取途径
### Julia 版本管理工具
* 如果已有 Python，可以使用 [jill.py 安装脚本](https://cn.julialang.org/downloads/#julia_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85) 
* 官方提供的基于 Rust 的跨平台安装工具 [juliaup](https://github.com/JuliaLang/juliaup) , 推荐先设置环境变量 `JULIAUP_SERVER`
	``` bash
 	# Linux / MacOS
	export JULIAUP_SERVER=https://mirrors.cernet.edu.cn/julia-releases/
 	export JULIA_PKG_SERVER=https://mirrors.cernet.edu.cn/julia
	```
	
	``` powershell
	#  Windows powershell
	[System.Environment]::SetEnvironmentVariable('JULIAUP_SERVER','https://mirrors.cernet.edu.cn/julia-releases/',[System.EnvironmentVariableTarget]::User)
	[System.Environment]::SetEnvironmentVariable('JULIA_PKG_SERVER','https://mirrors.cernet.edu.cn/julia',[System.EnvironmentVariableTarget]::User)
	```
	* Windows：商店搜索 `julia` 点击安装 或 使用命令行输入 `winget install julia -s msstore`
	* Mac & Linux curl：`curl -fsSL https://install.julialang.org | sh`
	* Homebrew：`brew install juliaup`
	* [Arch Linux](https://aur.archlinux.org/packages/juliaup)
	* openSUSE：`zypper install juliaup`

### 一次性下载
* 可以在[官网](https://julialang.org/downloads/)根据提示下载
* 可以使用中文社区提供的[下载页面](https://cn.julialang.org/downloads/)
	* [中科大开源软件镜像站](https://mirrors.ustc.edu.cn/julia-releases/) - [镜像使用帮助](https://mirrors.ustc.edu.cn/help/julia.html)
	* [上海交通大学软件源镜像服务](https://mirrors.sjtug.sjtu.edu.cn/julia-releases/) - [镜像使用帮助](https://mirrors.sjtug.sjtu.edu.cn/docs/julia)
	* [清华大学开源软件镜像站](https://mirrors.tuna.tsinghua.edu.cn/help/julia-releases/) - [镜像使用帮助](https://mirrors.tuna.tsinghua.edu.cn/help/julia-releases/)
	* [北京外国语大学开源软件镜像站](https://mirrors.bfsu.edu.cn/help/julia-releases/) - [镜像使用帮助](https://mirrors.bfsu.edu.cn/help/julia-releases/)

### 从源代码构建
请参阅：[源代码进行构建](https://github.com/JuliaLang/julia#building-julia)，不建议新手尝试。

### 不下载
如果你不想下载且有恰当的网络环境，可以考虑使用 [JuliaHub](https://juliahub.com/)、[Nextjournal](https://nextjournal.com/)、[Replit](https://replit.com/languages/julia)、[glot](https://glot.io/new/julia) 等网站在线运行 Julia

!!! tips
	一般地，可以搜索 `julia playground` 寻找可用的在线平台。

## 说明
### 版本选择
通常建议选择最新稳定版本，或者对稳定性有需求可以选择**长期维护版**（long-time support）。
* [关于选择：选择 Stable 还是 LTS 还是 nightly](https://docs.juliacn.com/v1/manual/faq/#Do-I-want-to-use-the-Stable,-LTS,-or-nightly-version-of-Julia?)

### 设置默认路径
* 可以参考[官方二进制下载的各平台指导](https://julialang.org/downloads/platform/)中 `Adding Julia to PATH` 一节。
* 如果安装程序有 `Add Julia to PATH` 选项可以勾选，请勾选

### 其它
* [官方二进制下载的各平台指导](https://julialang.org/downloads/platform/)

## 试用
### 运行 REPL
有以下几种可选的运行方式
* **设置默认路径**后[从命令行运行](../knowledge/cli.md#打开系统命令行) `julia`
* 运行 Julia 的可执行文件
* 运行 Julia 的可执行文件对应的快捷方式

这将启动一个**交互式会话**（REPL，read-eval-print loop）窗口，并显示一条横幅

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

此时就可以在光标闪烁处输入内容。

### 使用 REPL
输入的内容可以是一段完整的代码。例如输入 `1+2` 并按回车（`Enter`），交互式会话就会执行这段代码，并显示结果。
* 如果输入的代码以分号结尾，那么结果将不会显示出来，你将在之后读到[显示的本质](../advanced/typesystem.md#自定义显示)及[分号的含义](../basic/little_types.md#无)
* 如果输入的代码不完整，换行后 REPL 会继续等待输入以连接之前的代码（Julia 中没有特定的续行标识）
* 连换多个空行表示停止输入代码

```julia-repl
julia> 1+2
3

julia> 3
3

julia> 3;

julia> sqrt(2)
1.4142135623730951

julia> begin
           a = 1
           a + 2
       end
3
```

**交互式会话**包含如下特性：
- （选中窗口时）同时按下 `Ctrl` 与 `D`（这一操作也写作 `CTRL+D`）或 输入 `exit()` 并回车，将退出交互式会话。
- 不管结果显示与否，`ans` 总会存储上一次执行代码的结果
- （选中窗口时）在一段代码运行时，按 `CTRL+C` 可以强制停止运行，这可以用于防止卡死
- 按鼠标右键可以黏贴
- 使用上下箭头可以调用历史记录
- 使用 `Tab` 可以自动补全
- 其它快捷键可参阅 <https://www.bookstack.cn/read/hyper0x-JuliaBasics/spilt.1.book-ch02.md>

此外，可以在普通模式下，提示符后内容为空时输入特定字符进入特定模式：

按 `?` 进入帮助模式。

```julia-repl
help?> ans
search: ans abs as any nand any! tand axes rand abs2 tanh acsc ones acos

  ans

  A variable referring to the last computed value, automatically imported to the interactive prompt.
```

按 `]` 进入包管理模式（[什么是包？](../workflow/introduction.md)）。

```julia-repl
(@v1.11) pkg> gc
      Active manifest files: 0 found
      Active artifact files: 0 found
      Active scratchspaces: 0 found
     Deleted no artifacts, repos, packages or scratchspaces
```

按 `;` 进入 shell 模式

```julia-repl
shell> powershell
Windows PowerShell
版权所有 (C) Microsoft Corporation。保留所有权利。

尝试新的跨平台 PowerShell https://aka.ms/pscore6

PS C:\Users\username>
```

在上述模式下按退格（`Backspace`）回到普通模式。

### 运行文件
如果想非交互式地执行文件中的代码，可以把文件路径作为 Julia 命令的第一个参数，形如 `julia foo.jl`，运行指定的 `foo.jl` 中的代码。

更多功能请参考[命令行选项](https://docs.juliacn.com/latest/manual/command-line-options/#command-line-options)

如果你想在打开 REPL 后运行指定文件中的代码，可以使用 `include("文件路径")`，更多在[此](../basic/misc.md#加载代码)阅读。

[^1]: https://discourse.juliacn.com/t/topic/159
[^2]: [USTCLUG Mirror 已经停止镜像](https://servers.ustclug.org/2023/07/julia-removal/)
