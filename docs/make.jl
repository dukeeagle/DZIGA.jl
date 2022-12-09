using DZIGA
using Documenter

DocMeta.setdocmeta!(DZIGA, :DocTestSetup, :(using DZIGA); recursive=true)

makedocs(;
    modules=[DZIGA],
    authors="Lucas Igel <luke.igel@gmail.com>",
    repo="https://github.com/dukeeagle/DZIGA.jl/blob/{commit}{path}#{line}",
    sitename="DZIGA.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://dukeeagle.github.io/DZIGA.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=["Home" => "index.md"],
)

deploydocs(; repo="github.com/dukeeagle/DZIGA.jl", devbranch="main")
