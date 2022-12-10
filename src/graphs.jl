"""
    CityGraph

Store the junctions and streets of a `City` as an adjacency matrix for easy traversal and lookup.  Given a 'City', produce a `adj_matrix` adjacency matrix dictionary with {endpointA : {endpointB : Street}} as key-value pairs. Also hashes all `Junction` objects in the city by id (and vice versa) for easy lookup.
    
# Fields
- `matrix::Dict{Int,Dict{Int,Street}} a dictionary of dictionaries where the first key is the starting junction and the ending junction, which maps to the `Street` value.
- `ids_to_junctions::Dict{Int,Junction}` a dictionary of `Junction`s by junction id
- `junctions_to_ids::Dict{Junction,Int}` a dictionary of junction ids by `Junction`
"""
Base.@kwdef struct CityGraph
    adj_matrix::Dict{Int,Dict{Int,Street}}
    ids_to_junctions::Dict{Int,Junction}
    junctions_to_ids::Dict{Junction,Int}
end

function CityGraph(city::City)
    adj_matrix = Dict{Int,Dict{Int,Street}}()

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
