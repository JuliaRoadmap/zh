# C调用
可以使用`ccall`或`@ccall`调用C导出的库
!!! note
	调用时常常使用`C`开头的类型名称，也会用到[引用相关知识](ref.md)

## ccall
原型是`ccall((function_name, library), returntype, (argtype1, ...), argvalue1, ...)`或`ccall(function_name, returntype, (argtype1, ...), argvalue1, ...)`或`ccall(function_pointer, returntype, (argtype1, ...), argvalue1, ...)`，其中library是库的路径；每个`argvalue`会通过`unsafe_convert(argtype, cconvert(argtype, argvalue))`转化为`argtype`类型实例\
调用C标准库的示例（需注意，这些函数大多在`Libc`模块中已有，无需自己ccall）
```jl
julia> ccall(:srand,Cvoid,(Cint,),0)

julia> ccall(:rand,Cint,())
38
```

一个调用[windows api](https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getcursorpos)获取鼠标指针位置的示例：
```jl
mutable struct Point
	x::Clong
	y::Clong
end

julia> pt=Point(0,0)
Point(0, 0)

julia> ccall((:GetCursorPos,"User32.dll"),stdcall,Cint,(Ptr{Cvoid},),Ref(pt))
1

julia> pt
Point(681, 404)
```

## @ccall
原型是`@ccall library.function_name(argvalue1::argtype1, ...)::returntype`或`@ccall function_name(argvalue1::argtype1, ...)::returntype`或`@ccall $function_pointer(argvalue1::argtype1, ...)::returntype`
```jl
julia> @ccall srand(0::Cint)::Cvoid

julia> @ccall rand()::Cint
38
```

## 参阅
- [参数传递和命名约定](https://docs.microsoft.com/zh-cn/cpp/cpp/argument-passing-and-naming-conventions)
- [在Windows下编写C/C++ DLL与Julia调用的正确姿势](https://discourse.juliacn.com/t/topic/1657)
