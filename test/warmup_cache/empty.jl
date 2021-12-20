@testset begin
    config = _default_config()
    msg = "No project files or manifest files were provided"
    projs_and_mnfsts = PkgServerCacheWarmer.ProjectFileOrManifestFile[]
    @test_logs (:warn, msg) warmup_cache(config, projs_and_mnfsts)
end
