# 注释
注释通常是一种解释性文本，不会被解释器运行\
打开你的[REPL](setup_environment.md#简单测试)，然后尝试以下操作
```jl
julia> # 以 '#' 开头的是单行注释

julia> #= 多行注释
       你可以在这里写任何东西，只要不是连起来的 = #
	   任何东西。
       =#

julia> # 如果你发现除了新的一行什么都没显示，说明你做对了
```

!!! tips
	如果你有一段代码暂时不用，但觉得以后可能用到/扔了可惜，可以把它用多行注释注释掉
