# CRC32c的使用
CRC32c提供了CRC-32c校验函数`crc32c`，它的原型是`crc32c(data, crc::UInt32=0x00000000)`，其中data可以是`Array{UInt8}`实例（或它的连续子数组）或字符串。crc被传递用于与结果混合；在技术上，按照小端计算
!!! note
	`crc32c(data2, crc32c(data1))`相当于`crc32c([data1; data2])`

!!! warn
	校验结果可能与[大小端](https://www.ruanyifeng.com/blog/2022/06/endianness-analysis.html)、字符串编码有关

`crc32c(io::IO, [nb::Integer,] crc::UInt32=0x00000000)`从io中读取至多nb个字节并返回CRC-32c校验结果（不指定nb时全部读入）
