# 遍历
## 内部实现
遍历的定义通过定义 `iterate` 函数的两个[方法](method.md)实现。

在进行 `for ... in` 循环时，
```jl
for item in iter   # 或 "for item = iter"
    # body
end
```

被解释为：[^1]
```jl
next = iterate(iter)
while next !== nothing
    (item, state) = next
    # body
    next = iterate(iter, state)
end
```

## 样例
```jl
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
           print(i, ' ')
       end
5 16 8 4 2 1
julia> [n3(10)...]
6-element Vector{Int64}:
  5
 16
  8
  4
  2
  1
```

[^1]: https://docs.juliacn.com/latest/manual/interfaces
