# LightLearn使用基础
[LightLearn.jl](https://github.com/Rratic/LightLearn.jl)是一个[包](../blog/packages/introduction.md)，可以通过在REPL键入`]add LightLearn`安装。

如果发现无法解决的问题，请在[issue处](https://github.com/Rratic/LightLearn.jl/issues)反馈。

!!! note
	请获取 3.0 及以后的版本

标准流程如下
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
