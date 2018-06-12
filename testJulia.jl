#!/home/mathias/Downloads/julia-d55cadc350/bin//julia
include("defineConstants.jl")
include("elementOfLength.jl")

N,l,a0,Δa,n = defineConstants()

println("l = ",l*1e3," mm")

a = a0 + Δa/2
Δx,Δy,Δz = elementOfLength(N,l,a,n)

println(sum(sqrt.(Δx.^2 + Δy.^2 + Δz.^2))," is the sum of the element lengths.")
println(sqrt((N*2*pi*a)^2 + (l)^2)," is the length of the wire used.")
println(2*pi*a*N," is N times the coil circumference.")