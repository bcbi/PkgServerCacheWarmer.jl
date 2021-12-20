Base.@kwdef struct Config
    pkg_server::String
    before_script::String = _DEFAULT_BEFORE_SCRIPT
    script::String        = _DEFAULT_SCRIPT
    after_script::String  = _DEFAULT_AFTER_SCRIPT
end

Base.@kwdef struct TemporaryEnvironment
    env_with_project::Dict{String, String}
    env_without_project::Dict{String, String}
end

Base.@kwdef struct Commands
    cmd_1_before_script::Cmd
    cmd_2_script::Cmd
    cmd_3_after_script::Cmd
end

Base.@kwdef struct ProjectFileOrManifestFile
    contents::String
    name::String
    before_script::Union{String, Nothing} = nothing
    script::Union{String, Nothing} = nothing
    after_script::Union{String, Nothing} = nothing
end

function Project(contents::AbstractString;
                 before_script = nothing,
                 script = nothing,
                 after_script = nothing)
    name = "Project.toml"
    result = ProjectFileOrManifestFile(;
        contents,
        name,
        before_script,
        script,
        after_script,
    )
    return result
end

function Manifest(contents::AbstractString;
                 before_script = nothing,
                 script = nothing,
                 after_script = nothing)
    name = "Manifest.toml"
    result = ProjectFileOrManifestFile(;
        contents,
        name,
        before_script,
        script,
        after_script,
    )
    return result
end

FileName(filename::AbstractString)::String = read(filename, String)::String
FileContents(contents::AbstractString)::String = convert(String, contents)::String
