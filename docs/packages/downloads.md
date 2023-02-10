# Downloads
Downloads 是一个[标准库](stdlib.md)，基于 `Curl`，用于满足基本的[爬虫](../knowledge/spider.md)需求。
Downloads 支持的各项设置较少，如需更多设置可使用 [HTTP](http.md) 包

## request
原型：
```plain
request(url;
	[ input = <none>, ]
	[ output = <none>, ]
	[ method = input ? "PUT" : output ? "GET" : "HEAD", ]
	[ headers = <none>, ]
	[ timeout = <none>, ]
	[ progress = <none>, ]
	[ verbose = false, ]
	[ throw = true, ]
	[ downloader = <default>, ]
) -> Union{Response, RequestError}
```

```julia-repl
julia> io=IOBuffer()
IOBuffer(data=UInt8[...], readable=true, writable=true, seekable=true, append=false, size=0, maxsize=Inf, ptr=1, mark=-1)

julia> Downloads.request("http://httpbin.org/user-agent";output=io)
Response("http", "http://httpbin.org/user-agent", 200
...

julia> String(take!(io))
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0{\n  \"user-agent\": \"curl/7.73.0 julia/1.6\"\n}\n"
```

## download
建议将下载作为它的唯一功能，其它功能用 `request` 实现
```julia-repl
julia> fio=open("D:/foo.png","w")
IOStream(<file D:/foo.png>)

julia> Downloads.download("http://httpbin.org/image/png",fio);
```
