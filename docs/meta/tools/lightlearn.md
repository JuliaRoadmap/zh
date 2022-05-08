# LightLearn使用基础
使用`]add LightLearn`或
```jl
julia> using Pkg

julia> Pkg.add("LightLearn")
```

进行安装

## 基本操作
导入后使用`about()`，你就会看到

### 流程
```jl
init()		初始化资源
level(name)	打开关卡name
此时可以进行一些测试
submit() do
	你的代码
end
来提交（建议在编辑器上编辑好再复制黏贴）
quit()		退出并保存存档
```

### 辅助工具
```jl
menu()		列出当前所有关卡和描述
vis(false)	关闭窗口
vis(true)	打开窗口
interval	提交时的动画间隔
```

## 关卡导入
```jl
init(false)	初始化时不导入默认关卡
loaddir(s)	导入s处的目录所含数据
```

# 关卡创建
目录下应包含以下文件
1. `setting.toml`，应包含2个键
	* `versions`当前应有`main`对应关卡版本号
	* `chapters`，对于每个章节，提供对应的关卡id数组
2. `main.jl`，返回值应是`Vector{Pair{String,Level}}`，表示关卡id和对应数据的数组
