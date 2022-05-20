# Downloads的使用
Downloads是一个[标准库](stdlib.md)，基于`Curl`，用于满足基本的[爬虫](../knowledge/spider.md)需求\
Downloads支持的各项设置较少，如需更多设置请使用HTTPS包

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
