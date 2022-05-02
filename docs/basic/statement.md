# 条件
!!! note
    如果你没有相关的编程基础，可以尝试画流程图

## if-then
```jl
if 条件
    语句
end
```
`条件(statement)`是一个值或表达式，它的结果必须是`Bool`类型

## if-then-else
```jl
if 条件
    语句1
else
    语句2
end
```

## elseif
你可以将`else`与`if`合并，并并入同一层中
```jl
if 条件
    语句
elseif 条件
    语句
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
Julia 提供了一个函数型的分支方式
```jl
julia> ifelse(true,"a","b")
"a"
```

## switch-case?
Julia 本身不提供`switch case`结构，因为会自动优化[^1]

## 练习
- LightLearn 1
- LightLearn 2
- [Hydro langs P2](https://hydro.ac/d/langs/p/P2)

[^1]: https://discourse.julialang.org/t/is-there-a-select-case-equivalent-in-julia/66516
