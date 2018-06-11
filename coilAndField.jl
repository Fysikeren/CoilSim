#!/home/mathias/Downloads/julia-d55cadc350/bin//julia
include("meshgrid.jl")
include("elementOfLength.jl")
include("coordinateOfCoil.jl")

N = 2 # Number of turns in coil
l = 25e-3 # Length of coil, m
a0 = 7.25e-3 # Inner radius of coil, m
da = 0.2e-3 # The thickness of one layer of turns. This is the outer diameter of the magnet wire, which includes the enamel
n = 1e2 # Number of points in the model of the coil

# Calculate the coordinates for a simple one-layer coil:
a = a0 + da/2
x,y,z = coordinateOfCoil(N,l,a,n)
dx,dy,dz = elementOfLength(N,l,a,n)

# Calculate coordinates of points 