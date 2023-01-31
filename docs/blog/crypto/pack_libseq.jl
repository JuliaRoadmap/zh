struct IndexDefault end
Base.getindex(container, ::IndexDefault) = zero(eltype(container))

struct UnitRangeExt
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

struct EachSequence
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

fromhexunit(x::UInt8) = x <= 0x39 ? x - 0x30 : x - 0x61 + 0xa
fromhexunit(x::Char) = fromhexunit(UInt8(x))

function bitvector(str::AbstractString; mode = :hex)
	if mode == :hex
	elseif mode == :ascii
	elseif mode == :base64
	end
	error("mode $mode is not supported")
end

function Base.string(str::BitVector; mode = :unicode)
	;
end
