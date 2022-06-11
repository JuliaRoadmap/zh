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

其中“范围”可以是[数组](vector.md)、[范围](range.md)、[字典](dict.md)……
```jl
for i in 1:10
    println(i)
end

for i in 1:3, j in 1:3
    print(i*j,' ')
end
```

## 其它
可以用`break`跳出循环，`continue`进入下一次循环

## 参阅
- [for ... in调用了什么](https://docs.juliacn.com/latest/manual/interfaces/#man-interface-iteration) [遍历](../advanced/iterate.md)

## 练习
- LightLearn 3
- [Hydro langs P3](https://hydro.ac/d/langs/p/P3)
