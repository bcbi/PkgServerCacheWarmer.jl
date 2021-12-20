@testset begin
    config = _default_config()

    project_contents = """
        [deps]
        Example = "7876af07-990d-54b4-ab0e-23690620f79a"
    """

    manifest_contents = project_contents_to_manifest_contents(
        config;
        project_file_contents = project_contents,
    )

    projs_and_mnfsts = [
        Manifest(FileContents(manifest_contents)),
    ]

    @test warmup_cache(config, projs_and_mnfsts) isa Nothing
end
