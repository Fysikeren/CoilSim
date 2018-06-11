#!/home/mathias/Downloads/julia-d55cadc350/bin//julia
include("meshgrid.jl")
include("elementOfLength.jl")
include("coordinateOfCoil.jl")

N = 10 # Number of turns in coil
l = 25e-3 # Length of coil, m
a0 = 7.25e-3 # Inner radius of coil, m
da = 0.2e-3 # The thickness of one layer of turns. This is the outer diameter of the magnet wire, which includes the enamel
n = Int(1e3) # Number of points in the model of the coil

# Calculate the coordinates for a simple one-layer coil:
a = a0 + da/2
x,y,z = coordinateOfCoil(N,l,a,n)
dx,dy,dz = elementOfLength(N,l,a,n)

# Calculate coordinates of points to test the magnetic field vectors
nGrid = 75
xs = linspace(-1.4*a,1.4*a,nGrid)
zs = linspace(-0.7*l,0.7*l,2*nGrid) # The length of the coil is roughly twice its diameter, so we use twice as many points along the z direction
X,Z = meshgrid(xs,zs)
Y = zeros(size(X))

Bx = zeros(size(X))
By = zeros(size(X))
Bz = zeros(size(X))

nTestPoints = length(X[:])

tic()
for i in 1:nTestPoints
    testPoint = [X[i]; Y[i]; Z[i]]
    db = zeros(3,n)

    for j in 1:n
        dl = [dx[j]; dy[j]; dz[j]]
        r = testPoint - [x[j]; y[j]; z[j]]
        rNorm = norm(r)

        db[:,j] = cross(dl,r)/(rNorm^3)
    end

    I = 1e-3
    db *= I*1e-7
    B = sum(db,2)
    Bx[i] = B[1]
    By[i] = B[2]
    Bz[i] = B[3]
end
toc()

writedlm("Output/theCoil.txt", [x y z])

writedlm("Output/XZBx.txt", [X[:] Z[:] Bx[:]])
writedlm("Output/XZBy.txt", [X[:] Z[:] By[:]])
writedlm("Output/XZBz.txt", [X[:] Z[:] Bz[:]])

writedlm("Output/X.txt", X)
writedlm("Output/Y.txt", Y)
writedlm("Output/Z.txt", Z)
writedlm("Output/Bx.txt", Bx)
writedlm("Output/By.txt", By)
writedlm("Output/Bz.txt", Bz)

# using Plots
# plotly() # Choose the Plotly.jl backend for web interactivity
# plot(x,y,z)
# surface(X,Z,Bz)