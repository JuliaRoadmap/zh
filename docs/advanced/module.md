# 模块
## 简介
Julia 中的`模块(module)`是一些互相隔离的可变工作空间，会引入新的全局作用域。模块允许创建顶层定义（也称为全局变量），而无需担心命名冲突\
在模块中，利用`导入(importing)`控制其它模块中的哪些名称是可见的；利用`导出(exporting)`控制自己的模块中哪些名称是公开的

## 标准模块
`Core`包含了语言*内置*的所有功能\
`Base`包含了绝大多数情况下都会用到的基本功能\
`Main`是顶层模块，当 julia 启动时，也是当前模块

## 语法
使用`module ... end`声明一个模块，它会默认导入`Base`和`Core`\
特别地，可以使用`baremodule ... end`从而不导入`Base`，也不在本地定义`eval`和`include`\
基础示例：
```jl
julia> module Foo
       export Bar # 建议不缩进
       module Bar # 模块可以嵌套
       greet()=println("Hello!")
       end
       end
Main.Foo

julia> N=Foo # 模块也可以这样赋值
Main.Foo

julia> N
Main.Foo

julia> typeof(N)
Module

julia> N.Bar.greet()
Hello!
```

## 导出
使用`export x1,x2`导出\
需注意的是，无法导出含有指定参数列表的函数

## 导入
`import Foo`导入`Foo`模块，在调用时需使用`Foo.x(3)`\
`import Foo.x,y`导入`Foo`中的`x`和`y`\
`import FastOnlineOpen as Foo`在调用时使用`Foo`简写\
`using Foo`导入`Foo`模块，在调用时若无歧义可以使用`x(3)`\
`using Foo.Bar:a,b`导入`Foo`的子模块`Bar`中的`a`和`b`
