function warmup_cache(cfg::Config,
                      projs_and_mnfsts::AbstractVector{T}) where T <:ProjectFileOrManifestFile
    if isempty(projs_and_mnfsts)
        @warn "No project files or manifest files were provided"
    end
    for proj_or_mnfst in projs_and_mnfsts
        temporary_environment = create_new_temporary_environment(cfg, proj_or_mnfst)
        commands = generate_julia_pkg_commands(
            cfg,
            temporary_environment,
            proj_or_mnfst,
        )
        run_commands(commands)
    end
    return nothing
end
