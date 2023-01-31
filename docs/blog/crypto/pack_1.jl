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

function hexunitencode(c::Char)
	t = UInt8(c)
	t <= 0x39 ? t - 0x30 : t - 0x61 + 0xa
end

function hex2bitarr(hexstr)
	arr = BitArray(undef, sizeof(hexstr)*4)
	@inbounds for i in 1:sizeof(hexstr)
		n = hexunitencode(hexstr[i])
		setint!(arr, i*4-3:i*4, n)
	end
	arr
end
function bitarr2hex(arr)
	str = ""
	n, r = divrem(length(arr), 4)
	@inbounds for i in 1:n
		u8 = getint(arr, i*4-3:i*4, UInt8)
		ch = u8 <= 9 ? '0' + u8 : 'a' + u8 - 10
		str *= ch
	end
	if !iszero(r)
		@inbounds u8 =
			getint(arr, n*4+1:length(arr), UInt8) <<
			(4-r)
		ch = u8 <= 9 ? '0' + u8 : 'a' + u8 - 10
		str *= ch
	end
	str
end

function bitarr2str(arr)
	str = ""
	l = length(arr) >> 3
	@inbounds for i in 1:l
		str *= Char(getint(arr, i*8-7:i*8, UInt8))
	end
	str
end
