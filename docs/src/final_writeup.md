# DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge
> for the MIT class 6.S083/C25, or [Julia: Solving Real-World Problems with Computation, Fall 2022
](https://github.com/mitmath/JuliaComputation)

The goal of the Google Hashcode 2014 challenge is to choose a route for $n$ Google StreetView cars that allows them to traverse as many unique meters of a given city as possible within a limited amount of time. This is a computationally hard problem, so greedy, approximate solutions seem necessary when dealing with realistically large datasets. 

In the canonical dataset given for this challenge, we are asked to plan for 8 cars traveling across the streets of Paris for 54000 seconds (15 hours).

DZIGA.jl is a Julia package that can solve this challenge through the function `DZIGA.greedy_planner(city::City)`. This input `City` struct and output `Solution` struct come from Guillaume Dalle's [HashCode2014.jl](https://github.com/gdalle/HashCode2014.jl) package. See the full docs here.

## DZIGA's greedy planning algorithm

[Best-first search](https://en.wikipedia.org/wiki/Best-first_search) is well-suited for greedily solving the Google HashCode 2014 challenge. 

## upper-bound solution


