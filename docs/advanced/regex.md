# 正则表达式
**正则表达式**（regular expression）是一种按顺序匹配字符串的模式。例如，使用 `^julia>.*$` 匹配本页面中所有以 `julia>` 左起的行。

可以从[中文版的“Learn Regex the Easy Way”](https://github.com/ziishaned/learn-regex/blob/master/translations/README-cn.md)中学习正则表达式的规则。另可额外阅读正则表达式的“替换引用”相关内容。

## regex
```@repl
r = r"a|b"
findall(r, "abc")
```

先前文档中提及的「标志/模式修正符」对应正则表达式构建时的第二个参数
```@repl
r = Regex("a|b", "i")
findall(r, "AB")
```

## 运算
```@repl
r"a|b" == r"b|a" # 逻辑上相同，但不会区分
r"a" * r"b"
r"a" * "b"
r"a" ^ 2
```
