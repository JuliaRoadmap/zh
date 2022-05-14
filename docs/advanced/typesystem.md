# 类型系统
## 概念
`类型(type)`分为`抽象类型(abstract type)`和`实际类型(concrete type)`，它们通过`子类型(subtype)`关系形成类似于[树](../algorithms/graph/tree.md)的结构，其中`叶子节点(leaf node)`对应实际类型\
类型通过`构造函数(constructor)`实例化，生成`值(value)`，通过`赋值(assign)`将值与`量`绑定

## 细节
`类型`本身是`DataType`的实例\
`Any`是`Any`的子类型\
子类型的逆运算是`超类型(supertype)`\
`function`关键字定义的函数是`Function`的子类型的实例

![typesystem-1.svg](../../svg/typesystem-1.svg)

## 泛型
