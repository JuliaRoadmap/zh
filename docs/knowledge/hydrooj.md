# HydroOJ使用
## 关于
[HydroOJ](https://hydro.ac/) 是一个基于 [Hydro](https://github.com/hydro-dev/Hydro) 的**在线评测系统（OJ/Online Judge）**。我们提及它的最大原因是它支持 julia 作为提交语言。

你可以在 [【站务】【新用户必读】站务整合帖](https://hydro.ac/discuss/6080b1d93c27ccf0adb34216) 阅读官方提供的使用指南。

在递交时，建议将代码包裹进函数中，以方便优化 [^1]
```jl
function main()
	# 代码
end
main()
```

!!! note
	由于 Julia 的 JIT 需要启动时间且不易计量，管理员[设置了二倍时限](https://github.com/hydro-dev/Hydro/issues/306#issuecomment-1038054807)。

## 安全
Hydro 主要开发者 [undefined-moe](https://github.com/undefined-moe) 较重视安全问题。
对于相关事项请信任**超级管理员（Super User）**（带有 `SU` 标签），可选择性信任携带其它标签者及活跃用户。

[^1]: [“写函数，而不是写脚本。”](https://docs.juliacn.com/latest/manual/performance-tips/#%E5%BD%B1%E5%93%8D%E6%80%A7%E8%83%BD%E7%9A%84%E5%85%B3%E9%94%AE%E4%BB%A3%E7%A0%81%E5%BA%94%E8%AF%A5%E5%9C%A8%E5%87%BD%E6%95%B0%E5%86%85%E9%83%A8)
