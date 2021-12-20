using PkgServerCacheWarmer
using Documenter

DocMeta.setdocmeta!(PkgServerCacheWarmer, :DocTestSetup, :(using PkgServerCacheWarmer); recursive=true)

makedocs(;
    modules=[PkgServerCacheWarmer],
    authors="Dilum Aluthge, Brown Center for Biomedical Informatics, contributors",
    repo="https://github.com/bcbi/PkgServerCacheWarmer.jl/blob/{commit}{path}#{line}",
    sitename="PkgServerCacheWarmer.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://bcbi.github.io/PkgServerCacheWarmer.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/bcbi/PkgServerCacheWarmer.jl",
    devbranch="main",
)
