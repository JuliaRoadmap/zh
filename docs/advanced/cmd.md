# 命令
## Cmd
`Cmd` 是Julia中表示指令的数据类型，使用一对 ``` `` ``` 定义，例如 `` `cd ../` ``。
用构造函数 `Cmd(cmd::Cmd; ignorestatus=false, detach=false, windows_verbatim=false, windows_hide=false, env, dir)` 定义状态，其中
* ignorestatus 为 true 时，命令返回值非 0 不会抛出异常
* detach 为 true 时，产生新进程运行
* windows_verbatim 为 true 时，将把字符串原封不动传递
* windows_hide 为 true 时，在一个允许窗口且没有打开窗口环境下仍不生成新窗口
* env 设置环境变量
* dir 设置默认文件夹

使用 `run(cmd)` 运行指令，使用 `run(cmd1 & cmd2 ... &cmdn)` 并行运行命令。
要读取指令结果，可以使用 `read(cmd)`（得到 `Vector{UInt8}` 数组）或 `read(cmd, String)` 得到字符串

## Base.OrCmds
参阅[管道](io.md#管道)
