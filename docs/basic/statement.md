# 条件
!!! note
    如果你没有相关的编程基础，可以尝试画流程图

## if-then
```jl
if 条件
	若条件为真时执行
end
```
`条件(statement)`是一个值或表达式，它的结果必须是`Bool`类型

## if-then-else
```jl
if 条件
    若条件为真时执行
else
    若条件为假时执行
end
```

## elseif
你可以将`else`与`if`合并，并并入同一层中
```jl
if 条件1
    若条件1为真时执行
elseif 条件2
    若条件2为真时执行
end
```

## 三目运算符
`表达式 ? 真时执行 : 假时执行`\
由于Julia 的续行规则，你可以写出如下的代码
```jl
d=v=="Mon" ? 1 :
v=="Tue" ? 2 :
v=="Wed" ? 3 :
v=="Thur" ? 4 :
v=="Fri" ? 5 :
v=="Sat" ? 6 : 7
```

## 函数包裹
Julia 提供了一个函数型的分支方式，它的不同点在于不会短路
```jl
julia> ifelse(true,"a","b")
"a"
```

## switch-case?
Julia 本身不提供`switch case`结构，因为会自动优化[^1]
!!! note
    CPU可能进行分支预测[^2]

```is-newbie
## 练习
- LightLearn 1
- LightLearn 2
- [Hydro langs P2. if-else](https://hydro.ac/d/langs/p/P2)
```

[^1]: https://discourse.julialang.org/t/is-there-a-select-case-equivalent-in-julia/66516
[^2]: https://www.luogu.com.cn/blog/zhaojinxi/qian-tan-di-ceng-chang-shu-you-hua-ji-CPU-you-hua
