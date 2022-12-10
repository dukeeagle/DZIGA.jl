var documenterSearchIndex = {"docs":
[{"location":"final_writeup/#DZIGA.jl-:-a-package-that-greedily-solves-for-the-Google-Hashcode-2014-challenge","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"","category":"section"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"for the MIT class 6.S083/C25, or [Julia: Solving Real-World Problems with Computation, Fall 2022","category":"page"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"](https://github.com/mitmath/JuliaComputation)","category":"page"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"The goal of the Google Hashcode 2014 challenge is to choose a route for n Google StreetView cars that allows them to traverse as many unique meters of a given city as possible within a limited amount of time. This is a computationally hard problem, so greedy, approximate solutions seem necessary when dealing with realistically large datasets. ","category":"page"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"In the canonical dataset given for this challenge, we are asked to plan for 8 cars traveling across the streets of Paris for 54000 seconds (15 hours).","category":"page"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"DZIGA.jl is a Julia package that can solve this challenge through the function DZIGA.greedy_planner(city::City). This input City struct and output Solution struct come from Guillaume Dalle's HashCode2014.jl package. See the full docs here.","category":"page"},{"location":"final_writeup/#Description-of-greedy-planning-algorithm","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"Description of greedy planning algorithm","text":"","category":"section"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"Best-first search is well-suited for greedily solving this challenge.","category":"page"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"It's a type of graph search algorithm that expands the node that has the smallest value of a certain heuristic function f(n) first. In our case, we defined a heuristic f(n) that rewards previously-unvisited streets, penalizes paths that have been visited multiple times, and penalizes more time-consuming streets. As you'll be able to see, this heuristic function was crafted through extensive trial and error.","category":"page"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"Our heuristic function f(n) for a given junction n is defined as follows:","category":"page"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"f(n) = (l_n + b cdot l_n - p_1 cdot fracd_nl_nl_n) * p_2^textvisited(n)","category":"page"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"where:","category":"page"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"l_n\nis the length of the street at junction n\nb\nis a positive constant that represents the bonus for the length of the street\np_1\nis a positive constant that represents the penalty for the duration per unit distance of the street\np_2\nis a positive constant that represents the penalty for the duration per unit distance of the street. We set this number to be very low in order to heavily penalize junctions that have previously been visited.\ntextvisited(n)\nis a function that indicates how many times junction n has already been visited.","category":"page"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"To choose the next junction to visit, we simply select the junction n with the highest score f(n).","category":"page"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"All hyperparameters were adjusted by-hand until we achieved a locally optimal score. If I had more time, I would've run a proper, automated hyperparameter search in order to break out of the local maximum that DZIGA.jl's solver is currently in.","category":"page"},{"location":"final_writeup/#Upper-bounded-solution","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"Upper-bounded solution","text":"","category":"section"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"We can naively approximate an upper bound to any City scenario by simply summing each street distance according to a list of streets sorted by length. We stop summing once (texttotal duration*texttotal cars) has elapsed. In the canonical Paris example, this give us a best possible solution of 1967444 meters. This result matches my classmates' work, based on the C25 final project leaderboard on Google Sheets.","category":"page"},{"location":"final_writeup/#Results","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"Results","text":"","category":"section"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"DZIGA.greedy_planner() achieves 1,500,689 meters of unique distance traveled for the Paris scenario. On my standard Macbook Pro 2019 laptop with Julia installed locally, this function takes less than 3 seconds to evaluate. This result reaches approximately 76% of the theoretical upper bound, and it's competitive with my classmates' results according to the leaderboard.","category":"page"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"There is extensive room for improvement here. If I redid this project, I would have implemented \"look-ahead\" functionality, which would allow the BFS heuristic to see multiple steps past the current time-step for a given car path. I got lucky with my well-tuned heuristics, as evidenced by how wildly the results decline if I slightly tweak the hyperparameters of f(n). ","category":"page"},{"location":"final_writeup/","page":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","title":"DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge","text":"Lookahead functionality would effectively allow me to find f(n) for all the neighbors of a node's current neighbors, which sounds very computationally expensive. I'd expect an implementation of this idea to take orders of magnitude more processing time on the Paris scenario than DZIGA's current state of the art solver.","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = DZIGA","category":"page"},{"location":"#DZIGA","page":"Home","title":"DZIGA","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for DZIGA.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [DZIGA]","category":"page"},{"location":"#DZIGA.CityGraph","page":"Home","title":"DZIGA.CityGraph","text":"CityGraph\n\nstory a city as a graph adjacency matrix for easy traversal.  Given a 'City', produce a matrix dictionary with {endpointA : {endpointB : (duration, distance)} as key-value pairs. Also create an edges vector of tuples of (endpointA, endpointB) for easy traversal.\n\nFields\n\nmatrix::Dict{Int,Dict{Int,Tuple{Int,Int}}}: a dictionary of dictionaries where the first key is the starting junction and the second key is the ending junction. The value is a tuple of the duration and distance of the street.\nedges::Vector{Tuple{Int,Int}}: a vector of tuples of the starting and ending junctions of the street.\n\n\n\n\n\n","category":"type"},{"location":"#DZIGA.best_first_search-Tuple{Dict{Int64, Int64}, CityGraph, HashCode2014.City}","page":"Home","title":"DZIGA.best_first_search","text":"best_first_search(visited::Dict{Int,Int}, city_graph::CityGraph, city::City) ::Vector{Int}\n\nImplements best-first search with a special heuristic function. Returns an itinerary for a single car.\n\n\n\n\n\n","category":"method"},{"location":"#DZIGA.get_upper_bound-Tuple{HashCode2014.City}","page":"Home","title":"DZIGA.get_upper_bound","text":"get_upper_bound(city::City) ::Int\n\nReturn the greatest possible distance you can traverse for the given City by summing the longest streets first.\n\n\n\n\n\n","category":"method"},{"location":"#DZIGA.greedy_bst-Tuple{HashCode2014.City}","page":"Home","title":"DZIGA.greedy_bst","text":"greedy_bst(city::City) ::Int\n\nUses a best-first search to greedily generate a plan that covers the greatest possible distance you can traverse for the given City across all City.nb_cars.\n\n\n\n\n\n","category":"method"},{"location":"#DZIGA.greedy_planner-Tuple{HashCode2014.City}","page":"Home","title":"DZIGA.greedy_planner","text":"greedy_planner(city::City) ::Int\n\nDZGIA's state of the art planner for the HashCode 2014 challenge. Returns a Solution that greedily covers the greatest possible distance you can traverse for the given City. Calls greedy_bst.\n\n\n\n\n\n","category":"method"}]
}
