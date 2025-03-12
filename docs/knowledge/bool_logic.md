# 布尔逻辑
## 简介
**布尔（Boolean）**是一种逻辑数据类型，它表达了布尔代数这一重要逻辑模型。

## 值
布尔类型的值有且仅有两种，即：
* **真（true）**
* **假（false）**

## 运算
**非（not）**[^1]是一元运算，表示将值翻转。即将真变为假，假变为真。

**与（and）**[^2]是二元运算，表示“且”关系。当 `a` 和 `b` 同为真时 `a and b` 为真，否则为假。

| `a and b` | true | false |
| :-: | :-: | :-: |
| true | true | false |
| false | false | false |

**或（or）**[^3]是二元运算。当 `a` 和 `b` 之一为真时 `a or b` 为真，否则为假。

| `a or b` | true | false |
| :-: | :-: | :-: |
| true | true | true |
| false | true | false |

**异或（xor）**[^4]是二元运算。当 `a` 和 `b` 恰一个为真时 `a xor b` 为真，否则为假。

| `a xor b` | true | false |
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

[^1]: 在形式逻辑中记作**否定（¬）**
[^2]: 在形式逻辑中记作**合取（∧）**
[^3]: 在形式逻辑中记作**析取（∨）**
[^4]: 也记作 `⊻`
