# defineTestPoints
# Constructs matrices of points in the x and z planes, where we want to
# calculate the magnetic field. Also returns empty arrays of the right size to
# hold the three components of the magnetic field.
function defineTestPoints(a,l,nGrid)
    xs = linspace(-1.50*a,1.50*a,nGrid)
    zs = linspace(-0.75*l,0.75*l,2*nGrid) # The length of the coil is roughly twice its diameter, so we use twice as many points along the z direction

    X,Z = meshgrid(xs,zs)
    Y = zeros(size(X))

    Bx = zeros(size(X))
    By = zeros(size(X))
    Bz = zeros(size(X))

    return X,Y,Z,Bx,By,Bz
end