# LightLearn使用基础
[LightLearn.jl](https://github.com/Rratic/LightLearn.jl)是一个[包](../blog/packages/introduction.md)，可以通过在REPL键入`]add LightLearn`安装\
如果发现无法解决的问题，请在[issue处](https://github.com/Rratic/LightLearn.jl/issues)反馈

!!! note
	尽量获取2.2及以后的[版本](../../advanced/versionnumber.md)\
	若您是普通使用者，调用`about()`即可

## 使用方式
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
rewind()	重启当前关卡
quit()		退出并保存存档
```

### 辅助工具
```jl
menu()			列出当前所有关卡和描述
vis(false)		关闭窗口
vis(true)		打开窗口
interval		提交时的动画间隔
setinterval(x)	设置动画间隔
```

导入后使用`sandbox()`，你就会看到
```jl
欢迎使用沙盒模式！ 请保留此函数的返回值，假设为`sand`
tp(x,y)		移动到(x,y)处
sand[x,y]	获取(x,y)处的数据
sand[x,y]=v	覆盖(x,y)处的数据
```

### 导出的部分函数
| 原型 | 描述 |
| --- | --- |
| `installzip(url)` | 从指定url下载zip |
| `install(owner,repo,version="latest")` | 从`owner`的github仓库`repo`的发布中下载版本`version`，特别地，`latest`表示下载尽可能的最新版 |
| `about()` | 获取相关信息 |
| `menu()` | 列出当前导入数据中的章节和关卡描述 |
| `level(name)` | 导入关卡名为name的关卡，数字会自动转化为字符串 |
| `rewind()` | 重启当前关卡 |
| `submit(f::Function)` | 提交当前关卡的尝试f |
| `setinterval(x::Float64)` | 设置动画间隔 |
| `init(b::Bool=true)` | 初始化数据，其中`b`控制是否导入标准Package项目 |
| `vis(b::Bool)` | 控制窗口可见性 |
| `quit()` | 退出 |

## 关卡创建
[标准Package项目地址](https://github.com/JuliaRoadmap/Standard.llp)

目录下应包含以下文件
* `Project.toml`，至少应包含
	* `name`当前关卡包名
	* `uuid`一个UUID
	* `version`当前版本
	* `description`介绍
	* `[chapters]`，对于每个章节，提供对应的关卡id数组
	* `[compat]`保留
* `包名.jl`，返回值是一个元组
	* 第一项表示关卡id和对应数据::`Vector{Pair{String,Level}}`
	* 第二项表示build方法，不接受参数

若要支持install方法，应在对应的github仓库发布release，标注恰当的tag（带`v`），在信息中必须含有字段`COMPAT="v版本"`，表示接受的最低LightLearn版本

## 预定义类型
| 名称 | 描述 |
| --- | --- |
| Nothing | 空白 |
| Int | 数字 |
| Solid | 墙 |

## 标准函数
| 名称 | 参数列表（除第一个外） | 描述 |
| --- | --- | --- |
| solid | -> Bool | 是否允许玩家移动到此格 |
| plyenter | | 玩家移动到此格时进行的操作 |
| _look | | 希望·返回给`look`函数的值 |
| _send | ::Val, args... | 传递数据，会被`send`函数调用 |

`show_grid(ctx::DContext, v, x::Int, y::Int)`被调用用于可视化，其中ctx是图像上下文，`(x,y)`是左上角像素坐标
