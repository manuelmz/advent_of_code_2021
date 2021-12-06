#=
    Solution of puzzle #4 of Advent of Code 2021
=#
##-- loading modules
using DelimitedFiles

#=
    Utility functions
=#
##--
function find_wining_board(bingo_nums, bingo_boards::Vector)
    lnums = length(bingo_nums)
    lboards = length(bingo_boards)

    for ll = 1:lnums
        num = bingo_nums[ll]
        ##-- covering the numbers appearing on the boards
        for lb = 1:lboards
            posis = findall(x -> x == num, bingo_boards[lb])
            if length(posis) != 0 bingo_boards[lb][posis] .= "c" end
        end

        ##-- checking if there is a wining board
        for lb = 1:lboards
            for ii = 1:5
                if bingo_boards[lb][ii,:] == ["c", "c", "c", "c", "c"]
                    return (bingo_nums[ll], bingo_boards[lb], "row", ii)
                end
                if bingo_boards[lb][:,ii] == ["c", "c", "c", "c", "c"]
                    return (bingo_nums[ll], bingo_boards[lb], "col", ii)
                end
            end
        end
    end
end

function find_last_wining_board(bingo_nums, bingo_boards::Vector)
    lnums = length(bingo_nums)
    lboards = length(bingo_boards)
    pos_winners = []
    num_winner = []

    for ll = 1:lnums
        num = bingo_nums[ll]
        ##-- covering the numbers appearing on the boards
        for lb = 1:lboards
            if !(lb in pos_winners)
                posis = findall(x -> x == num, bingo_boards[lb])
                if length(posis) != 0 bingo_boards[lb][posis] .= "c" end
            else
                continue
            end

            for ii = 1:5
                if bingo_boards[lb][ii,:] == ["c", "c", "c", "c", "c"]
                    push!(pos_winners, lb)
                    push!(num_winner, ll)
                    break
                end
                if bingo_boards[lb][:,ii] == ["c", "c", "c", "c", "c"]
                    push!(pos_winners, lb)
                    push!(num_winner, ll)
                    break
                end
            end

        end
    end
    return bingo_nums[num_winner[end]], bingo_boards[pos_winners[end]]
end

function compute_score(wining_values::Tuple)
    flat_board = wining_values[2][findall(x -> x != "c", wining_values[2])]
    return parse(Int, wining_values[1], base = 10) * sum(parse.(Int, flat_board, base = 10))
end

### Solution
## load input data
rand_nums = readlines("data/input1_puzzle4.dat")
boards = readdlm("data/input2_puzzle4.dat", '\t', '\n')

## cleaning the data
rnums = filter(x->x != "", collect(Iterators.flatten(split.(rand_nums, ","))))

boards2 = [collect(Iterators.flatten(filter.(x-> x != "", split.(split(boards[ll], " "), " ")))) for ll = 1:length(boards)]
boards3 = [reshape(collect(Iterators.flatten(boards2[ii+1:ii+5])), 5,5) for ii = 0:5:length(boards2)-5]

#--> solution to first part of the puzzle
bingo_winner = find_wining_board(rnums, boards3)
println(bingo_winner)
println(compute_score(bingo_winner))
println()
#--> solution to second part of the puzzle
last_bingo_winner = find_last_wining_board(rnums, boards3)
println(last_bingo_winner)
println(compute_score(last_bingo_winner))
