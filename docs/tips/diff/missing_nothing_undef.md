# missing-nothing-undef的区分
* `missing`一般用于
	* 三值逻辑
	* 在概率统计中，表明这个值是缺失的
* `undef` 用于数组的初始化，如`Array{Float64, 2}(undef, 4, 4)`，表示直接使用分配的内存里原先的数据
* `nothing`一般用于表明
	* 表明该函数没有返回值
	* 某个参数不设定默认值
	```jl
	function f(A; r=nothing)
    	r = isnothing(r) ? size(r) .÷ 2 : r
    	...
	end
	```
	基本类似于`f(A; r=size(r).÷ 2) = ...`但在一些场景下确实是有用的，比如说需要处理更复杂的可选值的逻辑，甚至在某些情况下抛出一些 `@warn` 或 `error` 的话，那么放在函数签名里去做就显得太冗长和复杂了。

`nothing`和`missing`具体的处理取决于工具箱内部的实现

[^1]: https://discourse.juliacn.com/t/topic/6282/3
