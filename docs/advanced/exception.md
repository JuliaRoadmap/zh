# 异常分类
**异常（Exception）**是进行[异常处理](../basic/error.md)的重要信息传递工具，所有内置的错误类型都是 `Exception` 的子类型

| 名称 | 描述 |
| :-: | :-: |
| ArgumentError | 给定的参数不符合人为规定 |
| AssertionError | 断言失败 |
| Base.IOError | 流操作出错 |
| BoundsError | 进行索引操作时越界 |
| CompositeException | 描述（可能由线程带来）的多个错误 |
| DimensionMismatch | 多维数组操作时维度不统一 |
| DivideError | 除以 0 |
| DomainError | 给定的参数超过某个范围，如 `sqrt(-1)` |
| EOFError | 流中无法读入更多数据 |
| ErrorException | 泛化的错误 |
| InexactError | 类型转化时无法解决的不精确问题 |
| InitError | 模块使用 `__init__` 初始化时抛出的错误 |
| InterruptException | 进程被终端阻塞 |
| KeyError | 对字典或集合访问/删除不存在的键 |
| LoadError | 在 `include`、`require` 或 `using` 时抛出的错误 |
| Meta.ParseError | 表达式解析失败 |
| MethodError | 调用的函数不具有指定方法（由参数类型决定） |
| MissingException | 在不支持 missing 的情况下遇到了 missing |
| OutOfMemoryError | 系统或垃圾收集器无法承载内存消耗 |
| OverflowError | 表达式结果对于指定类型太大 |
| ReadOnlyMemoryError | 尝试在只读区域写入数据 |
| SegmentationFault | 段错误，可能是指针偏移 |
| StackOverflowError | 栈溢出，函数多级调用开销过大（通常是错误地进行了无限递归） |
| StringIndexError | [参阅](string_code.md) |
| SystemError | 调用系统 API 时出错 |
| TaskFailedException | 线程运行失败 |
| TypeError | 类型断言失败 |
| UndefKeywordError | 给函数传[额外参数](../basic/function.md#第二栏)时漏传 |
| UndefRefError | 访问[未定义](undef.md)的某物品或字段 |
| UndefVarError | 当前作用域中某量未定义 |

## 练习
对于以下填空题，判断抛出的异常类型，不会抛出异常则填入 `nothing`。
```insert-test
[global]
name = "异常类型判断测试"
time_limit = 300
full_score = 100

[[parts]]
type = "group"
ch_type = "fill"
score = 10

[[parts]]
content = "`NaN/0`"
ans = "nothing"

[[parts]]
content = "`1÷0`"
ans = "DivideError"

[[parts]]
content = "`[1, 2, 3, 4][8]`"
ans = "BoundsError"

[[parts]]
content = "`\"cat\"/0`"
ans = "MethodError"

[[parts]]
content = "`foo() = foo(); foo()`"
ans = "StackOverflowError"

[[parts]]
content = "`[1 2; 3 4] - [1, 1, 1, 1]`"
ans = "DimensionMismatch"

[[parts]]
content = "`\"猫猫\"[2]`"
ans = "StringIndexError"

[[parts]]
content = "`Dict(0 => 1)[1]`"
ans = "KeyError"

[[parts]]
content = "`@assert 1==0`"
ans = "AssertionError"

[[parts]]
content = "`typeassert(0.0, Int)`"
ans = "TypeError"
```
