#=
    Solution of puzzle #6 of Advent of Code 2021
=#

#=
    Utility functions
=#
function fish_popu_dynamics(init_pops::Vector, days::Int64)
    popus = Dict(0:1:8 .=> 0)

    ##-- filling the dictionary with the initial conditions
    for nn = 1:length(data) popus[data[nn]] += 1 end

    for dd = 1:days
        new_fish = popus[0]

        for pp = 0:5 popus[pp] = popus[pp+1] end

        popus[6] = popus[7] + new_fish
        popus[7] = popus[8]
        popus[8] = new_fish
    end
    return sum(values(popus))
end

###----- Solution
#--> load data
data = parse.(Int, filter(x -> x != "", collect(Iterators.flatten(split.(readlines("data/input_puzzle6.dat"), ",")))))

##-- solution of first part
println(fish_popu_dynamics(data, 80))

##-- solution of second part
println(fish_popu_dynamics(data, 256))
