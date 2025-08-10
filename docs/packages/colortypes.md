# ColorTypes
`ColorTypes` 引入了一系列色彩相关的类型，其底层使用了 `FixedPointNumbers` 包优化
```julia-repl
julia> c=RGB(0.5,0.5,0.5)
RGB{Float64}(0.5,0.5,0.5)

julia> red(c) # 或 c.r
0.5

julia> c=RGBA(1,1,0,0)
RGBA{N0f8}(1.0,1.0,0.0,0.0)

julia> alpha(c)
0.0N0f8

julia> alpha(c).i
0x00
```

`0.11.0` 的类型层次树如下：
```plain
Colorant
|	Color
|	|	AbstractRGB
|	|	|	BGR
|	|	|	RGB
|	|	|	RGB24 m
|	|	|	RGBX
|	|	|	XRGB
|	|	DIN99
|	|	DIN99d
|	|	DIN99o
|	|	Gray
|	|	Gray24 m
|	|	HSI
|	|	HSL
|	|	HSV
|	|	LCHab
|	|	LCHuv
|	|	LMS
|	|	Lab
|	|	Luv
|	|	XYZ
|	|	YCbCr
|	|	YIQ
|	|	xyY
|	TransparentColor
|	|	AlphaColor
|	|	|	ABGR
|	|	|	ADIN99
|	|	|	ADIN99d
|	|	|	ADIN99o
|	|	|	AGray
|	|	|	AGray32 m
|	|	|	AHSI
|	|	|	AHSL
|	|	|	AHSV
|	|	|	ALCHab
|	|	|	ALCHuv
|	|	|	ALMS
|	|	|	ALab
|	|	|	ALuv
|	|	|	ARGB
|	|	|	ARGB32 m
|	|	|	AXYZ
|	|	|	AYCbCr
|	|	|	AYIQ
|	|	|	AxyY
|	|	ColorAlpha
|	|	|	BGRA
|	|	|	DIN99A
|	|	|	DIN99dA
|	|	|	DIN99oA
|	|	|	GrayA
|	|	|	HSIA
|	|	|	HSLA
|	|	|	HSVA
|	|	|	LCHabA
|	|	|	LCHuvA
|	|	|	LMSA
|	|	|	LabA
|	|	|	LuvA
|	|	|	RGBA
|	|	|	XYZA
|	|	|	YCbCrA
|	|	|	YIQA
|	|	|	xyYA
```
