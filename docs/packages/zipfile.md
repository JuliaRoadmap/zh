# ZipFile的使用
`ZipFile` 提供了对 [`.zip` 格式](https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT)文件的读写支持

## 读
```julia-repl
julia> r=ZipFile.Reader("D:/foo.zip");

julia> fs=r.files;

julia> fs[1].name
"foo/"

julia> fs[1].method # 此处目录被视作文件
0x0000

julia> u=readavailable(fs[2]); # 获取数据（Vector{UInt8}）

julia> close(r)
```

## 写
```julia-repl
julia> w=ZipFile.Writer("D:/bar.zip")
ZipFile.Writer for IOStream(<file D:/bar.zip>) containing 0 files:

uncompressedsize method  mtime            name
----------------------------------------------


julia> txt=ZipFile.addfile(w,"1.txt")
ZipFile.WritableFile(name=1.txt, method=Store, uncompresssedsize=0, compressedsize=0, mtime=1.653037798e9)

julia> write(txt,u)
1125

julia> close(txt)
IOStream(<file D:/bar.zip>)

julia> close(w)
```
