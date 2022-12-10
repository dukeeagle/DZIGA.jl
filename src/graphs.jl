# a struct to represent the city graph in multiple ways, with {endpointA : {endpointB : (duration, distance)} as key-value pairs. 

# also get hash table of junctions by junction id (instead of inefficient lookup)

"""
    CityGraph

story a city as a graph adjacency matrix for easy traversal.  Given a ['City'](@ref), produce a `matrix` dictionary with {endpointA : {endpointB : (duration, distance)} as key-value pairs. Also create an `edges` vector of tuples of (endpointA, endpointB) for easy traversal.
    
# Fields
- `matrix::Dict{Int,Dict{Int,Tuple{Int,Int}}}`: a dictionary of dictionaries where the first key is the starting junction and the second key is the ending junction. The value is a tuple of the duration and distance of the street.
- `edges::Vector{Tuple{Int,Int}}`: a vector of tuples of the starting and ending junctions of the street.

"""
Base.@kwdef struct CityGraph
    adj_matrix::Dict{Int,Dict{Int,Street}}
    # edges::Vector{Tuple{Int,Int}}
    ids_to_junctions::Dict{Int,Junction}
    junctions_to_ids::Dict{Junction,Int}
end

function CityGraph(city::City)
    adj_matrix = Dict{Int,Dict{Int,Street}}()
    edges = Vector{Tuple{Int,Int,Int,Int}}()

    ids_to_junctions = Dict{Int,Junction}()
    junctions_to_ids = Dict{Junction,Int}()

    for street in city.streets
        if !haskey(adj_matrix, street.endpointA)
            adj_matrix[street.endpointA] = Dict{Int,Street}(street.endpointB => street)
        end

        adj_matrix[street.endpointA][street.endpointB] = street

        # if bidirectional, add the reverse street
        if street.bidirectional
            if !haskey(adj_matrix, street.endpointB)
                adj_matrix[street.endpointB] = Dict{Int,Street}(street.endpointA => street)
            end

            adj_matrix[street.endpointB][street.endpointA] = street
        end
    end

    for (i, junction) in enumerate(city.junctions)
        ids_to_junctions[i] = junction
        junctions_to_ids[junction] = i
    end

    return CityGraph(;
        adj_matrix=adj_matrix,
        junctions_to_ids=junctions_to_ids,
        ids_to_junctions=ids_to_junctions,
    )
end
