using DZIGA
using Test

using Aqua
using Documenter
using JuliaFormatter

DocMeta.setdocmeta!(DZIGA, :DocTestSetup, :(using DZIGA); recursive=true)

@testset verbose = true "DZIGA.jl" begin
    @testset verbose = true "Code quality (Aqua.jl)" begin
        Aqua.test_all(DZIGA; ambiguities=false)
    end

    @testset verbose = true "Code formatting (JuliaFormatter.jl)" begin
        @test format(DZIGA; verbose=true, overwrite=false)
    end

    @testset verbose = true "Doctests (Documenter.jl)" begin
        doctest(DZIGA)
    end

    @testset verbose = true "My own tests" begin
        @test 1 + 1 == 2
    end
end
