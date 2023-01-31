# 异或密码 2
!!! note
	先前的工具箱已被重新整理并增添了功能，见[此](pack_libseq.jl)

## 1-5
stanza n.节
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

[^1]: 可利用 `Base.CodeUnits`
