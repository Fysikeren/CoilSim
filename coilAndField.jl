#!/home/mathias/Downloads/julia-d55cadc350/bin//julia
include("myMeshgrid.jl")

x = linspace(0,1,3)
y = x

X,Y = meshgrid(x,y)

println(x)
println(y)

println(X)
println(Y)