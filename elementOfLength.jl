# elementOfLength
# Takes in the number of turns, N, the length, l, the radius, a, and the number
# of points in the coil, n, and spits out three coordinates for the element of
# length.
function elementOfLength(N,l,a,n)
  Δθ = 2*pi*N/n
  θ = linspace(0,2*pi*N - dθ,n)
  Δx = -a*sin.(θ)
  Δy = a*cos.(θ)
  Δz = (l/(2*pi*N))*ones(size(θ))
  return Δx,Δy,Δz
end