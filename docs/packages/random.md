# Random
`Random` 提供了一些随机数相关的基本物品

## 生成器
- `AbstractRNG` 是随机数生成器的抽象类型
- `MersenneTwister(seed)` 生成一个梅森旋转随机数生成器，`seed` 可以是非负整数或 `Vector{UInt32}`
- `RandomDevice()` 是操作系统提供的随机数生成器

## rand
`rand([rng=GLOBAL_RNG],[S],[dims...])` 使用生成器 `rng`，从 `S` 中选择随机元素，使用维度参数 `dims...`，其中 S 可以是： 
- 可索引集合
- 抽象字典/集合类型
- 字符串
- 存在 `typemin` 和 `typemax` 的类型（默认 `Float64`）
- 元组（1.1及以后）

有一些非基本的随机数生成函数
- `randn([rng=GLOBAL_RNG],[T=Float64],[dims...])` 生成 T 类型的均匀分布随机数（平均数 0，标准差 1）
- `randperm([rng=GLOBAL_RNG,] n::Integer)` 生成长度为 n 的**排列（permutation）**
- `randcycle([rng=GLOBAL_RNG,] n::Integer)` 生成长度为 n 的**循环排列（cyclic permutation）**
- `randexp([rng=GLOBAL_RNG], [T=Float64], [dims...])` 生成维度参数为 `dims...` 的符合幂分布（尺度为 1）的分布
- `randsubseq([rng=GLOBAL_RNG,] A, p) -> Vector` 生成指定数组的随机子序列

!!! note
	以上函数都有对应的加 `!` 版本

## 其它工具
`randstring([rng=GLOBAL_RNG], [chars], [len=8])` 可生成长度为 `len` 的随机字符串。
`shuffle` 和 `shuffle!` 可以打乱数组
