# C调用
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

- [参数传递和命名约定](https://docs.microsoft.com/zh-cn/cpp/cpp/argument-passing-and-naming-conventions)
- [在Windows下编写C/C++ DLL与Julia调用的正确姿势](https://discourse.juliacn.com/t/topic/1657)
