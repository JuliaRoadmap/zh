abstract type 特殊结构 end
mutable struct 文件
	par::Union{特殊结构,Nothing}
	name::String
	content::String
end
mutable struct 目录<:特殊结构
	par::Union{目录,Nothing}
	name::String
	files::Dict{String,文件}
	dirs::Dict{String,目录}
end
目录(par::Union{目录,Nothing},name::String)=目录(par,name,Dict{String,文件}(),Dict{String,目录}())
mutable struct 文件系统
	root::目录
	current::目录
end
function 文件系统()
	rt=目录(nothing,"")
	cu=rt
	return 文件系统(rt,cu)
end

function getpath(dir::目录;full::Bool=false,relative::目录=dir)
	if full
		s=dir.name
		if dir.par===nothing
			return "/"
		end
		t=dir
		while true
			t=t.par
			if t.par===nothing
				return "/$s"
			end
			s="$(t.name)/$s"
		end
	else
		s=dir.name
		t=dir
		while true
			t=t.par
			if t===nothing
				return "/$s"
			elseif t==relative
				return s
			end
			s="$(t.name)/$s"
		end
	end
end
function getdir(dir::目录,path::Vector{T}) where T<:AbstractString
	res=dir
	for i in path
		if i==".."
			if res!==nothing
				res=res.par
			end
		elseif i!="."
			if haskey(res.dirs,i)
				res=@inbounds res.dirs[i]
			else
				throw("未在$(getpath(res))找到下一级目录")
			end
		end
	end
	return res
end
function getdir(fs::文件系统,path::AbstractString)
	v=splitpath(path)
	if isempty(v) throw("路径不能为空") end
	d=fs.current
	if v[1]=="/"
		d=fs.root
		popfirst!(v)
	end
	return getdir(d,v)
end
function getpardir(fs::文件系统,path::AbstractString)::Pair
	v=splitpath(path)
	if isempty(v)
		throw("路径不能为空")
	end
	d=fs.current
	if v[1]=="/"
		d=fs.root
		popfirst!(v)
		if isempty(v)
			throw("路径不能为空")
		end
	end
	last=pop!(v)
	return Pair(getdir(d,v),last)
end
function getfile(fs::文件系统,path::AbstractString)
	v=splitpath(path)
	if isempty(v)
		throw("路径不能为空")
	end
	fname=pop!(v)
	d=fs.current
	if v[1]=="/"
		d=fs.root
		popfirst!(v)
	end
	dir=getdir(d,v)
	if haskey(dir.files,fname)
		return @inbounds dir.files[fname]
	else
		throw("未找到该文件")
	end
end

_pwd(fs::文件系统)=getpath(fs.current;full=true)
function _ls(fs::文件系统,target::目录=fs.current)
	for i in target.dirs
		println(i.first,"/")
	end
	for i in target.files
		println(i.first)
	end
end
function _cd(fs::文件系统,path::AbstractString)
	fs.current=getdir(fs,path)
end
function _mkdir(fs::文件系统,path::AbstractString;force::Bool=false)
	pair=getpardir(fs,path)
	dir=pair.first
	name=pair.second
	if force
		dir.dirs[name]=目录(dir,name)
		return
	end
	if haskey(dir.dirs,name)
		throw("同名目录已存在")
	elseif haskey(dir.files,name)
		throw("同名文件已存在")
	else
		dir.dirs[name]=目录(dir,name)
	end
end
function _rmdir(fs::文件系统,path::AbstractString)
	pair=getpardir(fs,path)
	dir=pair.first
	name=pair.second
	q=fs.current
	while q!==nothing
		if q==dir
			throw("删除的目录不能包含当前目录")
		end
		q=q.par
	end
	delete!(dir.dirs,name)
end
function _rm(fs::文件系统,path::AbstractString)
	(dir,name)=getpardir(fs,path)
	if haskey(dir.dirs,name)
		delete!(dir.dirs,name)
	elseif haskey(dir.files,name)
		delete!(dir.files,name)
	else
		throw("未找到该资源")
	end
