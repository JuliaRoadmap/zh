# 变量作用域
```julia-repl
julia> if true
           local scoped = 0
       end
0

julia> scoped
ERROR: UndefVarError: `scoped` not defined in `Main`
Suggestion: check for spelling errors or missing imports.
```

## 简述
方便起见，可以遵循一个原则，即把 `xxx ... end` 看作一个层层嵌套的块。使用一个变量时先在当前块或某个上级块初始化，通常初始化所在块结束时，这个变量也会消亡。

## 参阅
Julia 中具体的变量作用域规则较为复杂，可参阅[中文文档](https://docs.juliacn.com/latest/manual/variables-and-scoping/)。
