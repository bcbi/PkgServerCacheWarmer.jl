function run_commands(commands::Commands)
    Base.run(commands.cmd_1_before_script)
    Base.run(commands.cmd_2_script)
    Base.run(commands.cmd_3_after_script)
    return nothing
end

function generate_julia_pkg_commands(cfg::Config,
                                     temporary_environment::TemporaryEnvironment,
                                     proj_or_mnfst::ProjectFileOrManifestFile)
    julia_command = Base.julia_cmd()

    env_without_project = temporary_environment.env_without_project
    env_with_project    = temporary_environment.env_with_project

    before_script = _get_before_script(cfg, proj_or_mnfst)::String
    script        = _get_script(       cfg, proj_or_mnfst)::String
    after_script  = _get_after_script( cfg, proj_or_mnfst)::String

    cmd_1_before_script = setenv(`$(julia_command) -e $(before_script)`, env_without_project)
    cmd_2_script        = setenv(`$(julia_command) -e $(script)`,        env_with_project)
    cmd_3_after_script  = setenv(`$(julia_command) -e $(after_script)`,  env_with_project)

    commands = Commands(;
        cmd_1_before_script,
        cmd_2_script,
        cmd_3_after_script,
    )

    return commands
end

for field_name in [:before_script, :script, :after_script]
    fn = Symbol(:_get_, field_name)
    @eval begin
        function $(fn)(cfg::Config, proj_or_mnfst::ProjectFileOrManifestFile)::String
            value_from_proj_or_mnfst = proj_or_mnfst.$(field_name)
            if value_from_proj_or_mnfst !== nothing
                return value_from_proj_or_mnfst
            end
            value_from_cfg = cfg.$(field_name)
            return value_from_cfg
        end
    end
end
