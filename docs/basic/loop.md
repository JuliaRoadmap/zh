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
在循环代码中，可以使用 `break` 跳出（单层）循环，
可以使用 `continue` 直接进入下一次循环（仍会进行条件判定）

## 参阅
- [for ... in调用了什么](https://docs.juliacn.com/latest/manual/interfaces/#man-interface-iteration)
- [语法进阶 - 遍历](../advanced/iterate.md)

```is-newbie
## 练习
- LightLearn 3
- [Hydro langs P3. loop](https://hydro.ac/d/langs/p/P3)
- [Hydro H1037. 哥德巴赫猜想](https://hydro.ac/p/H1037)
- [Hydro H1032. 【模板】快速幂](https://hydro.ac/p/H1032) （可以不用递归，困难，有题解）
```
