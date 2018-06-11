function meshgrid(x,y)
    nx = length(x)
    ny = length(y)
  
    X = repmat(x',ny,1)
    Y = repmat(y,1,nx)
  
    return X,Y
end