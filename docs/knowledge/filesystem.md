# 文件系统基础
文件系统是由 `文件` 和 `目录` 组成的关于文件的系统，具有树状结构，实现了数据的存储、分级组织、访问获取等操作
!!! note
	在 linux 等系统的底层实现中，`目录` 被认为是「特殊文件」，文件系统中也可能存在一些特殊数据，此处不涉及

## 根目录
根目录处在文件系统最*根源*的位置，文件系统中任何资源均直接或间接处在根目录中，根目录没有上一级目录
!!! note
	部分系统存在`root-jail`机制，用于把非管理员用户限制在一定区域内防止潜在的破坏

## 当前目录
为便于操作，大部分文件系统允许一个当前目录以允许相对路径

## 路径
路径分为 `相对路径` 和 `绝对路径`，通过目录名、文件名进行索引
* 路径各层使用 `/` 分隔
* 绝对路径以 `/` 开头（可能有磁盘前缀）
* 单个 `.` 可以忽视（在命令行下直接调用 `foo.exe` 可能为防歧义不允许，需要改成 `./foo.exe`）
* `..` 表示跳到上一级目录
* 在 windows 中，也可以使用 `\` 分隔（注意字符串中需用 `\\` 转义），且部分命令可能不兼容 `/`

## 常见命令
!!! note
	可以在本地命令行中尝试或使用[虚拟操作系统](../pieces/virtualfs.jl)\
	以下unix表示在大部分类unix系统中，windows表示windows系统，julia表示julia函数

### 显示当前目录
命令：unix: pwd | windows:chdir | julia:pwd\
用途：显示当前目录的绝对路径
```shell
vfs> sim unix

vfs> pwd
/home
```

### 列举
参数：目标目录路径（默认是当前目录）\
命令：unix:ls | windows:ls | julia:readdir\
用途：列出指定目录下的目录和文件
```shell
vfs> ls
hello.txt
```

### 切换目录
参数：目标目录路径\
命令：cd\
用途：切换当前目录至目标目录\
备注：windows下需要在`cd`后添加额外参数`/D`
```shell
vfs> cd ../

vfs> ls
home/
```

### 建立目录
参数：目标目录路径\
命令：unix:mkdir | windows:mkdir,md | julia:mkdir
```shell
vfs> mkdir foo

vfs> ls
home/
foo/
```

## 删除目录
参数：目标目录路径\
命令：unix:rmdir | windows:rmdir,rd | julia:rm
```shell
vfs> rmdir foo

vfs> ls
home/
```

### 删除文件
参数：目标文件路径\
命令：unix:rm | windows:del | julia:rm
```shell
vfs> rm home/hello.txt

vfs> ls home
```

### 复制
参数：原路径，目标所在目录路径\
命令：unix:cp | windows:copy | julia:cp
```shell
vfs> ls
home/
b/
a/

vfs> ls a
1/
2/

vfs> cp a/1 b

vfs> ls b
1/
```

### 移动
参数：原路径，目标所在目录路径\
命令：mv
```shell
vfs> mv a/2 b

vfs> ls a
1/
```

### 重命名
参数：原路径，目标路径\
命令：unix:mv | windows:ren | julia:rename

### 比较文件
参阅 `fc`、`diff`

## 权限
操作系统允许设置文件、目录的读、写、运行权限（参阅`chmod`，`chown`）。
在没有权限时以对应方式访问，会抛出 `SystemError`

```check newbie
## 练习
- 尝试做一个统计工具，统计目录下的文件数目、总行数及总字符数（假设全为文本文件） [示例](../pieces/wordcount.jl)
```
