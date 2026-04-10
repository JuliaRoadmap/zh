# 遍历与迭代器
## 迭代器
`Base.Iterators` 模块提供了一系列为 `for ... in` 准备的、用于更方便地控制遍历的工具。

`eachindex` 通常用于得到数组索引的合适遍历工具。它比使用 `1:length(A)` 兼容性更强，因为 `1:length(A)` 不适用于多维数组、数组 `view` 及其它包可能出现的数组（如索引不从 1 开始的数组）。

```@repl
A = [10 20; 30 40];

for i in eachindex(A)
    println("A[", i, "] == ", A[i])
end
```

使用 `enumerate` 遍历物品时，得到的值是一对 `(i, v)`，其中 `i` 是从 1 开始的计数器，`v` 是正常遍历物品得到的值。

```@repl
a = ["a", "b", "c"];

for (index, balue) in enumerate(a)
    println("a[$index] = $value")
end

for (index, value) in enumerate(a)
    println("a[$index] = $value")
end
```

`zip` 可用于合并多个可遍历的物品，一直遍历直到其中一个到达末尾。
```@repl
z = zip(1:3, "abcde")
length(z)
first(z)
collect(z)
```

`filter` 用于生成满足特定要求的迭代器，需注意在使用时不与导出的另一个 `filter` 混淆
```@repl
f = Iterators.filter(isodd, [1, 2, 3, 4, 5])
collect(f)
```

## 自定义
Julia 允许用户给自定义类型实现迭代方式。

这需要定义 `iterate` 函数的两个[方法](method.md)。

在进行 `for ... in` 循环时，
```julia
for item in iter   # 或 "for item = iter"
    # body
end
```

以上代码被解释为[^1]：
```julia
next = iterate(iter)
while next !== nothing
    (item, state) = next
    # body
    next = iterate(iter, state)
end
```

这是一个自定义的样例：
```@repl
struct n3
    v::Int
end

function Base.iterate(i::n3, n::Int=i.v) # 第一次调用时不会有第二个参数
    if n == 1
        return nothing # 表示结束
    end
    v= n&1==0 ? n>>1 : n*3+1
    return (v, v) # (返回值, 下一个状态)
end

for i in n3(10)
    println(i, ' ')
end

[n3(27)...]
```

[^1]: https://docs.juliacn.com/latest/manual/interfaces
