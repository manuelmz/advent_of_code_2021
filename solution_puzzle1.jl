#=
    Solution to puzzle #1 of Advent of Code 2021

    Manuel Muñoz - 12/01/2021
=#
##-- loading modules
using DelimitedFiles

#=
    Helper functions
=#
##-- count the number of values which are larger than the previous one
function count_increase(data::Array)
    copy_input = [data[2:end,1]; data[end]]
    bool_vec = copy_input .> data
    num_of_increase = sum(bool_vec)
    return num_of_increase
end

##-- count the number of sum of three values which increase
function count_increase_3window(data::Array)
    three_window = [sum(data[ii:ii+2, 1]) for ii = 1:length(data)-2]
    copy_three_window = [three_window[2:end]; three_window[end]]
    bool_vec = copy_three_window .> three_window
    num_of_increase = sum(bool_vec)
    return num_of_increase
end

##-- load the data
input = readdlm("data/input_puzz1.dat")
#input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

## solution to first part of puzzle is:
println(count_increase(input))

## Solution to second part of puzzle
println(count_increase_3window(input))
