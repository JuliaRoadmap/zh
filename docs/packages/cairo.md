# Cairo的使用
Cairo是一个用于2D绘图的包，它是`Graphics`所定义的绘图函数的实现，通常用于与[Gtk](gtk.md)中的canvas交互\
Cairo的基本使用方式已在[文档](https://docs.juliahub.com/Cairo/l6vnT/1.0.5/)中，交互方式在[Gtk文档](https://docs.juliahub.com/Gtk/Vjnq0/1.2.1/manual/canvas/)中

## 图像显示
除了使用`Cairo`自带的函数打开图像文件外，还可以
1. 使用`ImageIO`包打开指定文件，得到`Matrix{RGB}`
2. 转成`Matrix{T} T<:Union{ColorTypes.ARGB32, ColorTypes.RGB24}`（参考[ColorTypes](colortypes.md)）
3. 使用`CairoImageSurface`转成`CairoSurface`
4. 使用`set_source_surface`

需注意的是，`ImageIO`的坐标系与`Cairo`的坐标系有所不同
