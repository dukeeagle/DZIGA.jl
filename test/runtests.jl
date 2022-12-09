using DZIGA
using Test

using Aqua
using Documenter
using JuliaFormatter
using HashCode2014

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

    @testset verbose = true "Greedy plan large" begin
        city = read_city() # read large Paris dataset
        solution = greedy_planner(city)

        @test is_feasible(solution, city)
        @test total_distance(solution, city) <= get_upper_bound(city)

        # generate and test adjacency matrix
        city_matrix = CityAdjacencyMatrix(city).matrix

        # based on hard-coded contents of Paris txt file
        @test city_matrix[2015][3845] == (4, 29)
    end

    @testset verbose = true "Greedy plan small" begin
        input_path = joinpath(@__DIR__, "data", "input1.txt")
        output_path = joinpath(@__DIR__, "data", "output1.txt")
        city = read_city(input_path)
        solution = read_solution(output_path)

        @test get_upper_bound(city) == 450
        @test total_distance(solution, city) == 450

        # generate and test adjacency matrix
        city_matrix = CityAdjacencyMatrix(city).matrix

        @test city_matrix[2][3] == (45, 200)
        @test city_matrix[3][2] == (45, 200)
    end
end
