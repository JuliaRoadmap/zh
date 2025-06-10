# 版本号
## 版本号规则
被广泛使用的「语义化版本」当前的规范文本可见于[此](https://semver.org/lang/zh-CN/)。
其中涉及的概念**主版本号**，**次版本号**，**修订号**和**先行版本号**分别对应 `VersionNumber` 类型中的 `major`，`minor`，`patch` 和 `prerelease` 字段。

## 版本号类型
```julia-repl
julia> dump(v"1.0.0-alpha")
VersionNumber
  major: UInt32 0x00000001
  minor: UInt32 0x00000000
  patch: UInt32 0x00000000
  prerelease: Tuple{String}
    1: String "alpha"
  build: Tuple{} ()

julia> v"1.0.0-alpha" < v"1.0.0-beta"
true
```
