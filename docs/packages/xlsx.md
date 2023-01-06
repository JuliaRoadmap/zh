# XLSX的使用
XLSX 是 Julia 生态系统中处理 Excel 数据的最积极维护的包，另外一个优点是，XLSX.jl 是用纯 Julia 编写的，这使得可以轻松地检查和理解指令背后发生的事情。\
先导入包并创建一个[DataFrame](dataframes.md#dataframe类型)量：
```julia-repl
using DataFrames, XLSX:
	eachtablerow,
	readxlsx,
	writetable

julia> fr=DataFrame(;name=["sand","ice"], trans=["沙子","冰块"])
2×2 DataFrame
 Row │ name    trans
     │ String  String
─────┼────────────────
   1 │ sand    沙子
   2 │ ice     冰块

# 为了写入文件，我们为数据和列名定义一个辅助函数：
function write_xlsx(path, df::DataFrame)
    data = collect(eachcol(df))
    cols = names(df)
    writetable(path, data, cols)
end

julia> write_xlsx("D:/1.xlsx", fr)

# 读取数据时，可以看到数据在 XLSXFile 类型中，并且可以像访问 Dict 一样访问所需的 sheet：
julia> xf=readxlsx("D:/1.xlsx")
XLSXFile("1.xlsx") containing 1 Worksheet
            sheetname size          range
-------------------------------------------------
               Sheet1 3x2           A1:B3     


julia> sheet=xf["Sheet1"]
3×2 XLSX.Worksheet: ["Sheet1"](A1:B3)

julia> DataFrame(eachtablerow(sheet))
2×2 DataFrame
 Row │ name  trans
     │ Any   Any
─────┼─────────────
   1 │ sand  沙子
   2 │ ice   冰块
```

## 参阅
本节只介绍了 XLSX 的基础知识，但它还提供了更强大的用法和自定义功能
- [文档](https://felipenoris.github.io/XLSX.jl/stable/)

[^1]: https://cn.julialang.org/JuliaDataScience/load_save
