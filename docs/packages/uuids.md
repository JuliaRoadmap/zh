# UUIDs
## 介绍
**通用唯一辨识符**（UUID，Universally Unique Identifier）是用于给任意物品提供*唯一*辨识符的设计。

UUID 的标准可参考 [RFC 4122](https://www.ietf.org/rfc/rfc4122)

## UUID 类型
```julia-repl
julia> UUID(123)
UUID("00000000-0000-0000-0000-00000000007b")
```

## 工具
有以下工具函数：
- `uuid_version(u::UUID) -> Int` 查看 UUID 值的版本
- `uuid1([rng::AbstractRNG]) -> UUID` 生成第一版（基于当前时间戳、随机数、机器 MAC 地址/IP 地址）的 UUID
- `uuid4([rng::AbstractRNG]) -> UUID` 生成第四版（基于随机数）的 UUID
- `uuid5(ns::UUID, name::String) -> UUID` 生成第五版（基于命名空间和域）的 UUID

```julia-repl
julia> using Random

julia> rng = MersenneTwister(1234)
MersenneTwister(1234)

julia> uuid1(rng)
UUID("b7e638d0-d067-11ec-1a7e-43a2532b2fa8")

julia> uuid4(rng)
UUID("4dc4c099-47aa-4636-8779-6eb39d34804e")

julia> uuid5(uuid4(rng),"A red quick fox fell down.")
UUID("9add03f6-590a-5ba3-a29a-1c590ea288a9")

julia> uuid_version(ans)
5
```
