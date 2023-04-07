module Virtual
mutable struct File
	content::String
end
mutable struct Directory
	children::Set{Int}
end

mutable struct FileSystem
	root::Int
	current::Int
	number::Int
	parents::Vector{Int}
	names::Vector{String}
	nodes::Vector{Union{File, Directory, Nothing}}
end

empty_dir() = Directory(Set{Int}())
FileSystem() = FileSystem(1, 1, 1, [1], [""], [empty_dir()])
# rootjail(fs::FileSystem, id)

parent(fs::FileSystem, id) = fs.parents[id]
name(fs::FileSystem, id) = fs.names[id]

errormsg_pos(fs::FileSystem, id) = "#$id ($(name(fs, id)))"
function apply_insert(fs::FileSystem)
	fs.number += 1
	fs.number
end

function show_path(fs::FileSystem, id::Integer, relative::Integer = 0)
	if iszero(relative) # use full path
		s = "/$(name(fs, id))"
		while true
			if id == fs.root
				break
			end
			id = parent(fs, id)
			s = "/$(name(fs, id))$s"
		end
	else
	end
	s
end

function reach(fs::FileSystem, id::Integer, path)
	for s in path
		if s == ".."
			id = parent(fs, id)
		elseif s != "."
			chdn = fs.nodes[id].children
			id = 0
			for chd in chdn
				if name(fs, chd) == s
					id = chd
					break
				end
			end
			iszero(id) && error("Object name '$s' not found at $(errormsg_pos(fs, id))")
		end
	end
	id
end
function reach(fs::FileSystem, path)
	startswith(path, '/') ? reach(fs, fs.root, path[2:end]) : reach(fs, fs.current, path)
end
function reach_directory(fs::FileSystem, path)
	x = reach(fs, path)
	isa(fs.nodes[x], Directory) || error("Failed to access directory.")
	x
end
function reach_parentit(fs::FileSystem, path)
	;
end

function remove_directory(fs::FileSystem, id)
	fs.nodes[id] = nothing
	delete!(fs.nodes[parent(fs, id)].children, id)
	fs.number -= 1
end

### Function for commands ###
function _pwd(fs::FileSystem)
	@info show_path(fs, fs.current, 0)
end
function _ls(fs::FileSystem, from::Integer = fs.current)
	dir = fs.nodes[from]
	isa(dir, Directory) || error("$(errormsg_pos(fs, id)) is not a directory")
	for id in dir.children
		node = fs.nodes[id]
		name = name(fs, id)
		isa(node, Directory) && print("<DIR>")
		println("\t\t", name)
	end
end
function _cd(fs::FileSystem, path::AbstractString)
	fs.current = reach_directory(fs, path)
end
function _mkdir(fs::FileSystem, path::AbstractString; force::Bool = true)
	par, this = reach_parentit(fs, path)
	set = dirnode(fs, par).children
	detect_childname(set, this) do id
		force || error("An object with the same name already exists.")
		remove_directory(fs, id)
	end
	id = apply_insert(fs)
	push!(parents, par)
	push!(names, this)
	push!(nodes, empty_dir())
	push!(set, id)
end
function _rmdir(fs::FileSystem, path::AbstractString)
	par, this = reach_parentit(fs, path)
	set = fs.nodes[par].children
	detect_childname(set, this) do id
		remove_directory(fs, id)
	end
	pop!(set, id)
end
function _cp(fs::FileSystem, from::AbstractString, to::AbstractString; force::Bool = true)
	fnode = fs.nodes[reach_dir(fs, from)]
	par, this = reach_parentit(fs, to)
	pnode = dirnode(fs, par)
	detect_childname(pnode.children, this) do id
		force || error("An object with the same name already exists.")
		remove_directory(fs, id)
	end
	;
end
function _mv(fs::FileSystem, from::AbstractString, to::AbstractString; force::Bool = true)
	;
end

function __init__()
	@info "当前不支持磁盘、格式等模拟；只支持命令格式，不支持额外参数\n使用 \"sim 目标\" 切换模拟环境"
end

end # module

const simdata = Dict{String, Tuple{UnitRange, UInt8, Symbol}}(
	# "sim"   => (1:1, 0x7, :)
	"pwd"     => (0:0, 0x5, :pwd),
	"chdir"   => (0:0, 0x2, :pwd),
	"ls"      => (0:1, 0x1, :ls),
	"dir"     => (0:1, 0x2, :ls),
	"readdir" => (0:1, 0x4, :ls),
	"cd"      => (1:1, 0x7, :cd),
	"mkdir"   => (1:1, 0x7, :mkdir),
	"md"      => (1:1, 0x2, :mkdir),
	"rmdir"   => (1:1, 0x3, :rmdir),
	"rm"      => (1:1, 0x5, :rm),
	"del"     => (1:1, 0x2, :rm),
	"cp"      => (2:2, 0x5, :cp),
	"copy"    => (2:2, 0x2, :cp),
	"mv"      => (2:2, 0x7, :mv),
)
function init()
	fs = FileSystem()
	_mkdir(fs, "home")
	_cd(fs, "home")
	_touch(fs, "/home/hello.txt", "你好")
	sim = 0x0
	while true
		print("vfs> ")
		s = readline()
		try
			v = split(s)
			isempty(v) && continue
			if v[1] == "sim"
				sim = v[2] == "unix" ? 0x0 :
					v[2] == "windows" ? 0x1 :
					v[2] == "julia" ? 0x2 :
					error("不支持的模拟对象")
				println()
				continue
			elseif v[1] == "quit"
				return
			end
			name = String(v[1])
			haskey(simdata, name) || error("不支持的命令")
			@inbounds data = simdata[name]
			vl = length(v) - 1
			in(vl, data[1]) || error("错误的参数个数")
			((data[2] >> sim & 0x1) != 0x1) && error("该环境下不支持此命令")
			com = data[3]
			com == :pwd ? _pwd(fs) :
			com == :ls ? _ls(fs, vl==1 ? getdir(fs,v[2]) : fs.current) :
			com == :cd ? _cd(fs, v[2]) :
			com == :mkdir ? _mkdir(fs, v[2]) :
			com == :rmdir ? _rmdir(fs, v[2]) :
			com == :rm ? _rm(fs, v[2]) :
			com == :cp ? _cp(fs, v[2], v[3]) :
			com == :mv ? _mv(fs, v[2], v[3]) :
			nothing
		catch er
			isa(er, ErrorException) && throw(er)
			printstyled(er; color = :light_red)
			println()
		end
		println()
	end
end
