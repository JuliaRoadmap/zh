struct IndexDefault end
Base.getindex(container::AbstractArray, ::IndexDefault) = zero(eltype(container))

struct UnitRangeExt <: AbstractRange{Integer}
	range::UnitRange
	stop
end
Base.length(iter::UnitRangeExt) = iter.stop - iter.range.start + 1
Base.iterate(iter::UnitRangeExt) = (iter.range.start, iter.range.start)
function Base.iterate(iter::UnitRangeExt, state::Integer)
	state == iter.stop && return nothing
	state += one(state)
	el = state > iter.range.stop ? IndexDefault() : state
	(el, state)
end

struct EachSequence <: AbstractRange{Integer}
	seqlen::Integer
	len::Integer
	rem::Bool
end
Base.length(iter::EachSequence) = cld(iter.len, iter.seqlen)
function Base.iterate(iter::EachSequence, state::Integer = 0)
	state >= iter.len && return nothing
	stop = state + iter.seqlen
	if !iter.rem || stop <= iter.len
		el = state+1:stop
	else
		el = UnitRangeExt(state+1:iter.len, stop)
	end
	(el, stop)
end
function eachsequence(seqlen::Integer, len::Integer; rem::Bool = false)
	EachSequence(seqlen, len, rem)
end

struct LongSteps <: AbstractRange{Integer}
	n::Integer
	unitl::Integer
	spacel::Integer
	offset::Integer
end
Base.length(iter::LongSteps) = iter.n*iter.unitl
function Base.iterate(iter::LongSteps, state::Tuple = (1, 1, iter.offset))
	nunit, nid, offset = state
	if nunit > iter.n
		return nothing
	end
	val = offset + nid
	if nid == iter.unitl
		nunit += 1
		nid = 1
		offset = offset + iter.unitl + iter.spacel
	else
		nid += 1
	end
	state = (nunit, nid, offset)
	return (val, state)
end

fromhexunit(x::UInt8) = x <= 0x39 ? x - 0x30 : x - 0x61 + 0xa
fromhexunit(x::Char) = fromhexunit(UInt8(x))
tohexunit(x::UInt8) = x < 0xa ? x + 0x30 : x + 0x61 - 0xa

frombase64unit(x::UInt8) = x >= 0x61 ? x - 0x61 + 0x1a :
	x >= 0x41 ? x - 0x41 :
	x >= 0x30 ? x - 0x30 + 0x34 :
	x == 0x2b ? 0x3e : 0x3f
frombase64unit(x::Char) = frombase64unit(UInt8(x))
tobase64unit(x::UInt8) = x <= 0x19 ? x + 0x41 :
	x <= 0x33 ? x + 0x61 - 0x1a :
	x <= 0x3d ? x + 0x30 - 0x34 :
	x == 0x3e ? 0x2b : 0x2f

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

bitvector(str::AbstractString; mode = :hex) = _bitvector(Val(mode), str)::BitVector
function _bitvector(::Val{:ascii}, str::AbstractString)
	len = ncodeunits(str)
	bv = BitArray(undef, len*8)
	@inbounds for (i, range) in enumerate(eachsequence(8, len*8))
		setint!(bv, range, UInt8(str[i]))
	end
	bv
end
function _bitvector(::Val{:hex}, str::AbstractString)
	len = ncodeunits(str)
	bv = BitArray(undef, len*4)
	@inbounds for (i, range) in enumerate(eachsequence(4, len*4))
		setint!(bv, range, fromhexunit(str[i]))
	end
	bv
end
function _bitvector(::Val{:base64}, str::AbstractString)
	len = ncodeunits(str)
	len2 = len*6
	bv = BitArray(undef, len2)
	@inbounds for (i, range) in enumerate(eachsequence(6, len*6))
		setint!(bv, range, frombase64unit(str[i]))
	end
	for _ in 1:len2%8
		pop!(bv)
	end
	bv
end

Base.string(arr::BitVector; mode = :unicode) = _string(Val(mode), arr)::String
function _string(::Val{:unicode}, arr)
	es = eachsequence(8, length(arr); rem = true)
	sv = Base.StringVector(length(es))
	@inbounds for (i, range) in enumerate(es)
		sv[i] = getint(arr, range, UInt8)
	end
	String(sv)
end
_string(::Val{:bin}, arr) = bitstring(arr)
function _string(::Val{:hex}, arr)
	es = eachsequence(4, length(arr); rem = true)
	sv = Base.StringVector(length(es))
	@inbounds for (i, range) in enumerate(es)
		sv[i] = getint(arr, range, UInt8) |> tohexunit
	end
	String(sv)
end
function _string(::Val{:base64}, arr)
	es = eachsequence(6, length(arr); rem = true)
	orglen = length(es)
	extlen = iszero(orglen%4) ? 0 : 4-orglen%4
	sv = Base.StringVector(orglen + extlen)
	@inbounds for (i, range) in enumerate(es)
		sv[i] = getint(arr, range, UInt8) |> tobase64unit
	end
	for i in 1:extlen
		sv[i+orglen] = 0x3d
	end
	String(sv)
end
