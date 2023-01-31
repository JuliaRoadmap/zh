# Crypto 笔记 - 异或密码
## 1-2
比较简单
```jl
function bitarr2hex(arr)
	str = ""
	n, r = divrem(length(arr), 4)
	for i in 1:n
		u8 = getint(arr, i*4-3:i*4, UInt8)
		ch = u8 <= 9 ? '0' + u8 : 'a' + u8 - 10
		str *= ch
	end
	if !iszero(r)
		u8 = getint(arr, n*4+1:length(arr), UInt8) <<
			(4-r)
		ch = u8 <= 9 ? '0' + u8 : 'a' + u8 - 10
		str *= ch
	end
	str
end
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
