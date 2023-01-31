# Crypto 笔记 - 异或密码
## 1-2
我们把一些常用的东西封装保存起来：[pack_1](pack_1.jl)

这个比较简单
```jl
function main()
	x = readline(stdin) |> hex2bitarr
	y = readline(stdin) |> hex2bitarr
	res = xor.(x, y) |> bitarr2hex |> println
end
```

## 1-3
decrypt v.解密 devise v.设计

> You can do this by hand. But don't: write code to do it for you.

听起来很难的样子。

> Character frequency is a good metric.

首先我们知道，单个字符在 16 进制中占 2 格，划分一下：

`1b 37 37 33 31 36 3f 78 15 1b 7f 2b 78 34 31 33 3d 78 39 78 28 37 2d 36 3c 78 37 3e 78 3a 39 3b 37 36`

序列 `78` 大量出现，猜测是空格，代进去看看：

`1b 37 37 33 31 36 3f   15 1b 7f 2b   34 31 33 3d   39   28 37 2d 36 3c   37 3e   3a 39 3b 37 36`

看起来不错。
有一个单独的 `39`，只能是 `a`。我们又知道“XOR'd against a single character”，列举一下：
* `01100001` xor `?` = `00111001`
* `00100000` xor `?` = `01111000`

`?` = `01011000`，两个都符合。

那整体解析一下：
> `Cooking MC's like a pound of bacon`

关于 ETAOIN SHRDLU 这个梗：
> 英语中出现频率最高的 12 个字母可以简记为“ETAOIN SHRDLU”

`1-4` 中告诉我们这里代码还得写。

英语词频分析的方法似乎有很多，包括[单/双/三/四字母组词频](http://practicalcryptography.com/cryptanalysis/text-characterisation/quadgrams/)、常用单词词频、首/末字母词频、双重字母词频。这里应该暂时没那么复杂，我们先分析单字母词频，不弄优化。

先弄一张表
```jl
const word_freq = [
	0.0651738, 0.0124248, 0.0217339, 0.0349835, 0.1041442,
	0.0197881, 0.0158610, 0.0492888, 0.0558094, 0.0009033,
	0.0050529, 0.0331490, 0.0202124, 0.0564513, 0.0596302,
	0.0137645, 0.0008606, 0.0497563, 0.0515760, 0.0729357,
	0.0225134, 0.0082903, 0.0171272, 0.0013692, 0.0145984,
	0.0007836
]
const space_freq = 0.1918182
```

然后作一些粗糙的 `scoring`（[quipqiup](http://quipqiup.com/) 的看起来很精密，不知道怎么做的）
```jl
function score_en_text(str)
	score = 0.0
	for c in str
		if c == 0x20
			score += space_freq
		elseif 0x61 <= c <= 0x7a
			@inbounds score += word_freq[c - 0x61]
		elseif 0x41 <= c <= 0x5a
			@inbounds score += word_freq[c - 0x41]
		end
	end
	score
end
```

那么对于这个问题
```jl
function main()
	arr = readline(stdin) |> hex2bitarr
	len = length(arr)>>3
	@inbounds str = [getint(arr, i*8-7:i*8, UInt8)::UInt8 for i in 1:len]
	vec = Tuple{Float64, UInt8}[]
	sizehint!(vec, 128)
	for key in 0x0:0x7f
		score = xor.(str, key) |> score_en_text
		push!(vec, (score, key))
	end
	sort!(vec, by = first, rev = true)
	#= @inbounds for i in 1:10
		score, key = vec[i]
		for j in 1:len
			xor(str[j], key) |> Char |> print
		end
		println(" [$(score), $(key)]")
	end =#
	@inbounds key = vec[1][2]
	@inbounds for i in 1:len
		xor(str[i], key) |> Char |> print
	end
end
```

一次成功，评分 `2.097809` 远超第二 `1.313660`
