# 异或密码 2
!!! note
	先前的工具箱已被重新整理并增添了功能，见[此](pack_libseq.jl)

## 1-5
`stanza` n. 节
```jl
function encrypt_repeatingkeyxor(plain::AbstractString, key::AbstractString)
	pbv = bitvector(plain; mode = :ascii)
	kbv = bitvector(key; mode = :ascii)
	@inbounds for range in eachsequence(length(kbv), length(pbv); rem = true)
		if isa(range, UnitRange)
			pbv[range] .⊻= kbv
		else
			range::UnitRangeExt
			pbv[range.range] .⊻= kbv[1:length(range.range)]
		end
	end
	string(pbv; mode = :hex)
end
```

我怀疑给的答案末尾漏了 `4f`。

> Encrypt a bunch of stuff using your repeating-key XOR function. Encrypt your mail. Encrypt your password file. Your .sig file. Get a feel for it. I promise, we aren't wasting your time with this.

```jl
play1_5(i, o, k) = write(o, encrypt_repeatingkeyxor(read(i, String), k))
```

但是上面那个还不支持非 ascii 内容 [^1]，因此不太易于试验。

## 1-6
`prone` adj. 易于……的 `error-prone` adj. 易于出错的 `n worth of x` n 个 x `transpose` vi. 进行变换 `histogram` n. 直方图；柱状图

这个指示还是很清晰的，先写 `edit distance/Hamming distance`
```jl
function edit_distance(arrx, arry)
	cnt = 0
	for i in 1:length(arrx)
		(arrx[i] == arry[i]) || (cnt += 1)
	end
	cnt
end
```

37 正确。

先导入数据（`bv = bitvector(replace(clipboard(), '\n' => ""); mode = :base64)`）
找到 `KEYSIZE`：
```jl
vec = Tuple{Float64, Int}[]
sizehint!(vec, 39)
for ks in 2:40
	s1 = @view bv[1:ks*8]
	s2 = @view bv[ks*8+1:ks*16]
	s3 = @view bv[ks*16+1:ks*24]
	s4 = @view bv[ks*24+1:ks*32]
	v = (edit_distance(s1, s2) + edit_distance(s3, s4)) / ks
	push!(vec, (v, ks))
end
sort!(vec; by = first)
```

得到：
```plain
(4.0, 2)
(5.0, 5)
(5.333333333333333, 3)
(5.8, 15)
(5.8125, 16)
⋮
(7.423076923076923, 26)
(7.5, 4)
(7.5, 6)
(7.594594594594595, 37)
```

那我们先猜测 `KEYSIZE` 为 2

> Now transpose the blocks: make a block that is the first byte of every block, and a block that is the second byte of every block, and so on.

```jl
bv1 = bv[collect(LongSteps(1462, 8, 8, 0))]
l1_3_try(bv1)
```

[^1]: 可利用 `Base.CodeUnits`
