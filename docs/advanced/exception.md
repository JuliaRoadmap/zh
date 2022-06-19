# 异常分类
`异常(exception)`是通常用于[异常处理](../basic/error.md)的物体，所有内置的错误类型都是`Exception`的子类型
| 名称 | 描述 |
| --- | --- |
| ArgumentError | 给定的参数不符合人为规定 |
| AssertionError | 断言失败 |
| Base.IOError | 流操作出错 |
| BoundsError | 进行索引操作时越界 |
| CompositeException | 描述（可能由线程带来）的多个错误 |
| DimensionMismatch | 多维数组操作时维度不统一 |
| DivideError | 除以0 |
| DomainError | 给定的参数超过某个范围，如`sqrt(-1)` |
| EOFError | 流中无法读入更多数据 |
| ErrorException | 泛化的错误 |
| InexactError | 类型转化时无法解决的不精确问题 |
| InitError |  |
| InterruptException | 进程被终端阻塞 |
| KeyError |  |
| LoadError |  |
| Meta.ParseError | 表达式解析失败 |
| MethodError | 调用的函数不具有指定方法（由参数类型决定） |
| MissingException | 在不支持missing的情况下遇到了missing |
| OutOfMemoryError | 系统或垃圾收集器无法承载内存消耗 |
| OverflowError | 表达式结果对于指定类型太大 |
| ReadOnlyMemoryError | 尝试在只读区域写入数据 |
| RemoteException |  |
| SegmentationFault | 段错误，可能是指针偏移 |
| StringIndexError | [参阅](string_code.md) |
| SystemError | 调用系统API时出错 |
| TaskFailedException | 线程运行失败 |
| TypeError | 类型断言失败 |
| UndefKeywordError | 给函数传[额外参数](../basic/function.md#第二栏)时漏传 |
| UndefRefError |  |
| UndefVarError |  |

## 练习
对于以下填空题，判断抛出的异常类型，不会抛出异常则填入`nothing`
```insert-fill
("NaN/0", "nothing")
```
```insert-fill
("1÷0", "DivideError")
```
```insert-fill
("[1, 2, 3, 4][8]", "BoundsError")
```
```insert-fill
("\"cat\"/0", "MethodError")
```
```insert-fill
("[1 2; 3 4] - [1, 1, 1, 1]", "DimensionMismatch")
```
```insert-fill
("@assert 1==0", "AssertionError")
```
```insert-fill
("typeassert(0.0, Int)", "TypeError")
```
