# 遍历与迭代器
## 迭代器
`Base.Iterators` 模块提供了一类为 `for ... in` 准备的，用于更方便控制遍历的工具。

`eachindex` 通常用于得到数组索引的合适遍历工具。它比使用 `1:length(A)` 兼容性更强，因为 `1:length(A)` 不适用于多维数组、数组 `view` 及其它包可能出现的数组（如索引不从 1 开始的数组）。

```julia-repl
julia> A = [10 20; 30 40];

julia> for i in eachindex(A)
           println("A[", i, "] == ", A[i])
       end
A[1] == 10
A[2] == 30
A[3] == 20
A[4] == 40
```

使用 `enumerate` 遍历物品时，得到的值是一对 `(i, v)`，其中 `i` 是从 1 开始的计数器，`v` 是正常遍历物品得到的值。

```julia-repl
julia> a = ["a", "b", "c"];

julia> for (index, balue) in enumerate(a)
           println("a[$index] = $value")
       end
ERROR: UndefVarError: `value` not defined in `Main`
Suggestion: check for spelling errors or missing imports.
Stacktrace:
 [1] top-level scope
   @ .\REPL[30]:2

julia> for (index, value) in enumerate(a)
           println("a[$index] = $value")
       end
a[1] = a
a[2] = b
a[3] = c
```

`zip` 可用于合并多个可遍历的物品，一直遍历直到其中一个到达末尾。
```julia-repl
julia> z = zip(1:3, "abcde")
zip(1:3, "abcde")

julia> length(z)
3

julia> first(z)
(1, 'a')

julia> collect(z)
3-element Vector{Tuple{Int64, Char}}:
 (1, 'a')
 (2, 'b')
 (3, 'c')
```

`filter` 用于生成满足特定要求的迭代器，需注意在使用时不与导出的另一个 `filter` 混淆
```julia-repl
julia> f = Iterators.filter(isodd, [1, 2, 3, 4, 5])
Base.Iterators.Filter{typeof(isodd), Vector{Int64}}(isodd, [1, 2, 3, 4, 5])

julia> collect(f)
3-element Vector{Int64}:
 1
 3
 5
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
```julia
struct n3
	v::Int
end

function Base.iterate(i::n3, n::Int=i.v) # 第一次调用时不会有第二个参数
	if n==1
		return nothing # 表示结束
	end
	v= n&1==0 ? n>>1 : n*3+1
	return (v, v) # (返回值,下一个状态（作为第二个参数）)
end

julia> for i in n3(10)
           println(i, ' ')
       end
5
16
8
4
2
1

julia> [n3(27)...]
111-element Vector{Int64}:
  82
  41
 124
  62
  31
  94
  47
 142
  71
 214
 107
 322
 161
   ⋮
  53
 160
  80
  40
  20
  10
   5
  16
   8
   4
   2
   1
```

[^1]: https://docs.juliacn.com/latest/manual/interfaces
