abstract type ProjectOrManifest end

struct Project <: ProjectOrManifest
    contents::String
    function Project(; contents = nothing, filename = nothing)
        return new(get_file_contents(; contents, filename))
    end
end

struct Manifest <: ProjectOrManifest
    contents::String
    function Manifest(; contents = nothing, filename = nothing)
        return new(get_file_contents(; contents, filename))
    end
end
