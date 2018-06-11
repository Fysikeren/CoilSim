# meshgrid
# Emulates the 2D version of Matlab's meshgrid function
# Needs to 
include("myMeshgrid.jl")

x = linspace(0,1,3)
y = x

X,Y = meshgrid(x,y)

println(x)
println(y)

println(X)
println(Y)