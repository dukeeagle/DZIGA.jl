# Google Paris Hash Code 2014 solutions
using HashCode2014

# order of operations
# - calculate upper bound of solution
#   - make an easy representation of the city graph, determine greatest distance we could possibly cover given time limit (start with naive sum of all street distances, then calculate sum of maximum possible distances covered per car)

"""
    greedy_planner(city::City) ::Int

Greedily the greatest possible distance you can traverse for the given [`City`](@ref).
"""
function greedy_planner()
    city = read_city() # read large Paris dataset

    solution = random_walk(city)
    return total_distance(solution, city)
end

# function main()
# 	return greedy_planner()
#  end

#  if abspath(PROGRAM_FILE) == @__FILE__
# 	 print(main())
#  end

# given a city, return the best possible solution
function get_upper_bound(city::City)
    (; total_duration, nb_cars, starting_junction, streets) = city

    maximum_time = total_duration * nb_cars # maximum time that could be independently spent on streets
    maximum_distance = 0 # maximum distance that could be independently covered on streets

    # sort streets by distance
    sorted_streets = sort(streets; by=street -> street.distance, rev=true)

    for street in sorted_streets
        # if we can't fit this street in the maximum time, we're done
        if street.duration > maximum_time
            break
        end

        # if we can fit this street in the maximum time, add it to the maximum distance
        maximum_distance += street.distance
        maximum_time -= street.duration
    end

    return maximum_distance

    # # generate dict of streets, with key (endpointA, endpointB) and value (distance)
    # street_dict = Dict{Tuple{Int16, Int16}, Int16}()
    # for street in streets
    # 	street_dict[(street.endpointA, street.endpointB)] = street.distance

    # 	if street.bidirectional
    # 		street_dict[(street.endpointB, street.endpointA)] = street.distance
    # 	end
    # end
end
