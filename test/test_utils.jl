function _always_assert(condition::Bool)
    if !condition
        throw(ErrorException("assertion failed"))
    end
    return nothing
end

function _default_config()
    return Config(; pkg_server = "https://pkg.julialang.org")
end

function _contents_to_filename(; contents::String)
    filename = joinpath(mktempdir(; cleanup = true), "myfile")
    open(filename, "w") do io
        println(io, contents)
    end
    return filename
end

function project_contents_to_manifest_contents(cfg = _default_config();
                                               project_file_contents::AbstractString)::String
    proj_or_mnfst = Project(FileContents(project_file_contents))
    temporary_environment = PkgServerCacheWarmer.create_new_temporary_environment(cfg, proj_or_mnfst)
    project_directory = temporary_environment.env_with_project["JULIA_PROJECT"]::String

    proj_toml   = joinpath(project_directory, "Project.toml")
    man_toml    = joinpath(project_directory, "Manifest.toml")
    j_proj_toml = joinpath(project_directory, "JuliaProject.toml")
    j_man_toml  = joinpath(project_directory, "JuliaManifest.toml")

    _always_assert(isfile(proj_toml))
    _always_assert(!isfile(man_toml))
    _always_assert(!isfile(j_proj_toml))
    _always_assert(!isfile(j_man_toml))

    commands = PkgServerCacheWarmer.generate_julia_pkg_commands(
        cfg,
        temporary_environment,
        proj_or_mnfst,
    )
    PkgServerCacheWarmer.run_commands(commands)

    _always_assert(isfile(proj_toml))
    _always_assert(isfile(man_toml))
    _always_assert(!isfile(j_proj_toml))
    _always_assert(!isfile(j_man_toml))

    manifest_file_contents = read(man_toml, String)::String
    return manifest_file_contents
end
