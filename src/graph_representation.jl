"""
    CityAdjacencyMatrix

story a city as a graph adjacency matrix for easy traversal.  Given a ['City'](@ref), produce a `matrix` dictionary with {endpointA : {endpointB : (duration, distance)} as key-value pairs.
    
# Fields
- `matrix::Dict{Int,Dict{Int,Tuple{Int,Int}}}`: a dictionary of dictionaries where the first key is the starting junction and the second key is the ending junction. The value is a tuple of the duration and distance of the street.

"""
Base.@kwdef struct CityAdjacencyMatrix
    matrix::Dict{Int,Dict{Int,Tuple{Int,Int}}}
end

function CityAdjacencyMatrix(city::City)
    matrix = Dict{Int,Dict{Int,Tuple{Int,Int}}}()

    for street in city.streets
        if !haskey(matrix, street.endpointA)
            matrix[street.endpointA] = Dict{Int,Tuple{Int,Int}}()
        end

        matrix[street.endpointA][street.endpointB] = (street.duration, street.distance)
    end

    return CityAdjacencyMatrix(matrix)
end
