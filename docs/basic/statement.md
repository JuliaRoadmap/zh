# 条件
```is-newbie
「条件-分支结构」是一种常见的结构：用于表示形如“在某条件下执行某代码”的情况。

你可以尝试举些例子、画流程图方便理解。
```

## if-then
```jl
if 条件
	若条件为真时执行
end
```
「条件（statement）」是一个表达式，它的值必须是 `Bool` 类型的实例，这保证了语义，而与一些允许条件为整数的语言不同。

## if-then-else
```jl
if 条件
    若条件为真时执行
else
    若条件为假时执行
end
```

## elseif
你可以将 `else` 与 `if` 合并，并并入同一层中
```jl
if 条件1
    若条件1为真时执行
elseif 条件2
    若条件2为真时执行
end
```

## 三目运算符
语法是 `表达式 ? 真时执行 : 假时执行`。

由于Julia 的续行规则，你可以写出如下的美观代码：
```jl
d = v=="Mon" ? 1 :
    v=="Tue" ? 2 :
    v=="Wed" ? 3 :
    v=="Thur" ? 4 :
    v=="Fri" ? 5 :
    v=="Sat" ? 6 : 7
```

## 函数包裹
Julia 提供了一个函数型的分支方式，它的不同点在于不会短路
```jl
julia> ifelse(true, "a", "b")
"a"

julia> f()=print('^'); ifelse(true, f(), f())
^^
```

!!! note
    由于它本身是函数，因此比较前会对每个参数求值

## switch-case?
Julia 本身不提供形如 `switch/select-case` 的结构，因为会自动优化。[^1]

!!! note
    CPU可能进行会分支预测 [^2]

```is-newbie
## 练习
- LightLearn Standard 简介
- LightLearn Standard 条件的使用
- [Hydro langs P2. if-else](https://hydro.ac/d/langs/p/P2)
- 只通过条件-分支结构，写代码找出数 a、b、c 的最小值
```

[^1]: https://discourse.julialang.org/t/is-there-a-select-case-equivalent-in-julia/66516
[^2]: https://www.luogu.com.cn/blog/zhaojinxi/qian-tan-di-ceng-chang-shu-you-hua-ji-CPU-you-hua
