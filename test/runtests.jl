using PkgServerCacheWarmer
using Test

@testset "PkgServerCacheWarmer.jl" begin
    @testset "file" begin
        @testset "get_file_contents(; contents)" begin
            @test PkgServerCacheWarmer.get_file_contents(; contents = "foo bar baz") == "foo bar baz"
        end
        @testset "get_file_contents(; filename)" begin
            d = mktempdir(; cleanup = true)
            filename = joinpath(d, "file.txt")
            open(filename, "w") do io
                println(io, "Hello world")
            end
            @test PkgServerCacheWarmer.get_file_contents(; filename) == "Hello world\n"
        end
        @testset "get_file_contents error paths" begin
            @test_throws ErrorException PkgServerCacheWarmer.get_file_contents()
            @test_throws ErrorException PkgServerCacheWarmer.get_file_contents(; contents="", filename="")
        end
    end
    @testset "type constructors" begin
        @test PkgServerCacheWarmer.Project(; contents = "hello world") isa PkgServerCacheWarmer.Project
        @test PkgServerCacheWarmer.Project(; contents = "hello world") isa PkgServerCacheWarmer.ProjectOrManifest

        @test PkgServerCacheWarmer.Manifest(; contents = "hello world") isa PkgServerCacheWarmer.Manifest
        @test PkgServerCacheWarmer.Manifest(; contents = "hello world") isa PkgServerCacheWarmer.ProjectOrManifest
    end
end
