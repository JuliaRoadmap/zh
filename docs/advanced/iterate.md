# 遍历
遍历的定义通过定义`iterate`函数的两个方法实现
```jl
struct n3
	v::Int
end

function Base.iterate(i::n3,n::Int=i.v) # 第一次调用时不会有第二个参数
	if n==1
		return nothing # 表示结束
	end
	v= n&1==0 ? n>>1 : n*3+1
	return (v,v) # (返回值,下一个状态（作为第二个参数）)
end

julia> for i in n3(10)
           print(i,' ')
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
