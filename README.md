# DZIGA.jl : a greedy Street View car planner

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://dukeeagle.github.io/DZIGA.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://dukeeagle.github.io/DZIGA.jl/dev/)
[![Build Status](https://github.com/dukeeagle/DZIGA.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/dukeeagle/DZIGA.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/dukeeagle/DZIGA.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/dukeeagle/DZIGA.jl)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

> for the MIT class 6.S083/C25, or [Julia: Solving Real-World Problems with Computation, Fall 2022
](https://github.com/mitmath/JuliaComputation)

Julia package that contains a solver for the [Google Paris 2014 Hash Code challenge](https://storage.googleapis.com/coding-competitions.appspot.com/HC/2014/hashcode2014_final_task.pdf).

Achieves 1,500,689 meters of unique distance traveled for the [Paris scenario]() via a Best-Search First algorithm with multiple heuristics. This result is approximately 76% of the theoretical upper bound.

See [documentation](https://dukeeagle.github.io/DZIGA.jl/stable/).
See [final writeup](/docs/src/final_writeup.md) for full details.