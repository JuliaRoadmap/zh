# HydroOJ使用
[HydroOJ](https://hydro.ac/)是一个基于[Hydro](https://github.com/hydro-dev/Hydro)，支持Julia语言的`在线评测器(OJ,Online Judge)`\
[官方使用指南](https://hydro.ac/discuss/6080b1d93c27ccf0adb34216)

在递交时，应将代码包裹进函数中，以方便优化
```jl
function main()
	# 代码
end
main()
```

!!! note
	由于Julia的JIT需要启动时间，管理员[设置了二倍时限](https://github.com/hydro-dev/Hydro/issues/306#issuecomment-1038054807)

## 安全
Hydro主要开发者[undefined-moe](https://github.com/undefined-moe)较重视安全问题\
相关事项请信任`超级管理员(Super User)`（带有`SU`标签），可选择性信任携带其它标签者
