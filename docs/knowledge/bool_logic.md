# 布尔逻辑
## 简介
`布尔(Boolean)`是一种逻辑数据类型，通常用于条件语句

## 值
布尔类型只有两种值，即
* `真(true)`
* `假(false)`

## 运算
`非(not)`，在数学上记作`否定(¬)`
* true => false
* false => true

`与(and)`，在数学上记作`合取(∧)`
* 当a、b均为真时，`a与b`为真
* 否则为假

| a and b | true | false |
| :-: | :-: | :-: |
| true | true | false |
| false | false | false |

`或(or)`，在数学上记作`析取(∨)`
* a、b之一为真时，`a或b`为真
* 否则为假
* 你可以尝试用`not`和`and`的复合运算表示`or`

| a or b | true | false |
| :-: | :-: | :-: |
| true | true | true |
| false | true | false |

`异或(xor)`，在数学上记作`⊻`
* 当a、b不同时为真
* 否则为假
* 易证满足分配律、结合律
* 你可以尝试用`not`和`or`的复合运算表示`xor`

| a xor b | true | false |
| :-: | :-: | :-: |
| true | false | true |
| false | true | false |

```insert-fill
("A: 你是否要按下按钮？\n这里的逻辑应如何描述？","异或",r"(异或)|(xor)|(⊻)")
```

!!! note
	可以尝试使用Venn图来方便理解、刻画
