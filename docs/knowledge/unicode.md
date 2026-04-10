# Unicode
Unicode 是目前最广泛使用的字符编码标准，官方定义自己为 "The World Standard for Text and Emoji"。
它以 ASCII 码表、扩展 ASCII 码表为基础进行了大幅的扩展，提供了超过 14 万个字符的统一编号，覆盖了世界上几乎所有书写系统、数学符号、表情符号等。

每个字符被赋予一个唯一的**码位**（code point），通常写作 `U+XXXX` 的形式（十六进制），例如汉字「猫」的码位为 `U+732B`，字母 `A` 为 `U+0041`。

## 编码方式
Unicode 本身只定义了字符与数字的对应关系；如何将这些数字存储到计算机字节序列中，由**编码方式**决定。常见的有三种：

| 编码 | 说明 |
| --- | --- |
| **UTF-8** | 变长编码，ASCII 字符仍占 1 字节，其余字符占 2~4 字节；互联网上使用最广泛，Julia 的 `String` 即采用此编码 |
| **UTF-16** | 变长编码，大多数常用字符占 2 字节，辅助平面字符占 4 字节；Windows 及 Java 内部使用 |
| **UTF-32** | 定长编码，每个字符固定占 4 字节；处理逻辑简单，但占用空间较大 |

## 与 Julia 的关系
Julia 的 `String` 类型是 UTF-8 编码的字节序列，并原生支持将 Unicode 字符用作标识符（变量名、函数名等）。在 REPL 中，输入 LaTeX 风格的命令后按 Tab 键即可插入对应的 Unicode 字符：

```julia-repl
julia> δ = 0.001
0.001

julia> α, β = 1, 2
(1, 2)

julia> ∑ = sum
sum (generic function with 10 methods)
```

这使得数学公式能以更贴近原始写法的形式出现在代码中。需要注意的是，由于 UTF-8 是变长编码，字符串的字节索引与字符索引并不总是一致，对多字节字符（如中文）进行索引时需格外注意。

Unicode 标准库还提供了例如 `graphemes` 等工具，用于按**字素簇**（用户可见的字符单元）迭代字符串：

```julia-repl
julia> gr = Base.Unicode.graphemes("x𝗑𝘅𝘹𝙭𝚡ｘ𝐱×х⨯ⅹ")
length-12 GraphemeIterator{String} for "x𝗑𝘅𝘹𝙭𝚡ｘ𝐱×х⨯ⅹ"

julia> length(collect(gr))
12
```

## 参阅
- [Unicode 组织官网](https://home.unicode.org/)
- [Unicode 快速查询](https://unicode-table.com/)

## 常见陷阱
字符串处理时，形似相同的字符可能实际上是不同的 Unicode 码位（如全角与半角标点、多种外观相似的引号或空格、汉字与注音符号的混用等），这会导致意想不到的匹配失败或比较结果。另外 Unicode 对于不同文字还有不同的复杂处理方式。

参考：
- [unicode viewer](https://r12a.github.io/uniview/)
- [Unicode 的常见陷阱（知乎专栏）](https://zhuanlan.zhihu.com/p/53714077)
