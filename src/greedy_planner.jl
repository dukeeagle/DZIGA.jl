using HashCode2014

"""
    greedy_planner(city::City) ::Int

DZGIA's state of the art planner for the HashCode 2014 challenge. Returns a `Solution` that greedily covers the greatest possible distance you can traverse for the given [`City`](@ref). Calls `greedy_bst`.
"""
function greedy_planner(city::City)::Solution
    return greedy_bst(city)
end

"""
    greedy_bst(city::City) ::Int

Uses a best-first search to greedily generate a plan that covers the greatest possible distance you can traverse for the given [`City`](@ref) across all `City.nb_cars`.
"""
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

"""
    best_first_search(visited::Dict{Int,Int}, city_graph::CityGraph, city::City) ::Vector{Int}

Implements best-first search with a special heuristic function. Returns an itinerary for a single car.
"""
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

        next_junction, next_street = get_best_move(
            t, visited, city, city_graph, current_junction_id, candidates
        ) # use heuristic here

        # ensure we don't go over time
        if t + next_street.duration >= total_duration
            break
        end

        # update visited cache
        if next_junction in keys(visited)
            visited[next_junction] += 1
        else
            visited[next_junction] = 1
        end

        # update time and itinerary
        push!(itinerary, next_junction)
        t += next_street.duration
    end

    return itinerary
end

function get_best_move(
    time_elapsed, visited, city, city_graph, current_junction, candidates
)::Pair{Int,Street}
    # use a heuristic that rewards previously-unvisited streets

    # initialize scores
    best_junction, best_street = first(candidates)
    # print(best_street)
    best_score = 0

    for (junction, street) in candidates
        junction_score = get_junction_score(
            junction, street, city_graph, visited, city.total_duration, time_elapsed
        )
        if junction_score > best_score
            best_junction = junction
            best_street = street
            best_score = junction_score
        end
    end

    return Pair{Int,Street}(best_junction, best_street)
end

function get_junction_score(
    junction::Int,
    street::Street,
    city_graph::CityGraph,
    visited::Dict{Int,Int},
    total_duration::Int,
    time_elapsed::Number,
)::Number
    # reward things that haven't been visited yet
    score = street.distance
    duration_per_distance = street.duration / street.distance
    time_remaining = total_duration - time_elapsed

    # add bonus for longer streets
    score += 0.5 * street.distance
    # penalize longer duration per unit distance
    score -= 0.1 * duration_per_distance

    if !(junction in keys(visited))
        visited_term = 0
    else
        visited_term = visited[junction]
    end

    return score * (0.05^visited_term)
end
