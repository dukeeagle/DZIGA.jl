"""
    CityAdjacencyMatrix

story a city as a graph adjacency matrix for easy traversal.  Given a ['City'](@ref), produce a `matrix` dictionary with {endpointA : {endpointB : (duration, distance)} as key-value pairs. Also create an `edges` vector of tuples of (endpointA, endpointB) for easy traversal.
    
# Fields
- `matrix::Dict{Int,Dict{Int,Tuple{Int,Int}}}`: a dictionary of dictionaries where the first key is the starting junction and the second key is the ending junction. The value is a tuple of the duration and distance of the street.
- `edges::Vector{Tuple{Int,Int}}`: a vector of tuples of the starting and ending junctions of the street.

"""
Base.@kwdef struct CityAdjacencyMatrix
    matrix::Dict{Int,Dict{Int,Tuple{Int,Int}}}
    edges::Vector{Tuple{Int,Int}}
end

function CityAdjacencyMatrix(city::City)

    # populate the matrix
    matrix = Dict{Int,Dict{Int,Tuple{Int,Int}}}()

    for street in city.streets
        if !haskey(matrix, street.endpointA)
            matrix[street.endpointA] = Dict{Int,Tuple{Int,Int}}()
        end

        matrix[street.endpointA][street.endpointB] = (street.duration, street.distance)

        # if bidirectional, add the reverse street
        if street.bidirectional
            if !haskey(matrix, street.endpointB)
                matrix[street.endpointB] = Dict{Int,Tuple{Int,Int}}()
            end

            matrix[street.endpointB][street.endpointA] = (street.duration, street.distance)
        end
    end

    # populate the edges vector
    edges = Vector{Tuple{Int,Int}}()
    for (endpointA, endpointB_dict) in matrix
        for (endpointB, _) in endpointB_dict
            push!(edges, (endpointA, endpointB))
        end
    end

    return CityAdjacencyMatrix(; matrix=matrix, edges=edges)
end
