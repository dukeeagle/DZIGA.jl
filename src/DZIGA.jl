module DZIGA

# Write your package code here.
using Aqua
using Documenter
using JuliaFormatter

using HashCode2014

export get_upper_bound
export greedy_planner

include("greedy_planner.jl")
include("upper_bound.jl")

end
