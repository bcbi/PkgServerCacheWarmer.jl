function create_new_temporary_environment(cfg::Config,
                                          proj_or_mnfst::ProjectFileOrManifestFile)
    project_directory = mktempdir(; cleanup = true)
    _write_project_or_manifest(proj_or_mnfst; project_directory)

    env_without_project = copy(ENV)

    _delete_julia_env_vars!(env_without_project)

    env_without_project["JULIA_DEPOT_PATH"] = mktempdir(; cleanup = true)
    env_without_project["JULIA_PKG_SERVER"] = strip(cfg.pkg_server)

    env_with_project = copy(env_without_project)
    env_with_project["JULIA_PROJECT"] = project_directory

    temporary_environment = TemporaryEnvironment(;
        env_with_project,
        env_without_project,
    )

    return temporary_environment
end

function _write_project_or_manifest(proj_or_mnfst::ProjectFileOrManifestFile;
                                    project_directory::String)
    file_contents = proj_or_mnfst.contents
    full_file_path = joinpath(project_directory, proj_or_mnfst.name)
    open(full_file_path, "w") do io
        println(io, file_contents)
    end
    return nothing
end

function _delete_julia_env_vars!(env::AbstractDict)
    for k in keys(env)
        if _is_julia_env_var(k)
            delete!(env, k)
        end
    end
    return nothing
end

@inline function _is_julia_env_var(name::AbstractString)
    startswith(lowercase(strip(name)), "julia_") && return true
    startswith(lowercase(strip(name)), "julia-") && return true
    return false
end
