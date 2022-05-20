# tips整理规范
## 核心
解决可以用`how`描述的问题\
遵循命名仅由小写字母、数字、下划线组成的规则

## 词组处理
* 若需要泛型方法，在最前加上`any_`
* 大类（若是缩写或有较大歧义）+核心词+定性（名词，若有），用`_`串联

## 目录分类
### call
描述：解决如何调用xxx的问题\
准备：你需要调用什么？它的准确描述是什么？\
示例：R 语言调用方式 => `rlang.md`

### error
描述：解决报错问题\
准备：找到错误类型名\
示例：[`OutOfMemoryError`的处理方式](https://discourse.juliacn.com/t/topic/5752) => `outofmemory.md`

### diff
描述：区分\
准备：区分哪些东西，找到最短英文描述，按照首字母排序\
举例：missing-nothing-undef的区分 => `missing_nothing_undef.md`

### fix
描述：修复一个问题\
准备：主语是什么？问题的核心名词是什么？\
示例：[类型推断失败](https://discourse.juliacn.com/t/topic/6218) => `julia/typeassert_failure.md`

### get
描述：获取什么东西\
准备：主语\
示例：[获取.xls文件数据](https://discourse.juliacn.com/t/topic/5138) =>  `file_xls.md`

### judge
描述：判断/估计什么东西\
准备：需要(need)、现有(exist)、结果(result)；主语\
示例：[判断开多少线程](https://discourse.juliacn.com/t/topic/6215) => `need/task_number.md`

### know
描述：知道/（快速）了解什么东西\
准备：主语\
示例：任意包 => `any_package.md`

### transform
描述：转化\
准备：源、目标\
示例：markdown转pdf => `markdown2pdf.md`

## tag
标签应包括目录分类、大类（可能有多个）和定性
