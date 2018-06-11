#!/home/mathias/Downloads/julia-d55cadc350/bin//julia
include("myMeshgrid.jl")
include("elementOfLength.jl")
include("coordinateOfCoil.jl")

N = 2
l = 1
a = 7.25
n = 1e1

x,y,z = coordinateOfCoil(N,l,a,n)
println("x = ",x)
println("y = ",y)
println("z = ",z)

dx,dy,dz = elementOfLength(N,l,a,n)
println("dx = ",dx)
println("dy = ",dy)
println("dz = ",dz)

testx = 7.25
for i in 1:length(dx)
    testx += dx[i]
    println(testx)
end