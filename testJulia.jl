#!/home/mathias/Downloads/julia-d55cadc350/bin//julia
include("defineConstants.jl")
include("elementOfLength.jl")

N,l,a0,Δa,n = defineConstants()

a = a0 + Δa/2

wireLength = sqrt((N*2*pi*a)^2 + (l)^2)
totalCircumference = 2*pi*a*N

println(wireLength," is the length of the wire used.")
println(totalCircumference," is N times the coil circumference.")

number = 5
# lengthSums = zeros(number,1)

for n in logspace(0,number,number + 1)
	Δx,Δy,Δz = elementOfLength(N,l,a,n)
	lengthSum = sum(sqrt.(Δx.^2 + Δy.^2 + Δz.^2))

	println(lengthSum," is the sum of the element lengths for n = ",n,".")
end