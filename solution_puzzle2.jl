#=
    Solution to puzzle #2 of Advent of Code 2021
=#
##-- loading modules
using DelimitedFiles

#=
    Helper functions
=#
##-- compute final depth and horizontal positions
function hpos_and_depth(follow_steps::Array)
    le = length(follow_steps[:,1])

    hpos = 0
    depth = 0

    for ll = 1:le
        action = follow_steps[ll, 1]
        if action == "forward"
            hpos += follow_steps[ll,2]
        elseif action == "down"
            depth += follow_steps[ll,2]
        elseif action == "up"
            depth -= follow_steps[ll,2]
        end
    end
    return (hpos, depth)
end

function hpos_and_depth(instruct::Vector, values::Vector)
    hpos = sum(values[findall(x -> x == "forward", instruct)])
    ups = sum(values[findall(x -> x == "up", instruct)])
    downs = sum(values[findall(x -> x == "down", instruct)])
    depth = downs - ups
    return (hpos, depth)
end

##-- compute final depth and horizontal position with aim
function hpos_and_depth_with_aim(follow_steps::Array)
    le = length(follow_steps[:,1])

    hpos, depth, aim = 0, 0, 0

    for ll = 1:le
        action = follow_steps[ll, 1]

        if action == "forward"
            hpos += follow_steps[ll,2]
            depth += aim*follow_steps[ll,2]
        elseif action == "down"
            aim += follow_steps[ll,2]
        elseif action == "up"
            aim -= follow_steps[ll,2]
        end
    end
    return (hpos, depth)
end

### Solution
## load the data
input = readdlm("data/input_puzzle2.dat")

## solution to first part of pussle
println(hpos_and_depth(input))
println(prod(hpos_and_depth(input)))
# alternative solution
#println(hpos_and_depth(input[:,1], input[:,2]))
#println(prod(hpos_and_depth(input[:,1], input[:,2])))

## solution to second ṕart of puzzle
println(hpos_and_depth_with_aim(input))
println(prod(hpos_and_depth_with_aim(input)))
