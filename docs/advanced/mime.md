# MIME
## 介绍
MIME 的全称是**多用途互联网邮件扩展类型** （Multipurpose Internet Mail Extensions），它是描述消息内容类型的标准，用来表示文档、文件或字节流的性质和格式。

MIME 的通用格式是 `type/subtype`

我们通常接触的格式大多使用可视的文字表示数据，使用主类型 `text`。例如 `text/plain` 是纯文字，`text/markdown` 对应 `Markdown` 富文本。

`image/jpeg`，`image/gif` 则是不同的图片格式。

主类型 `application` 对应应用的代码/可执行文件。

## 类型
Julia 中有两种方式分别创建 MIME 类型和 MIME 类型的值。
```julia-repl
julia> type = MIME"text/plain"
MIME{Symbol("text/plain")}

julia> value = MIME("text/plain")
MIME type text/plain

julia> isa(value, type)
true
```

## 多媒体显示
MIME 被允许作为 [show](typesystem.md#自定义显示) 的第二个参数，用于控制输出格式。

例如，在纯文本环境下可以选择不同的文本格式类型
```julia-repl
julia> show(stdout, MIME("text/plain"), [1 2;3 4])
2×2 Matrix{Int64}:
 1  2
 3  4
julia> show(stdout, MIME("text/csv"), [1 2;3 4])
1,2
3,4
```

## 参阅
- [MIME类型 | 菜鸟教程](https://www.runoob.com/http/mime-types.html) - 含对照表
