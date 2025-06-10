# 异常处理
在程序出现不应有的错误时，会**抛出（throw）**异常。

数学错误是典型的异常：
```julia-repl
julia> sqrt(-1)
ERROR: DomainError with -1.0:
sqrt will only return a complex result if called with a complex argument. Try sqrt(Complex(x)).
Stacktrace:
 [1] throw_complex_domainerror(f::Symbol, x::Float64)
   @ Base.Math .\math.jl:33
 [2] sqrt
   @ .\math.jl:582 [inlined]
 [3] sqrt(x::Int64)
   @ Base.Math .\math.jl:608
 [4] top-level scope
   @ REPL[16]:1
```

这便是 `sqrt` 函数抛出的异常被你的 REPL 内部抓取后，显示给你的信息。`ERROR` 之后的内容称述了异常的说明与建议，`Stacktrace` 之后的内容追踪了异常来自于哪个函数，及层层调用的关系。

`Stacktrace` 给出的信息不总是能帮助你直接定位，此时，你可以临时添加一些输出（如在关键代码附近加入 `println("flag")`）或使用调试工具。

## try-catch
经典的异常处理方式是使用 `try-catch` 块：
- `try` 块用于指定接收抛出的代码范围
- `catch i` 会接受 `try` 块中抛出的异常，你可以对它进行自由的处理

可以用 `throw(x)` 抛出异常，异常可以是任意类型
```jl
try
	foo()
catch i
	if isa(i, DomainError) # 判断 i 是否是 DomainError 类型的
		# .
		@error "发生了定义域错误" i
	else
		println("发生了定义域错误以外的错误，交给你了")
		throw(i) # 再次抛出
	end
end
```

也可以使用 `error(x)` 函数，相当于 `throw(ErrorException(x))`。
常用错误类型信息[见此](../advanced/exception.md)

## finally
`try-catch` 结构中可以嵌入 `finally`，标注无论代码如何结束，都会运行 `finally` 中的代码块
```jl
io = open("1.txt", "w")
try
	foo(io)
finally
	close(io)
end
```
