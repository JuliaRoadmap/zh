# Sockets的使用
`Sockets`提供了网络套接字

一个在`localhost:2333`显示HTML的实例：
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
		print(sock,str)
	end
end
```

## 相关工具
- [ipaddress](https://www.ipaddress.com/)
