using PkgServerCacheWarmer
using Test

@testset "PkgServerCacheWarmer.jl" begin
    @test PkgServerCacheWarmer._hello_world() == "hello world"
end
