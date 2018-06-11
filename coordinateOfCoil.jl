# coordinateOfCoil
# Takes in the number of turns, N, the length, l, the radius, a, and the number
# of points in the coil, n, and spits out three coordinates for the point in
# the coil.
function coordinateOfCoil(N,l,a,n)
  dθ = 2*pi*N/n
  θ = linspace(0,2*pi*N - dθ,n)
  x = a*cos.(θ)
  y = a*sin.(θ)
  z = (l/2)*((θ/(pi*N) - 1))
  return x,y,z
end