# CSV的使用
`Comma-separated-values(CSV)`文件是有效的表格存储方式，使用`.csv`作为扩展名。\
CSV 文件相比其他数据存储文件有两点优势
1. 正如名称所指示的那样，它使用逗号来分隔存储值
2. 可以使用简单的文本编辑器读取数据（这与许多需要专有软件的数据格式不同，例如[Excel](xlsx.md)）

先创建一个[DataFrame](dataframes.md#dataframe类型)量：
```julia-repl
julia> using DataFrames

julia> fr=DataFrame(;name=["sand","ice"], trans=["沙子","冰块"])
2×2 DataFrame
 Row │ name    trans
     │ String  String
─────┼────────────────
   1 │ sand    沙子
   2 │ ice     冰块
```

用`CSV.write`写入[流](../advanced/io.md)中
```julia-repl
julia> using CSV

julia> CSV.write(stdout,fr);
name,trans
sand,沙子
ice,冰块
```

对于特殊的数据（例如带逗号），CSV会以特别的方式处理：
```julia-repl
julia> fr.name[2]="i,ce"
"i,ce"

julia> fr
2×2 DataFrame
 Row │ name    trans
     │ String  String
─────┼────────────────
   1 │ sand    沙子
   2 │ i,ce    冰块

julia> CSV.write(stdout,fr);
name,trans
sand,沙子
"i,ce",冰块
```

解决此问题的另一种常见方法是将数据写入`tab-separated values(TSV)`文件格式。该格式假设数据不包含制表符，而这通常是成立的
```julia-repl
julia> CSV.write(stdout,fr;delim='\t');
name    trans
sand    沙子
i,ce    冰块
```

反过来，可以用`CSV.read`从流中读入：
```julia-repl
julia> buf=IOBuffer("name\ttrans\nsand\t沙子\ni,ce\t冰块");

julia> CSV.read(buf,DataFrame;delim='\t') # 需指定读入类型
2×2 DataFrame
 Row │ name    trans
     │ String  String
─────┼────────────────
   1 │ sand    沙子
   2 │ i,ce    冰块
```

## 参阅
- [CSV文档](https://csv.juliadata.org/stable/)

[^1]: https://cn.julialang.org/JuliaDataScience/load_save
