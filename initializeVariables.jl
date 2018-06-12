# initializeVariables
# Outputs the variables necessary for calculating the coil.
# Could be changed into a promt for the user.
function initializeVariables()
    N = 100 # Number of turns in coil
    l = 25e-3 # Length of coil, m
    a0 = 7.25e-3 # Inner radius of coil, m
    Δa = 0.2e-3 # The thickness of one layer of turns. This is the outer diameter of the magnet wire, which includes the enamel
    n = Int(1e4) # Number of points in the model of the coil
    return N,l,a0,Δa,n
end