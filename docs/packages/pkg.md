# Pkg的使用
`Pkg` 提供了大量包管理的相关函数，包括但不限于 `activate`、`add`、`build`、`develop`、`gc`、`precompile`、`rm`、`test`、`update`

通过阅读帮助文档，可以了解使用方式：
```jl
help?> Pkg.add
  ...

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  Pkg.add("Example") # Add a package from registry
  ...
```

`PackageSpec` 结构用于保存指定包的元数据
