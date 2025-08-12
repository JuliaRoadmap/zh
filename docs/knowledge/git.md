# git使用基础
Git 是目前使用最广泛的分布式版本控制系统之一，除了版本控制软件本身的优势以外，还可以：
* 通过查看 `git history`，开发者可以看到一个项目开发的时间线
* 通过 `git branch`（分支），开发者可以在不用担心影响主代码的情况下进行开发

[中文 book](https://git-scm.com/book/zh/v2/) | [git 关卡式挑战](https://learngitbranching.js.org/?locale=zh_CN)

## 安装
### Windows
[Git 官网](https://git-scm.com/downloads)

* 安装包下载地址：https://gitforwindows.org/
* 国内镜像：https://npm.taobao.org/mirrors/git-for-windows/
* 清华镜像：https://mirrors.tuna.tsinghua.edu.cn/github-release/git-for-windows/git/

### Debian/Ubuntu
```shell
apt-get install libcurl4-gnutls-dev libexpat1-dev gettext 
apt-get install git
```

### Centos/RedHat
```shell
yum install curl-devel expat-devel gettext-devel 
yum install git-core
```

### Mac
一般 Mac 平台是自带 Git 的。

如果实在没有在 Mac 平台上安装 Git 最容易的当属使用图形化的 Git 安装工具，[下载地址](http://sourceforge.net/projects/git-osx-installer/)

若有 `Homebrew`，也可以用 `brew install git` 安装（或自学怎么安装 Homebrew）

## 信息配置
在 `git bash` 中配置
```shell
$ git config --global user.name 你的用户名
$ git config --global user.email 你的邮箱
```

## 换行配置
这个设置推荐默认选择第三项，然后对于有需要的项目分别配置：
```shell
$ git config core.autocrlf true/input/false
```

## 使用
!!! note
	如果你安装了 [vscode](vscode.md) 或类似高级编辑器，部分操作可以直接在侧边栏中进行

**仓库**（repo/repository）包含了一个项目的所有文件、文件夹。每个文件的修改、删除都能进行跟踪，以便任何时刻追踪历史或在将来某个时刻进行还原

在使用 `git` 命令前，需要先将[当前目录](../advanced/filesystem.md)设置为目标目录，然后可以使用 `git init` 初始化仓库。
如果别人已经建立了一个仓库，你想要把这个仓库拷贝到自己那里，可以使用 `git clone 源地址` 命令。
之后，可以使用 `git status` 查看当前仓库的状态，使用 `git add 路径` 将指定文件放入暂存区，
使用 `git commit -m "更新信息"` 进行更新。

## 特殊文件
你可以在工作目录下放一个 `.gitignore` 文件，用于列出不希望被 git 记录的物品，可以使用通配符，例如
```plain
*.tmp
test.jl
```

## 托管平台
可以使用基于 git 的代码托管平台远程存储（并可分享）你的代码。最常见的平台是 [Github](github.md)。

## 使用技巧
可以在 <https://www.conventionalcommits.org/zh-hans/v1.0.0/> 找到一个提交信息的非官方规范。

[^1]: https://studyingfather.blog.luogu.org/git-guide
[^2]: https://oi-wiki.org/tools/git/
[^3]: https://github.com/SAST-skill-docers/sast-skill-docs/blob/master/docs/basic/git.md
