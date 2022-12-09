# Google Paris Hash Code 2014 solutions
using HashCode2014

# order of operations
# - calculate upper bound of solution
#   - make an easy representation of the city graph, determine greatest distance we could possibly cover given time limit (start with naive sum of all street distances, then calculate sum of maximum possible distances covered per car)

"""
    greedy_planner(city::City) ::Int

Greedily the greatest possible distance you can traverse for the given [`City`](@ref).
"""
function greedy_planner(city::City)::Solution
    (; total_duration, nb_cars, starting_junction, streets) = city

    solution = random_walk(city) # hehehe

    return solution
end
