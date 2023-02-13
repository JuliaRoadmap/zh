# Unicode
[Unicode 知识](../knowledge/unicode.md)

这个包提供了：
```julia-repl
julia> gr = Base.Unicode.graphemes("x𝗑𝘅𝘹𝙭𝚡ｘ𝐱×х⨯ⅹ")
length-12 GraphemeIterator{String} for "x𝗑𝘅𝘹𝙭𝚡ｘ𝐱×х⨯ⅹ"

julia> for c in gr
           println(c)
       end
x
...
```
