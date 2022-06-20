# git使用基础
Git 是目前使用最广泛的（分布式）版本控制系统之一\
[中文book](https://git-scm.com/book/zh/v2/) | [git关卡式挑战](https://learngitbranching.js.org/?locale=zh_CN)

## 安装
[Git 官网](https://git-scm.com/downloads)

## 信息配置
在`git bash`中
```shell
git config --global user.name 你的用户名
git config --global user.email 你的邮箱
```

## 使用
!!! note
	如果你安装了[vscode](vscode.md)或类似高级编辑器，部分操作可以直接在侧边栏中进行

在使用`git`命令前，需要先将[当前目录](../../knowledge/filesystem.md#当前目录)设置为目标目录，然后可以使用`git init`初始化仓库\
如果别人已经建立了一个仓库，你想要把这个仓库拷贝到自己那里，可以使用`git clone 源地址` 命令\
可以使用`git status`查看当前仓库的状态，使用`git add 路径`将指定文件放入暂存区\
使用`git commit -m "更新信息"`进行更新

## 特殊文件
你可以在工作目录下放一个`.gitignore`文件，用于列出不希望被git记录的物品，可以使用通配符，例如
```plain
*.tmp
test.jl
```

[^1]: https://studyingfather.blog.luogu.org/git-guide
[^2]: https://oi-wiki.org/tools/git/
