# DZIGA.jl : a package that  greedily solves for the Google Hashcode 2014 challenge
> for the MIT class 6.S083/C25, or [Julia: Solving Real-World Problems with Computation, Fall 2022
](https://github.com/mitmath/JuliaComputation)

The goal of the Google Hashcode 2014 challenge is to choose a route for $n$ Google StreetView cars that allows them to traverse as many unique meters of a given city as possible within a limited amount of time. This is a computationally hard problem, so greedy, approximate solutions seem necessary when dealing with realistically large datasets. 

In the canonical dataset given for this challenge, we are asked to plan for 8 cars traveling across the streets of Paris for 54000 seconds (15 hours).

DZIGA.jl is a Julia package that can solve this challenge through the function `DZIGA.greedy_planner(city::City)`. This input `City` struct and output `Solution` struct come from Guillaume Dalle's [HashCode2014.jl](https://github.com/gdalle/HashCode2014.jl) package. See the full docs [here](https://dukeeagle.github.io/DZIGA.jl/).

## Description of greedy planning algorithm

[Best-first search](https://en.wikipedia.org/wiki/Best-first_search) is well-suited for greedily solving this challenge.

It's a type of graph search algorithm that expands the node that has the smallest value of a certain heuristic function $f(n)$ first. In our case, we defined a heuristic $f(n)$ that rewards previously-unvisited streets, penalizes paths that have been visited multiple times, and penalizes more time-consuming streets. As you'll be able to see, this heuristic function was crafted through extensive trial and error.


Our heuristic function $f(n)$ for a given junction $n$ is defined as follows:

$$f(n) = (l_n + b \cdot l_n - p_1 \cdot \frac{d_{n,l_n}}{l_n}) * p_2^{\text{visited(n)}}$$

where:

- $l_n$ is the length of the street at junction $n$
- $b$ is a positive constant that represents the bonus for the length of the street
- $p_1$ is a positive constant that represents the penalty for the duration per unit distance of the street
- $p_2$ is a positive constant that represents the penalty for the duration per unit distance of the street. We set this number to be very low in order to heavily penalize junctions that have previously been visited.
- $\text{visited(n)}$ is a function that indicates how many times junction n has already been visited.

To choose the next junction to visit, we simply select the junction $n$ with the highest score $f(n)$.

All hyperparameters were adjusted by-hand until we achieved a locally optimal score. If I had more time, I would've run a proper, automated hyperparameter search in order to break out of the local maximum that DZIGA.jl's solver is currently in.



## Upper-bounded solution

We can naively approximate an upper bound to any City scenario by simply summing each street distance according to a list of streets sorted by length. We stop summing once $(\text{total duration}*\text{total cars})$ has elapsed. In the canonical Paris example, this give us a best possible solution of 1967444 meters. This result matches my classmates' work, based on the C25 final project leaderboard on Google Sheets.

## Results

`DZIGA.greedy_planner()` achieves 1,500,689 meters of unique distance traveled for the Paris scenario. On my standard Macbook Pro 2019 laptop with Julia installed locally, this function takes less than 3 seconds to evaluate. This result reaches approximately 76% of the theoretical upper bound, and it's competitive with my classmates' results according to the leaderboard.

There is extensive room for improvement here. If I redid this project, I would have implemented ["look-ahead"](https://webdocs.cs.ualberta.ca/~holte/Publications/aaai2010-stern-etal.pdf) functionality, which would allow the BFS heuristic to see multiple steps past the current time-step for a given car path. I got lucky with my well-tuned heuristics, as evidenced by how wildly the results decline if I slightly tweak the hyperparameters of $f(n)$. 

Lookahead functionality would effectively allow me to find $f(n)$ for all the neighbors of a node's current neighbors, which sounds very computationally expensive. I'd expect an implementation of this idea to take orders of magnitude more processing time on the Paris scenario than DZIGA's current state of the art solver.
