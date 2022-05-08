# 文件系统基础
文件系统是由`文件`和`目录`组成的树状结构
!!! note
	`目录`有时被认为是`文件`，文件系统中可能存在一些特殊数据，此处不涉及

## 根目录
根目录处在文件系统最*根源*的位置，文件系统中任何资源均直接或间接处在根目录中，根目录没有上一级目录
!!! note
	部分系统存在`root-jail`机制，用于把非管理员用户限制在一定区域内防止潜在的破坏

## 当前目录
为便于操作，大部分文件系统允许一个当前目录以允许相对路径

## 路径
路径分为`相对路径`和`绝对路径`，通过目录名、文件名进行索引
* 路径各层使用`/`分隔
* 绝对路径以`/`开头（可能有磁盘前缀）
* 单个`.`可以忽视（在命令行下直接调用`foo.exe`可能为防歧义不允许，需要改成`./foo.exe`）
* `..`表示跳到上一级目录
* 在windows中，也可以使用`\`分隔

## 常见命令
!!! note
	可以在本地命令行中尝试或使用[虚拟操作系统](../pieces/virtualfs.jl)\
	以下unix表示在大部分类unix系统中，windows表示windows系统，julia表示julia函数（暂时仍用命令格式），虚拟操作系统中使用`sim 目标`切换模拟环境

### 显示当前目录
命令：unix: pwd | windows:chdir | julia:pwd\
用途：显示当前目录的绝对路径
```shell
vfs> sim unix

vfs> pwd
/home
```

### 列表
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
用途：切换当前目录至目标目录
```jl
vfs> cd ../

vfs> ls
home/
```

### 建立目录
参数：目标目录路径\
命令：unix:mkdir | windows:mkdir,md | julia:mkdir

## 删除目录
参数：目标目录路径\
命令：unix:rmdir | windows:rmdir,rd | julia:rm

## 权限
