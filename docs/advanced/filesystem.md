# 文件系统
文件系统的相关内容在 `Base.Filesystem` 中，可以查看帮助文档。

## 基础知识
文件系统是由**文件**和**目录**组成的关于文件的系统，具有树状结构，实现了数据的存储、分级组织、访问获取等操作
!!! note
	在 Linux 等系统的底层实现中，目录被认为是“特殊文件”，文件系统中也可能存在特殊的配置、权限数据，此处不涉及。

### 命名
文件和目录可以被命名来区分，同一目录下命名不可相同。

文件名最后一个 `.` 后的称为文件后缀。文件中也可以没有 `.` 或有多个 `.`

有一些字符不可用于命名（如 `/`）且名字长度是有限的。

### 根目录
根目录处在文件系统最*根源*的位置，文件系统中任何资源均直接或间接处在根目录中，根目录没有上一级目录。
!!! note
	部分系统存在 `root-jail` 机制，用于把非管理员用户限制在一定区域内防止潜在的破坏

### 路径
路径分为**相对路径**和**绝对路径**，通常通过目录名和最后的文件名进行索引。
* 路径各层使用 `/` 分隔
	* 在 Windows 中，也可以使用 `\` 分隔（注意字符串中需用 `\\` 转义），且部分命令可能不兼容 `/`
* 绝对路径以 `/` 开头
	* 在 Windows 中，是形如 `C:\` 的磁盘前缀
* 单个 `.` 可以忽视（在命令行下直接调用 `foo.exe` 可能为防歧义不允许，需要改成 `./foo.exe`）
* `..` 表示跳到上一级目录

相对路径即表示在已知**当前路径**时，在当前路径基础上“行走”得到的目标。

## 文件系统命令
### 获取当前目录
在 Unix 与 Julia 中可以用 `pwd` 命令获取当前目录。一般来说，当前目录默认是*当前用户的根目录*（Julia 中可用 `homedir()` 获取）。

```julia-repl
julia> pwd()
"C:\\Users\\username"
```

在 Windows cmd 中可以使用 `chdir` 获取。
```shell
C:\Users\username>chdir
C:\Users\username
```

### 切换目录
切换当前目录至指定的目录。特别地，Windows cmd 中需要在 `cd` 后添加额外参数 `/D` 切换
* 参数：目标目录路径
* 命令：`cd`

Julia 中额外提供了方法 `cd(f::Function, dir::AbstractString=homedir())`，这会在“当前目录是指定目录”的状态下运行 `f` 而不影响当前目录状态。

### 列举目录内容
列出指定目录下的目录和文件
* 参数：目标目录路径（默认是当前目录）
* 命令：unix: `ls` | windows cmd: `dir` | julia: `readdir`

例如在 Windows 下会提供这些信息：
```shell
d:\road-map\zh>dir
 驱动器 D 中的卷是 Data
 卷的序列号是 ...

 d:\road-map\zh 的目录

2025/08/10  19:47    <DIR>          .
2025/08/10  19:47    <DIR>          ..
2025/08/09  20:26    <DIR>          .github
2025/08/09  20:26                16 .gitignore
2025/08/09  20:26    <DIR>          assets
2025/08/10  19:41             1,958 CONTRIBUTING.md
2025/08/10  19:39    <DIR>          docs
2025/08/10  19:33               337 DoctreeBuild.toml
2025/08/09  20:26               337 MAINTAINING.md
2025/08/11  19:10             1,569 README.md
               5 个文件          4,217 字节
               5 个目录            ... 可用字节
```

相应地，在 Julia 中将获取该目录下的各个对象名称
```julia-repl
julia> readdir("d:/road-map/zh")
9-element Vector{String}:
 ".git"
 ".github"
 ".gitignore"
 "CONTRIBUTING.md"
 "DoctreeBuild.toml"
 "MAINTAINING.md"
 "README.md"
 "assets"
 "docs"
```

### 其它命令
建立目录
* 参数：目标目录路径
* 命令：unix: `mkdir` | windows cmd: `mkdir`, `md` | julia: `mkdir`

删除目录
* 参数：目标目录路径
* 命令：unix: `rmdir` | windows cmd: `rmdir`, `rd` | julia: `rm`

删除文件
* 参数：目标文件路径
* 命令：unix, julia: `rm` | windows cmd: `del`

复制
* 参数：原路径，目标所在目录路径
* 命令：unix, julia: `cp` | windows cmd: `copy`

移动
* 参数：原路径，目标所在目录路径
* 命令：`mv`

重命名
* 参数：原路径，目标路径
* 命令：unix: `mv` | windows: `ren` | julia: `rename`

比较文件：参阅 `fc`、`diff`

## 权限
操作系统允许设置文件、目录的读、写、运行权限（参阅 `chmod`，`chown`）。

在 Julia 中，进行没有权限进行的操作会抛出 `SystemError`

## joinpath
`joinpath` 可以用于将路径拼接，但不会检测路径是否存在。
```julia-repl
julia> joinpath("/dev","null") # 一些操作系统下默认使用 "\" 分隔
"/dev\\null"

julia> joinpath("/dev","/null/1") # 后者是绝对路径，覆盖前者
"/null/1"
```

## 练习
- 尝试做一个统计工具，统计目录下的文件数目、总行数及总字符数（假设全为 UTF-8 格式的文本文件）
