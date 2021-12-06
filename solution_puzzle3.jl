#=
    A solution to puzzle # 3 of Advent of Code 2021
=#
using DelimitedFiles

### some functions
##-- glue together an array of strings
function glue(array_of_strings)
    st = ""
    for ss = 1:length(array_of_strings)
        st *= array_of_strings[ss]
    end
    return st
end

##-- compute epsilong and gamma rate
function epsilon_gamma_rates(report::Vector)
    len_report = length(report)

    sums = zeros(Int64, length(report[1]))
    for ll = 1:len_report
        sums .+= parse.(Int, report[ll])
    end

    most_frec_vals = 1 .* (sums .> trunc(Int, len_report/2))
    less_frec_vals = 1 .* (sums .< trunc(Int, len_report/2))

    #mfv, lfv = glue.([string.(most_frec_vals), string.(less_frec_vals)])
    mfv, lfv = "", ""
    for mm = 1:length(most_frec_vals)
        mfv *= string(most_frec_vals[mm])
        lfv *= string(less_frec_vals[mm])
    end
    return parse.(Int, [mfv, lfv], base = 2)
end

##-- find most common and less common values at a given position
function most_less_common_vals(report::Vector, pos::Int64)
    len_report = length(report)
    sums = sum(parse(Int, report[ll][pos]) for ll = 1:len_report)

    if sums > len_report/2
        return [1, 0]
    elseif sums < len_report/2
        return [0, 1]
    else
        return [1, 0]
    end
end

##-- oxygen and C02 report
function O_and_CO2_rep(report::Vector, c)
    posi = 1
    while length(report) != 1
        val = string(most_less_common_vals(report, posi)[c])
        report = filter(x -> x[posi] == val, report)
        posi += 1
    end
    return parse(Int, glue(report[1]), base = 2)

end

### Solution
data = split.(readlines("data/input_puzzle3.dat"), "")

##--- solution to part 1
#println(epsilon_gamma_rates(data))
println(prod(epsilon_gamma_rates(data)))

##--- solution to part 2
oxy = O_and_CO2_rep(data, 1)
co2 = O_and_CO2_rep(data, 2)
println(oxy*co2)
