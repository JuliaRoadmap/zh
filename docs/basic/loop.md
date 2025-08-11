# 循环
循环用于在指定条件下重复执行指定代码。
同样地，你也可以尝试举些例子、画流程图方便理解。

## while
`while` 循环的语法格式是：
```jl
while 条件
    语句
end
```

为了让你更深刻地了解循环是什么，可以尝试以下代码：
```jl
while true
    print("+")
end
```

没错，它会不断输出 `+` 产生“刷屏”的效果。具体输出速率取决于操作系统的窗口的实现。

你可以开一个新窗口观察这个程序的效果。

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

## for
语法格式为：
```jl
for 变量 in 循环范围
    语句
end
```

其中循环范围可以是[数组](vector.md)、[范围](range.md)、[字典](dict.md)等。你将在[之后](../advanced/iteration.md)读到如何自定义此操作。
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

## 优化循环检测
经常性地，你需要在*整齐*的循环条件外添加少数的额外情况。例如之前的代码需要在无限循环中添加“输入 `quit` 退出”的情况
```jl
escape = false
while !escape
    print("echo> ")
    s = readline()
    if s == "quit"
        escape = true
    else
        println(s)
    end
end
```

这里设置变量 `escape` 存储 `s == "quit"` 验证结果确实是实用的方法。

它也可以改为
```jl
while true
    print("echo> ")
    s = readline()
    if s=="quit"
        break
    else
        println(s)
    end
end
```

对于一些情况，这样写会使代码看起来简洁一些。但这也不是万能的，总之，对于相关的问题可以多实践，掌握更好的完成方式。

## 参阅
- [for ... in 调用了什么](https://docs.juliacn.com/latest/manual/interfaces/#man-interface-iteration)
- [语言进阶 - 遍历](../advanced/iteration.md)

## 练习
- “星号金字塔”：输出 n 行，每行依次有 $1, 2, \cdots n$ 个 `*`
- 上题的加强：
    1. n 行，依次 $n, n-1, \cdots ,1$ 个
    2. 2n-1 行，依次 $1, 2, \cdots ,n, n-1, \cdots ,1$ 个
    3. n 行，第 i 行先有 n-i 个空格，再有 i 个 `*`
- 输出 Fibonacci 数列的前 n 项
- [Hydro H1037. 哥德巴赫猜想](https://hydro.ac/p/H1037)
- [Hydro H1032. 【模板】快速幂](https://hydro.ac/p/H1032) （可以不用递归，困难，有题解）
