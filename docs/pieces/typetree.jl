function typetree(io::IO, from::Type)
	println(io, from)
	typetree_low(io, from, 1)
end

function typetree_low(io::IO, from::Type, n::Int)
	tys = subtypes(from)
	for ty in tys
		bl = (ty===Any || ty===Function)
		print(io, "|\t"^n)
		print(io, ty)
		ismutabletype(ty) && print(io, " m")
		isprimitivetype(ty) && print(io, " p")
		bl && print(io, " r")
		println(io)
		bl || typetree_low(io, ty, n+1)
	end
end
