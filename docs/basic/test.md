# 测验
```insert-test
[global]
name = "语法基础测试"
time_limit = 1800
full_score = 100

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
content = "以下可得到 `[4,4,4]` 的是："
choices = ["[1,2,3]+[3,2,1]", "[4]^3", "[1,2,3].+[3,2,1]", "4[3]"]
ans = "AC"

[[parts]]
type = "group"
content = "二、以下均为填空题"
ch_type = "fill"
score = 5

[[parts]]
content = "请表示一个只含单个「否」的元组"
ans_regex = "^ *\\( *false *, *\\) *$"
```
