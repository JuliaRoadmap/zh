# LightLearn的使用
[LightLearn.jl](https://github.com/Rratic/LightLearn.jl)是一个[包](../blog/packages/introduction.md)，它开发的初衷即是服务于本文档，通过类似游戏的方式帮助学习和/或增强程序设计能力。

你可以通过在 REPL 键入 `]add LightLearn` 安装。为了与文档描述一致，建议检查版本为 3.0 及以上（在普通模式下使用 `]st LightLearn`，或仍在包模式下使用 `st LightLearn`）。

如果发现自己无法解决的问题，请在[issue处](https://github.com/Rratic/LightLearn.jl/issues)反馈。

作者希望的标准流程如下
```jl
julia> using LightLearn
[ Info: Precompiling LightLearn [aea05ee4-eee8-4bb2-9be1-ccb376bfd141]

julia> st=init()
[ Info: ...\scratchspaces\...\llp\Standard
LightLearn


julia> menu(st)
1       简介
2       条件的使用
3       循环的使用
4       异常处理
5       函数定义
6       数组使用

julia> level(st, 1)
 # 信息

 建议阅读原仓库的 README 以了解详细信息

 提交的基本格式是

   │ submit(st) do st
   │    # ...
   │ end

 你可以在 do ... end 间使用函数 north!，west!，east!，south!

 # 目标

 移动到旗帜处

 # 示例

   │ submit() do st
   │    south!(st); south!(st); south!(st)
   │    east!(st); east!(st); east!(st)
   │ end

 ┌ Note ───────────────────────────────────────────────────────────────────────
 │ 窗口会进行延时动画演示
 └─────────────────────────────────────────────────────────────────────────────

julia> submit(st) do st
           south!(st); south!(st); south!(st)
           east!(st); east!(st); east!(st)
       end
通过

julia> quit(st)
```

建议阅读 README 以获取详细信息
