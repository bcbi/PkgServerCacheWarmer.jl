import PkgServerCacheWarmer
import Test

using PkgServerCacheWarmer: Config, Project, Manifest, FileName, FileContents, warmup_cache
using Test: @testset, @test, @test_logs

include("test_utils.jl")

@testset "PkgServerCacheWarmer.jl" begin
    test_files = String[
        joinpath("warmup_cache", "empty"),
        joinpath("warmup_cache", "manifest"),
        joinpath("warmup_cache", "project"),
    ]
    @testset "$(test_file)" for test_file in test_files
        include("$(test_file).jl")
    end
end
