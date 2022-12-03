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
		if ismutable(ty) print(io, " m") end
		if isprimitivetype(ty) print(io, " p") end
		if bl print(io, " r") end
		println(io)
		if !bl typetree_low(io, ty, n+1) end
	end
end
