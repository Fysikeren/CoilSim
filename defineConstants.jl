# initializeVariables
# Outputs the variables necessary for calculating the coil.
# Could be changed into a promt for the user.
function defineConstants()
    N = 10 # Number of turns in coil
    a0 = 7.25e-3 # Inner radius of coil, m
    Δa = 0.2e-3 # The thickness of one layer of turns. This is the outer diameter of the magnet wire, which includes the enamel
    l = N*Δa # Length of coil, m
    n = Int(1e2) # Number of points in the model of the coil
    return N,l,a0,Δa,n
end