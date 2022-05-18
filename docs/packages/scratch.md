# Scratch的使用
Scratch 给包管理的数据缓存提供了容器

可以用`get_scratch!([parent_pkg = nothing], key::AbstractString, calling_pkg = parent_pkg)`得到一个地址，这个地址通常在`~/.julia/scratchspaces/模块的UUID/键`
