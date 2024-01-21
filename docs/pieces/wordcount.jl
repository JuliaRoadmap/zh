function wordcount(path::AbstractString)
    info = wordinfo(path)
    println("文件数：", info[1])
    println("行数：", info[2])
    println("字符数：", info[3])
end

function wordinfo(path::AbstractString)
    if isfile(path)
        io = open(path, "r")
        str = read(io, String)
        close(io)
        return (1, count("\n", str), length(str))
    elseif isdir(path)
        vec = readdir(path; join=true, sort=false)
        file, line, char = (0, 0, 0)
        for child in vec
            n_file, n_line, n_char = wordinfo(child)
            file += n_file
            line += n_line
            char += n_char
        end
        return (file, line, char)
    else
        error("invalid path $path")
    end
end
