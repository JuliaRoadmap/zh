# 文件系统基础
文件系统是由**文件**和**目录**组成的关于文件的系统，具有树状结构，实现了数据的存储、分级组织、访问获取等操作
!!! note
	在 Linux 等系统的底层实现中，目录被认为是“特殊文件”，文件系统中也可能存在一些特殊数据，此处不涉及

## 命名
为了区分，文件和目录可以命名，同一目录下命名不可相同。
文件名最后一个 `.` 后的称为文件后缀。
有一些字符不可用于命名（如 `/`）且名字长度是有限的。

## 根目录
根目录处在文件系统最*根源*的位置，文件系统中任何资源均直接或间接处在根目录中，根目录没有上一级目录
!!! note
	部分系统存在 `root-jail` 机制，用于把非管理员用户限制在一定区域内防止潜在的破坏

## 路径
路径分为**相对路径**和**绝对路径**，通常通过目录名和最后的文件名进行索引。
* 路径各层使用 `/` 分隔
	* 在 Windows 中，也可以使用 `\` 分隔（注意字符串中需用 `\\` 转义），且部分命令可能不兼容 `/`
* 绝对路径以 `/` 开头
	* 在 Windows 中，是形如 `C:\` 的磁盘前缀
* 单个 `.` 可以忽视（在命令行下直接调用 `foo.exe` 可能为防歧义不允许，需要改成 `./foo.exe`）
* `..` 表示跳到上一级目录

相对路径即表示在已知**当前路径**时，在其基础上“行走”得到的目标

## 常见命令
!!! note
	可以在本地命令行中尝试或使用[虚拟操作系统](../pieces/virtualfs.jl)（注：不建议参考该代码）。
	以下 unix 表示在大部分类 unix 系统中，windows 表示 windows 系统，julia 表示 julia 函数

### 显示当前目录
命令：unix, julia: `pwd` | windows: `chdir`\
用途：显示当前目录的绝对路径
```shell
vfs> sim unix

vfs> pwd
/home
```

### 列举
参数：目标目录路径（默认是当前目录）\
命令：unix: `ls` | windows: `dir` | julia: `readdir`\
用途：列出指定目录下的目录和文件
```shell
vfs> ls
hello.txt
```

### 切换目录
参数：目标目录路径\
命令：`cd`\
用途：切换当前目录至目标目录\
备注：windows 下需要在 `cd` 后添加额外参数 `/D` 切换
```shell
vfs> cd ../

vfs> ls
home/
```

### 建立目录
参数：目标目录路径\
命令：unix: `mkdir` | windows: `mkdir`, `md` | julia: `mkdir`
```shell
vfs> mkdir foo

vfs> ls
home/
foo/
```

## 删除目录
参数：目标目录路径\
命令：unix: `rmdir` | windows: `rmdir`, `rd` | julia: `rm`
```shell
vfs> rmdir foo

vfs> ls
home/
```

### 删除文件
参数：目标文件路径\
命令：unix, julia: `rm` | windows: `del`
```shell
vfs> rm home/hello.txt

vfs> ls home
```

### 复制
参数：原路径，目标所在目录路径\
命令：unix, julia: `cp` | windows: `copy`
```shell
vfs> ls
home/
b/
a/

vfs> ls a
one/
two/

vfs> cp a/one b

vfs> ls b
one/
```

### 移动
参数：原路径，目标所在目录路径\
命令：`mv`
```shell
vfs> mv a/two b

vfs> ls a
one/
```

### 重命名
参数：原路径，目标路径\
命令：unix: `mv` | windows: `ren` | julia: `rename`

### 比较文件
参阅 `fc`、`diff`

## 权限
操作系统允许设置文件、目录的读、写、运行权限（参阅 `chmod`，`chown`）。
在没有权限时以对应方式访问，会抛出 `SystemError`

```check newbie
## 练习
- 尝试做一个统计工具，统计目录下的文件数目、总行数及总字符数（假设全为 UTF-8 格式的文本文件） [示例](../pieces/wordcount.jl)
```
