# 测验
```insert-test
[global]
name = "语法基础测试"
time_limit = 1800
full_score = 60

[[parts]]
type = "text"
content = "除特殊说明，请在不使用相关工具的情况下完成下列问题"

[[parts]]
type = "group"
content = "一、以下均为选择题，有 1~2 个正确选项"
ch_type = "choose"
score = 5

[[parts]]
content = "以下可以用于正常变量命名的是："
choices = ["_y3+", "continue", "A×B", "AxB"]
ans = "D"

[[parts]]
content = "对于以下的量，它乘以 NaN 一定得到零的是："
choices = ["0", "false", "0.0", "nothing"]
ans = "B"

[[parts]]
content = "-5 % 3 ="
choices = ["1", "3", "-2", "-1"]
ans = "C"

[[parts]]
content = "以下可得到 `\"aabb\"` 的是"
choices = ["\"ab\"&\"ab\"", "\"aa\"*\"bb\"", "string(\"a\", \"abb\")", "nameof(aabb)"]
ans = "BC"

[[parts]]
content = "以下可得到 `[4,4,4]` 的是："
choices = ["[1,2,3]+[3,2,1]", "[4]^3", "[1,2,3].+[3,2,1]", "4[3]"]
ans = "AC"

[[parts]]
content = "`collect(1=>2)` 的结果为："
choices = ["[1,2]", "[1=>2]", "报错", "Dict(1=>2)"]
ans = "A"

[[parts]]
type = "group"
content = "二、以下均为填空题"
ch_type = "fill"
score = 5

[[parts]]
content = "请表示一个只含单个「否」的元组"
ans_regex = "^ *\\( *false *, *\\) *$"

[[parts]]
content = "试用最短的方式表示含有单个反斜杠的字符串"
ans = "\"\\\\\""

[[parts]]
content = "凯撒加密的方法是：将 a~z 放在一个圆盘上，然后指定一个数字n，将待加密字符串每个字符在圆盘上顺时针转n格。请使用 Julia 解密 `htwwjhy` 到一个简单单词。"
ans = "correct"
score = 20
```
