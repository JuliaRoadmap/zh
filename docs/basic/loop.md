# 循环
## while
```jl
while 条件
    语句
end
```

## for
```jl
for 变量 in 范围
    语句
end
```

其中“范围”可以是[数组](vector.md)、[切片](slice.md)、[字典](dict.md)……
```jl
for i in 1:10
    println(i)
end
```

## 其它
可以用`break`跳出循环，`continue`进入下一次循环

## 练习
- LightLearn 3
- [Hydro langs P3](https://hydro.ac/d/langs/p/P3)