end
function _cp(fs::文件系统,from::AbstractString,to::AbstractString;force::Bool=false)
	(dir,name)=getpardir(fs,from)
	if haskey(dir.dirs,name)
		dirto=getdir(fs,to)
		ori=@inbounds(dir.dirs[name])
		if !force
			haskey(dirto.dirs,name) ? throw("同名目录已存在") :
			haskey(dirto.files,name) ? throw("同名文件已存在") : nothing
		end
		dirto.dirs[name]=目录(dirto,name,deepcopy(ori.files),deepcopy(ori.dirs))
	elseif haskey(dir.files,name)
		dirto=getdir(fs,to)
		content=@inbounds(dir.files[name].content)
		if !force
			haskey(dirto.dirs,name) ? throw("同名目录已存在") :
			haskey(dirto.files,name) ? throw("同名文件已存在") : nothing
		end
		dirto.files[name]=文件(dirto,deepcopy(name),deepcopy(content))
	else
		throw("未找到该资源")
	end
end
function _mv(fs::文件系统,from::AbstractString,to::AbstractString;force::Bool=false)
	(dir,name)=getpardir(fs,from)
	if haskey(dir.dirs,name)
		dirto=getdir(fs,to)
		ori=@inbounds(dir.dirs[name])
		if !force
			haskey(dirto.dirs,name) ? throw("同名目录已存在") :
			haskey(dirto.files,name) ? throw("同名文件已存在") : nothing
		end
		dirto.dirs[name]=目录(dirto,name,ori.files,ori.dirs)
		delete!(dir.dirs,name)
	elseif haskey(dir.files,name)
		dirto=getdir(fs,to)
		content=@inbounds(dir.files[name].content)
		if !force
			haskey(dirto.dirs,name) ? throw("同名目录已存在") :
			haskey(dirto.files,name) ? throw("同名文件已存在") : nothing
		end
		dirto.files[name]=文件(dirto,name,content)
		delete!(dir.files,name)
	else
		throw("未找到该资源")
	end
end
const simdata=Dict{String,Tuple{UnitRange,UInt8,Symbol}}(
	# "sim"=>(1:1,0x7,"")
	"pwd" => (0:0,0x5,:pwd),
	"chdir" => (0:0,0x2,:pwd),
	"ls" => (0:1,0x1,:ls),
	"dir" => (0:1,0x2,:ls),
	"readdir" => (0:1,0x4,:ls),
	"cd" => (1:1,0x7,:cd),
	"mkdir" => (1:1,0x7,:mkdir),
	"md" => (1:1,0x2,:mkdir),
	"rmdir" => (1:1,0x3,:rmdir),
	"rm" => (1:1,0x5,:rm),
	"del" => (1:1,0x2,:rm),
	"cp" => (2:2,0x5,:cp),
	"copy" => (2:2,0x2,:cp),
	"mv" => (2:2,0x7,:mv),
)
function init()
	fs=文件系统()
	_mkdir(fs,"home")
	_cd(fs,"home")
	fs.current.files["hello.txt"]=文件(fs.current,"hello.txt","你好")
	sim=0x0
	while true
		print("vfs> ")
		s=readline()
		try
			v=split(s)
			if isempty(v)
				continue
			end
			com=""
			if v[1]=="sim"
				sim=v[2]=="unix" ? 0x0 :
					v[2]=="windows" ? 0x1 :
					v[2]=="julia" ? 0x2 :
					printstyled("不支持的模拟对象";color=:light_yellow)
				println()
				continue
			elseif v[1]=="quit"
				return
			else
				name=String(v[1])
				if !haskey(simdata,name)
					throw("不支持的命令")
				end
				data=@inbounds simdata[name]
				vl=length(v)-1
				if !in(vl,data[1])
					throw("错误的参数个数")
				end
				if data[2]>>sim&0x1 != 0x1
					throw("该环境不支持该命令")
				end
				com=data[3]
			end
			com==:pwd ? println(_pwd(fs)) :
			com==:ls ? _ls(fs,vl==1 ? getdir(fs,v[2]) : fs.current) :
			com==:cd ? _cd(fs,v[2]) :
			com==:mkdir ? _mkdir(fs,v[2]) :
			com==:rmdir ? _rmdir(fs,v[2]) :
			com==:rm ? _rm(fs,v[2]) :
			com==:cp ? _cp(fs,v[2],v[3]) :
			com==:mv ? _mv(fs,v[2],v[3]) :
			throw("程序出错")
		catch er
			if isa(er,String)
				printstyled(er;color=:light_red)
				println()
			else
				throw(er)
			end
		end
		println()
	end
end
