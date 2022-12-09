"""
    get_upper_bound(city::City) ::Int

Return the greatest possible distance you can traverse for the given [`City`](@ref) by summing the longest streets first.
 """
function get_upper_bound(city::City)::Int
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
end
