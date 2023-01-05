# 版本号
## 版本号规则
[这](https://semver.org/lang/zh-CN/)是语义化版本规范（v2.0.0）的文本。
其中 `主版本号`，`次版本号`，`修订号`，`先行版本号` 分别对应 `major`，`minor`，`patch` 和 `prerelease`

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

julia> v"1.0.0-alpha"<v"1.0.0-beta"
true
```
