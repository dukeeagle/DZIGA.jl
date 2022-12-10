# Google Paris Hash Code 2014 solutions
using HashCode2014

# order of operations
# - calculate upper bound of solution
#   - make an easy representation of the city graph, determine greatest distance we could possibly cover given time limit (start with naive sum of all street distances, then calculate sum of maximum possible distances covered per car)

"""
    greedy_planner(city::City) ::Int

Greedily the greatest possible distance you can traverse for the given [`City`](@ref). Best algorithm we have.
"""
function greedy_planner(city::City)::Solution
    return greedy_bst(city)
end

function greedy_bst(city::City)::Solution
    city_graph = CityGraph(city)
    visited = Dict{Int,Int}()
    solution = Vector{Vector{Int}}()

    num_cars = city.nb_cars

    for car_id in 1:num_cars
        itin = best_first_search(visited, city_graph, city)
        push!(solution, itin)
    end
    return Solution(solution)
end

# run this for each car
function best_first_search(
    visited::Dict{Int,Int}, city_graph::CityGraph, city::City
)::Vector{Int}
    total_duration = city.total_duration
    starting_junction = city_graph.ids_to_junctions[city.starting_junction]
    itinerary = [city.starting_junction]
    t = 0

    while t <= total_duration
        current_junction_id = last(itinerary)
        # current_junction_id = city_graph.junctions_to_ids[current_junction]

        candidates = city_graph.adj_matrix[current_junction_id] # later filtered
        if length(candidates) == 0
            break
        end

        best_pair = get_best_move(
            t, visited, city, city_graph, current_junction_id, candidates
        ) # use heuristic here
        if best_pair == nothing
            break
        end
        next_junction, next_street = best_pair

        # update visited cache

        # update time and itinerary
        push!(itinerary, next_junction)
        t += next_street.duration
    end

    return itinerary
end

function get_best_move(
    time_elapsed, visited, city, city_matrix, current_junction, candidates
) #::Pair{Junction,Street}
    # filter
    candidates = [
        candidate for candidate in candidates if
        (time_elapsed + candidate[2].duration <= city.total_duration)
    ]

    if length(candidates) == 0
        return nothing
    end
    best_pair = rand(candidates)

    best_street = best_pair[2]
    best_junction = best_pair[1]

    return Pair{Int,Street}(best_junction, best_street)
end
