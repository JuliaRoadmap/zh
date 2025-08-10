# 条件
对于之前几章的代码，语句都是一条条依次执行的。
此结构称为「顺序结构」。
```julia
print(1)
println(2)
a = 3+4
print(a)

# [output]
# 12
# 7
```

「条件-分支结构」是另一种常见的结构：用于表示形如“在某条件下执行某代码”的逻辑。

你可以尝试举些例子、画流程图方便理解。

## if-then
分支结构的基本语法如下：
```julia
if 条件
	若条件为真时执行
end
```
**条件（statement）**是一个表达式，它的值必须是 `Bool` 类型的实例，这保证了语义，与一些允许条件为整数的语言不同。

## if-then-else
使用 `else` 可以标记另一面：
```julia
if 条件
    若条件为真时执行
else
    若条件为假时执行
end
```

## elseif
你可以将 `else` 与 `if` 合并，并并入同一层中
```julia
if 条件1
    若条件1为真时执行
elseif 条件2
    若条件2为真时执行
end
```

## 三目运算符
语法是 `表达式 ? 真时执行 : 假时执行`。
`st ? a : b` 相当于
```jl
if st
    a
else
    b
end
```

利用 Julia 的续行规则，你可以写出如下的美观代码：
```julia
d = v=="Mon" ? 1 :
    v=="Tue" ? 2 :
    v=="Wed" ? 3 :
    v=="Thur" ? 4 :
    v=="Fri" ? 5 :
    v=="Sat" ? 6 : 7
```

## 函数包裹
Julia 提供了一个函数型的分支方式，它的不同点在于，由于它是函数，参数的值都会被计算而不会像 `&&`、`||` 那样“短路”（不涉及的参数不必计算）。
```jl
ifelse(true, print("true"), print("false"))

# [output]
# truefalse
```

## switch-case?
Julia 本身不提供形如 `switch/select-case` 的结构，因为会自动优化。[^1]
如果想写类似的代码，可以使用相关的包。

## 利用 && ||
有时，`if` 语块显得太臃肿了，可以这样写：
```jl
stat && content

stat || content
```

## 底层说明
CPU 可能进行会分支预测 [^2]

## 练习
- 只通过条件-分支结构，输入整数 `a`、`b`、`c`，然后输出它们中的最小值
- 只通过条件-分支结构，输入整数 `a`、`b`、`c`，然后从小到大输出它们
- 通过条件-分支结构，输入整数 `a`、`b`、`c`，然后输出对 `a`、`b`、`c` 作为边长能否组成三角形的判断
- 分析在“利用 && ||”节中两个语句分别对应什么作用

[^1]: https://discourse.julialang.org/t/is-there-a-select-case-equivalent-in-julia/66516
[^2]: https://www.luogu.com.cn/blog/zhaojinxi/qian-tan-di-ceng-chang-shu-you-hua-ji-CPU-you-hua
