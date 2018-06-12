# elementOfLength
# Takes in the number of turns, N, the length, l, the radius, a, and the number
# of points in the coil, n, and spits out three coordinates for the element of
# length.
function elementOfLength(N,l,a,n)
  Δθ = 2*pi*N/n
  θ = linspace(0,2*pi*N - Δθ,n)
  Δx = -a*sin.(θ)
  Δy = a*cos.(θ)
  Δz = (l/(2*pi*N))*ones(size(θ))

  Δl = sqrt((N*2*pi*a)^2 + (l)^2)/n
  normalization = sqrt(a^2 + (l/(2*pi*N))^2)
  Δx,Δy,Δz = [Δx,Δy,Δz]*Δl/normalization

  return Δx,Δy,Δz
end