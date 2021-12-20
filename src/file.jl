function get_file_contents(; contents::Union{String, Nothing} = nothing,
                             filename::Union{String, Nothing} = nothing)
    if     (contents !== nothing) && (filename === nothing)
        return contents::String
    elseif (contents === nothing) && (filename !== nothing)
        return read(filename, String)::String
    elseif (contents !== nothing) && (filename !== nothing)
        msg = string(
            "You cannot provide both `contents` and `filename`; ",
            "you can only provide one.",
        )
        throw(ErrorException(msg))
    end
    msg = "You must provide exactly one of either `contents` or `filename`"
    throw(ErrorException(msg))
end
