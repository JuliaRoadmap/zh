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
content = "以下均为单选题"
choice_num = 1
score = 5

[[parts]]
type = "choice"
content = "以下可以用于正常变量命名的是："
choices = ["_y3+", "continue", "A×B", "AxB"]
ans = "D"

[[parts]]
type = "group"
content = "以下均为填空题"
score = 5

[[parts]]
type = "fill"
content = "请表示一个只含单个「否」的元组"
ans_regex = "^ *( *false *, *) *$"
```
