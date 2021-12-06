#=
    Solution to puzzle #5 of Advent of Code 2021
=#


#=
    Utility functions
=#
function make_hline(hline::Vector)
    ini = minimum(hline[[1,3]])
    fin = maximum(hline[[1,3]])
    yval = hline[2]

    return (yval+1, ini+1, fin+1, ones(Int, fin - ini + 1))
end

function make_vline(vline::Vector)
    ini = minimum(vline[[2,4]])
    fin = maximum(vline[[2,4]])
    xval = vline[1]

    return (ini+1, fin+1, xval+1, ones(Int, fin - ini + 1))
end

function make_dline(dline::Vector)
    xini, xfin = dline[1], dline[3]
    yini, yfin = dline[2], dline[4]
    xsign = sign(xfin - xini)
    ysign = sign(yfin - yini)

    indices = [CartesianIndex(yini + 1 + ysign*ii, xini + 1 + xsign*ii) for ii = 0:abs(yfin-yini)]
    return (indices, ones(Int, length(indices)))
end

function fill_grid_intercepts(hls::Vector, vls::Vector, grid_dims::Vector)
    grid = zeros(Int, grid_dims[2]+1, grid_dims[1]+1)

    ## adding the horizontal lines
    for hh = 1:length(hls)
        hlin = make_hline(hls[hh])
        grid[hlin[1], hlin[2]:hlin[3]] .+= hlin[4]
    end

    ## adding the vertical lines
    for vv = 1:length(vls)
        vlin = make_vline(vls[vv])
        grid[vlin[1]:vlin[2], vlin[3]] .+= vlin[4]
    end

    return length(filter(x -> x >= 2, grid))
end

function fill_grid_intercepts(hls::Vector, vls::Vector, dls::Vector, grid_dims::Vector)
    grid = zeros(Int, grid_dims[2]+1, grid_dims[1]+1)

    ## adding the horizontal lines
    for hh = 1:length(hls)
        hlin = make_hline(hls[hh])
        grid[hlin[1], hlin[2]:hlin[3]] .+= hlin[4]
    end

    ## adding the vertical lines
    for vv = 1:length(vls)
        vlin = make_vline(vls[vv])
        grid[vlin[1]:vlin[2], vlin[3]] .+= vlin[4]
    end

    ## adding the diagonal lines
    for dd = 1:length(dls)
        dlin = make_dline(dls[dd])
        grid[dlin[1]] .+= dlin[2]
    end

    return length(filter(x -> x >= 2, grid))
end

###----- Solution
#-- load the data
data = readlines("data/input_puzzle5.dat")
lines = [parse.(Int, collect(Iterators.flatten(split.(split(data[jj], " -> "), ","))), base = 10) for jj = 1:length(data)]

#-- finding the horizontal and vertical lines
hlines = filter(x -> x[2] == x[4], lines)
vlines = filter(x -> x[1] == x[3], lines)
dlines = filter(x -> x[2] != x[4] && x[1] != x[3], lines)

#-- finding the dimensions of the grid
maxs = [maximum(filter(x->x[2]==1, findmax.(lines))),
maximum(filter(x->x[2]==3, findmax.(lines))),
maximum(filter(x->x[2]==2, findmax.(lines))),
maximum(filter(x->x[2]==4, findmax.(lines)))]
maxis = [max(maxs[1][1], maxs[3][1]), max(maxs[2][1], maxs[4][1])]

#-----> solution to first part of the puzzle
println(fill_grid_intercepts(hlines, vlines, maxis))

#-----> solution to second part of the puzzle
println(fill_grid_intercepts(hlines, vlines, dlines, maxis))
