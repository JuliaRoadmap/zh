# Sockets的使用
`Sockets` 提供了网络套接字

## IP
利用 `ip_str` 宏，可以方便地创建 IPv4 或 IPv6 实例
```julia-repl
julia> typeof(ip"0.0.0.0")
IPv4

julia> typeof(ip"1024:beef::beef::2")
IPv6
```

## 服务器
这是一个显示 HTML 的实例，可以在浏览器中输入 `localhost:2333` 查看
```jl
str="""
HTTP/1.1 200 OK
Content-Type: text/html;charset=UTF-8
	
<html>
	<body>
		<P>TEXT</P>
	</body>
</html>
""" # 按照标准HTTP Response格式

@async begin
	server=listen(2333)
	while true
		sock=accept(server)
		print(sock, str)
	end
end
```

## 相关工具
- [ipaddress](https://www.ipaddress.com/)
