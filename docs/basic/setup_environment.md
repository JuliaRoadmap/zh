# 环境配置
!!! tips
	如果你不想下载且有恰当的网络环境，可以考虑使用[juliabox](https://discourse.juliacn.com/t/topic/196)

## 下载
* 可以在[官网](https://julialang.org/downloads/)根据提示下载
* 可以使用[中文社区](https://discourse.juliacn.com/)提供的[下载页面](https://cn.julialang.org/downloads/)
* 如果你已有 `python`，可以使用[jill.py 安装脚本](https://github.com/johnnychen94/jill.py)
* 如果你是大佬且闲得慌，可以在本地从[源代码进行构建](https://github.com/JuliaLang/julia#building-julia)
* 基于`rust`的跨平台安装工具[juliaup](https://github.com/JuliaLang/juliaup)
	* windows商店（命令行）：`winget install julia -s msstore`
	* Mac & Linux curl `curl -fsSL https://install.julialang.org | sh`
	* Homebrew `brew install juliaup`
	* [Arch Linux](https://aur.archlinux.org/packages/juliaup)
	* openSUSE `zypper install juliaup`

通常建议选择最新稳定版本，或者对稳定性有需求可以选择`长期维护版(LTS)`\
官网提供的针对操作系统的下载[帮助](https://julialang.org/downloads/platform/)

## 简单测试
运行 Julia 的可执行文件或是（**设置好默认路径后**）从命令行运行`julia`，可以启动`交互式会话(REPL)`。你或许会看到

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

- 输入 `CTRL+D` 或 `exit()` 便可以退出交互式会话
- 在交互式模式中，julia 会显示一条横幅并提示用户输入。一旦用户输入了一段完整的代码（如果代码不完整，换行后继续等待输入以续行（Julia没有特定的续行标识）），例如`1+2`，按回车，交互式会话就会执行这段代码，并显示结果。（如果输入的代码以分号结尾，那么结果将不会显示出来）
- **在交互式会话中**，不管结果显示与否，`ans`总会存储上一次执行代码的结果

如果想非交互式地执行文件中的代码，可以把文件名作为 julia 命令的第一个参数，形如`julia foo.jl`

在REPL中，你也可以输入
- `?`进入帮助模式
- `]`进入包管理模式
- `;`进入shell模式
- 退格回到普通模式（亲测在普通模式按退格会闪烁）
- 亲测在win10中按右键可以黏贴，可以用上下箭头调用历史记录

示例
```jl
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

## 命令行选项
最常用的功能是`julia 文件路径`运行指定文件中的代码\
更多功能请参考[命令行选项](https://docs.juliacn.com/latest/manual/command-line-options/#command-line-options)

!!! note
	若你想在打开REPL后运行指定文件中的代码，可以使用`include("文件路径")`

[^1]: https://discourse.juliacn.com/t/topic/159
