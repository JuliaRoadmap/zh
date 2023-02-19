# 循环
```check newbie
循环用于在指定条件下重复执行指定代码。
同样地，你也可以尝试举些例子、画流程图方便理解。
```

## while
```jl
while 条件
    语句
end
```

``````check newbie
为了让你更深刻地了解循环是什么，可以尝试以下代码：
```jl
while true
    print("+")
end
```

没错，它会“刷屏”，开一个新窗口运行它。

可以再尝试：
```jl
escape = false
while !escape
    print("echo> ")
    s = readline()
    if s=="quit"
        escape = true
    else
        println(s)
    end
end
```

会得到如下的结果
```plain
echo> 1
1
echo> 2
2
echo> 3
3
echo> quit
```

每次输入一行字符串，只有当它是 `quit` 时才结束。
``````

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
    print(i*j, ' ')
end

for (i, j) in [(1, 2), (3, 4)]
    print(i*j, ' ')
end
```

## 其它
在循环代码中，可以使用 `break` 跳出（单层）循环，
可以使用 `continue` 直接进入下一次循环（仍会进行条件判定）

## 参阅
- [for ... in 调用了什么](https://docs.juliacn.com/latest/manual/interfaces/#man-interface-iteration)
- [语法进阶 - 遍历](../advanced/iterate.md)

```check newbie
## 练习
- [Hydro langs P3. loop](https://hydro.ac/d/langs/p/P3)
- 上题的加强：同样是“星号金字塔”，
    1. n 行，依次 $n, n-1, \cdots ,1$ 个
    2. 2n-1 行，依次 $1, 2, \cdots ,n, n-1, \cdots ,1$ 个
    3. n 行，第 i 行先有 n-i 个空格，再有 i 个 `*`
- LightLearn Standard 循环的使用
- [Hydro H1037. 哥德巴赫猜想](https://hydro.ac/p/H1037)
- [Hydro H1032. 【模板】快速幂](https://hydro.ac/p/H1032) （可以不用递归，困难，有题解）
```
