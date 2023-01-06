# 布尔逻辑
## 简介
「布尔（Boolean）」 是一种逻辑数据类型，它是（狭义）逻辑的核心

## 值
布尔类型的值有且仅有两种，即：
* 「真（true）」
* 「假（false）」

## 运算
「非（not）」是一元运算，表示将值翻转 [^1]
* true => false
* false => true

「与（and）」是二元运算，表示“且”关系 [^2]
* 当 `a`、`b` 均为真时，`a与b` 为真
* 否则为假

| a and b | true | false |
| :-: | :-: | :-: |
| true | true | false |
| false | false | false |

「或（or）」是二元运算 [^3]
* `a`、`b` 之一为真时，`a或b` 为真
* 否则为假

| a or b | true | false |
| :-: | :-: | :-: |
| true | true | true |
| false | true | false |

「异或（xor）」是二元运算 [^4]
* 当 a、b 不同时为真
* 否则为假

| a xor b | true | false |
| :-: | :-: | :-: |
| true | false | true |
| false | true | false |

## 练习
1. 用 `not` 和 `and` 的复合运算表示 `or`
2. 用 `not` 和 `or` 的复合运算表示 `and`
3. 用 `not` 和 `or` 的复合运算表示 `xor`
4. 证明异或满足分配律与结合律
5. 
```insert-fill
content = "A: 你是否要按下按钮？  \n这里的逻辑应如何描述？"
ans = "异或"
ans_regex = "(异或)|(xor)|(⊻)"
```

!!! note
	可以尝试使用 Venn 图来方便理解、刻画

[^1]:
在数学上记作「否定（¬）」
[^2]:
在数学上记作「合取（∧）」
[^3]:
在数学上记作「析取（∨）」
[^4]:
也记作 `⊻`
