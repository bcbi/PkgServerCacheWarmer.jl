@testset begin
    config = _default_config()

    project_contents = """
        [deps]
        Example = "7876af07-990d-54b4-ab0e-23690620f79a"
    """

    project_filename = _contents_to_filename(; contents = project_contents)

    projs_and_mnfsts = [
        Project(FileContents(project_contents)),
        Project(FileName(project_filename)),
        Project(FileName(project_filename); script = PkgServerCacheWarmer._DEFAULT_SCRIPT),
    ]

    @test warmup_cache(config, projs_and_mnfsts) isa Nothing
end
