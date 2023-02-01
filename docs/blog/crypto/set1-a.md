# 导引章
## 关于
本系列当前主要是 Rratic 的 [the cryptopals crypto challenges](https://cryptopals.com/) 游玩笔记（分享性的）。

根据词典
> crypto- Modern Latin Greek kryptos “hidden”, from kryptein “to hide”

而“cryptopals”似乎在词典中查不到。

## Set 1 说明
`beat oneself up` v. 自责

## 1-1
根据给出的建议
> Always operate on raw bytes, never on encoded strings. Only use hex and base64 for pretty-printing.

先写一些实用函数
```jl
function getint(arr::BitArray, itr, type::Type{T} where T <: Integer = UInt8)
	num = zero(type)
	for i in itr
		num <<= 1
		if arr[i]
			num += one(type)
		end
	end
	num
end
function setint!(arr::BitArray, itr, num::Integer)
	for i in reverse(itr)
		arr[i] = Bool(num&0x1)
		num >>= 1
	end
end
```

写对应的功能。按照语境，出现的所有字符都应是标准 ASCII 中的，故暂时不必进行 Unicode（完全）兼容。

```jl
function hex2bitarr(hexstr)
	arr = BitArray(undef, sizeof(hexstr)*4)
	@inbounds for i in 1:sizeof(hexstr)
		u8_ch = UInt8(hexstr[i])
		n = u8_ch <= 0x39 ?
			u8_ch - 0x30 :
			u8_ch - 0x61 + 0xa
		setint!(arr, i*4-3:i*4, n)
	end
	arr
end
```

`Base64`：
```jl
function base64unitencode(u8)
	u8 <= 25 ? 'A' + u8 :
	u8 <= 51 ? 'a' + u8 - 26 :
	u8 <= 61 ? '0' + u8 - 52 :
	u8 == 62 ? '+' : '/'
end
function bitarr2base64(arr)
	n, r = divrem(length(arr), 6)
	str = ""
	@inbounds for i in 1:n
		u8_64 = getint(arr, i*6-5:i*6, UInt8)
		str *= base64unitencode(u8_64)
	end
	if !iszero(r)
		u8_64 = getint(arr, n*6+1:length(arr), UInt8) <<
			(6-r)
		str *=  base64unitencode(u8_64)
	end
	m4 = sizeof(str) % 4
	iszero(m4) || (str *= '='^(4-m4))
	str
end
```

主流程：
```jl
function main()
	readline(stdin) |> hex2bitarr |> bitarr2base64 |> println
end
```
