# 异常处理
在程序出现不应有的错误时，会「抛出(throw)」异常。

你或许已经见过类似的情况了：
```jl
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

这便是 `sqrt` 函数抛出的异常被你的 REPL 内部 `catch` 后，显示给你的信息

## try-catch
经典的异常处理方式是使用 `try-catch` 块：
- `try` 块用于指定接收抛出的代码范围
- `catch i` 会接受 `try` 块中抛出的异常，你可以对它进行处理

可以用`throw(x)`抛出异常，异常可以是任意类型
```jl
try
	foo()
catch i
	if isa(i, DomainError) # 判断i是否是DomainError类型的
		println("发生了定义域错误")
	else
		println("发生了定义域错误以外的错误，交给你了")
		throw(i) # 再次抛出
	end
end
```

也可以使用 `error` 函数，相当于 `throw(ErrorException(...))`。
常用错误类型信息[见此](../advanced/exception.md)

## finally
`try-catch`结构中可以嵌入`finally`，标注无论代码如何结束，都会运行`finally`模块
```jl
try
	foo()
finally
	println("THE END")
end
```

```is-newbie
## 练习
- LightLearn 4
```
