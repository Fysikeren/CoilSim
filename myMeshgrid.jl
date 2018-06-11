# meshgrid
# Emulates the 2D version of Matlab's meshgrid function
# Needs expansion to 3D
function meshgrid(x,y)
    nx = length(x)
    ny = length(y)
  
    X = repmat(x',ny,1)
    Y = repmat(y,1,nx)
  
    return X,Y
end