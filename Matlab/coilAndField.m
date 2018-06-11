clear

nLayers = 1
nExtraLayers = 0
plotAll = 1

nD = 2 % Number of dimensions of the trial point arrays

% f = waitbar(0,'Initializing');

N = 125;
l = 25e-3;
a0 = 7.25e-3; % The inner diameter of the coil
n = 1e4;
% dtheta = 2*pi*N/n;
% theta = linspace(0,2*pi*N - dtheta,n);

% [dx,dy,dz] = elementOfLength(theta,N,l,a);
% [x,y,z] = coordinateOfCoil(theta,N,l,a);

da = 0.2e-3; % The thickness of the wire
% nLayers = 6;
% nExtraLayers = 2;
fraction = 5;

myTitle = sprintf('%i layers of %i turns and %i extra layers of %i turns at either end',nLayers,N,nExtraLayers,N/fraction);

x = []; y = []; z = [];
dx = []; dy = []; dz = [];
% x = zeros(1,n*nLayers + 2*n*nExtraLayers/fraction);
% y = x; z = x;
% dx = x; dy = x; dz = x;

for i = 1:nLayers
  a = a0 + (i - 0.5)*da;
  [newx,newy,newz] = coordinateOfCoil(N,l,a,n);
  if mod(i,2) == 0
    % The layers run back and forth, alternating
    newz = newz(end:-1:1);
  end
  x = [x newx]; y = [y newy]; z = [z newz];
  % allThetas = [allThetas theta];
  [newdx,newdy,newdz] = elementOfLength(N,l,a,n);
  dx = [dx newdx]; dy = [dy newdy]; dz = [dz newdz];
end

for i = (1:nExtraLayers) + nLayers
  a = a0 + (i - 0.5)*da;
  [newx,newy,newz] = coordinateOfCoil(N/fraction,l/fraction,a,n/fraction);
  if mod(i,2) == 0
    % The layers run back and forth, alternating
    newz = newz(end:-1:1);
  end
  newz = newz + (1 - 1/fraction)*l/2;
  x = [x newx]; y = [y newy]; z = [z newz];
  % allThetas = [allThetas theta];
  [newdx,newdy,newdz] = elementOfLength(N,l,a,n);
  dx = [dx newdx]; dy = [dy newdy]; dz = [dz newdz];
end

for i = (1:nExtraLayers) + nLayers
  a = a0 + (i - 0.5)*da;
  [newx,newy,newz] = coordinateOfCoil(N/fraction,l/fraction,a,n/fraction);
  if mod(i,2) == 0
    % The layers run back and forth, alternating
    newz = newz(end:-1:1);
  end
  newz = newz - (1 - 1/fraction)*l/2;
  x = [newx x]; y = [newy y]; z = [newz z];
  % allThetas = [allThetas theta];
  [newdx,newdy,newdz] = elementOfLength(N,l,a,n);
  dx = [dx newdx]; dy = [dy newdy]; dz = [dz newdz];
end

if plotAll
  setPlotSize(24,13.5,'centimeter')
  clf; hold on
  plot3(x,y,z)
  title(myTitle)
  xlabel('x')
  ylabel('y')
  zlabel('z')
  axis equal
  box on
  grid on
  view(30,45)
  filename = 'theCoil';
  print(1,filename,'-dpng','-r300')
  % savefig(1,filename)
  % matlab2tikz([filename '.tikz'],'height','\figureheight','width','\figurewidth','showInfo',false);
end

% plot3(xs,ys,zs)
% plot3(X,Y,Z,'.')

nElements = length(x);

% For 2D:
nGrid = 75;
% For sample only:
% nGridX = 11;
% nGridZ = 25;

switch nD
  case 3
    xs = linspace(-1.4*a,1.4*a,nGrid);
    % xs = 0;
    ys = xs;
    % ys = 0;
    zs = linspace(-0.7*l,0.7*l,2*nGrid);
    [X,Y,Z] = meshgrid(xs,ys,zs);
    % indices = (X.^2 + Y.^2 <= a0^2);
    % X = X(:); Y = Y(:); Z = Z(:);
    % X = X(indices); Y = Y(indices); Z = Z(indices);
  case 2
    % xs = linspace(-1.4*a,1.4*a,nGrid);
    % xs = linspace(-0.7*l,0.7*l,2*nGrid);
    % xs = linspace(-2.5e-3,2.5e-3,nGrid);
    % zs = linspace(-0.7*l,0.7*l,2*nGrid);
    % zs = linspace(-1.05*l,1.05*l,3*nGrid);
    % zs = linspace(-5e-3,5e-3,nGrid);

    % Whole coil:
    xs = linspace(-1.4*a,1.4*a,nGrid);
    zs = linspace(-0.7*l,0.7*l,2*nGrid);
    % Inside coil:
    % xs = linspace(-7e-3,7e-3,nGrid);
    % zs = linspace(-14e-3,14e-3,2*nGrid);
    % Sample only:
    % xs = linspace(-1.1e-3,1.1e-3,nGridX);
    % zs = linspace(-2.5e-3,2.5e-3,nGridZ);

    [X,Z] = meshgrid(xs,zs);
    Y = zeros(size(X));
  otherwise
    disp('The number of dimensions must be 2 or 3.')
end

nTestPoints = numel(X);
% [dx,dy,dz] = elementOfLength(allThetas,N,l,a);

Bx = zeros(size(X));
By = Bx;
Bz = Bx;

pb = CmdLineProgressBar('Calculating field for point ');

tic
% for j = 1
for j = 1:nTestPoints
  % testPoint = [0,0,0];
  testPoint = [X(j),Y(j),Z(j)];
  db = zeros(3,nElements);

  for i = 1:nElements
    dl = [dx(i),dy(i),dz(i)];
    r = testPoint - [x(i),y(i),z(i)];
    rNorm = norm(r);
    % rHat = r/rNorm;
    db(:,i) = cross(dl,r)/(rNorm^3); % Biot-Savart
  end

  % mu0 = 4*pi*1e-7; % H/m
  I = 1e-3; % A
  % db = ((mu0*I)/(4*pi))*db;
  db = I*1e-7*db;
  B = sum(db');

  Bx(j) = B(1);
  By(j) = B(2);
  Bz(j) = B(3);

  % done = j/nTestPoints;
  % fprintf('%5.3f done\n',done)
  % waitbar(done,f,'Calculating field');

  pb.print(j,nTestPoints)
end
toc

indices = (abs(abs(X) - a) < 5*da) & (abs(Z) < l/2 + 5*da);
Bx(indices) = NaN; By(indices) = NaN; Bz(indices) = NaN;

if plotAll
  % waitbar(0,f,'Plotting');

  setPlotSize(24,13.5,'centimeter')
  % clf; hold on
  % quiver3(testPoint(1),testPoint(2),testPoint(3),Bvec(1),Bvec(2),Bvec(3))
  % quiver3(X(:),Y(:),Z(:),Bvec(:,1),Bvec(:,2),Bvec(:,3))
  quiver3(X(:),Y(:),Z(:),Bx(:),By(:),Bz(:))
  % plot3(Bvec(1),Bvec(2),Bvec(3),'.')
  title(myTitle)
  xlabel('x')
  ylabel('y')
  zlabel('z')
  % axis equal
  box on
  grid on
  view(30,45)
  filename = 'theField';
  print(1,filename,'-dpng','-r300')
  % savefig(1,filename)
  % matlab2tikz([filename '.tikz'],'height','\figureheight','width','\figurewidth','showInfo',false);
  % waitbar(0.25,f,'Plotting');

  if nD == 2
    setPlotSize(24,13.5,'centimeter')
    clf;
    quiver(X(:),Z(:),Bx(:),Bz(:))
    title(myTitle)
    xlabel('x')
    ylabel('y')
    grid on
    % view(30,45)
    filename = 'theField2D';
    print(1,filename,'-dpng','-r300')
    % savefig(1,filename)
    % matlab2tikz([filename '.tikz'],'height','\figureheight','width','\figurewidth','showInfo',false);

    clf;
    [sampleX,sampleY] = theSample;

    theMinimumB = min(min(Bz));
    theMaximumB = max(max(Bz));

    subplot(1,3,1); hold on
    surfc(X,Z,Bx)
    % contourf(X,Z,Bx)
    % plot(sampleX,sampleY,'k')
    % xlabel('x')
    % ylabel('z')
    c = colorbar;
    % c.Label.String = 'B_x';
    title('B_x')
    % caxis([theMinimumB theMaximumB])
    axis equal
    box on
    % waitbar(0.35,f,'Plotting');

    subplot(1,3,2); hold on
    surfc(X,Z,By)
    % contourf(X,Z,By)
    % plot(sampleX,sampleY,'k')
    % xlabel('x')
    % ylabel('z')
    c = colorbar;
    % c.Label.String = 'B_y';
    title('B_y')
    % caxis([theMinimumB theMaximumB])
    axis equal
    box on
    % waitbar(0.45,f,'Plotting');

    subplot(1,3,3); hold on
    surfc(X,Z,Bz)
    % contourf(X,Z,Bz)
    % plot(sampleX,sampleY,'k')
    % xlabel('x')
    % ylabel('z')
    c = colorbar;
    % c.Label.String = 'B_z';
    title('B_z')
    % caxis([theMinimumB theMaximumB])
    axis equal
    box on
    % waitbar(0.55,f,'Plotting');

    filename = 'theThreeFields';
    print(1,filename,'-dpng','-r300')
    % savefig(1,filename)
    % matlab2tikz([filename '.tikz'],'height','\figureheight','width','\figurewidth','showInfo',false);
    % waitbar(0.75,f,'Plotting');

    clf; hold on
    surfc(X,Z,Bx)
    % plot(sampleX,sampleY,'k')
    xlabel('x')
    ylabel('z')
    c = colorbar;
    c.Label.String = 'B_x';
    % caxis([theMinimumB theMaximumB])
    view(30,15)
    box on
    pbaspect([1 max(max(zs))/max(max(xs)) 1]) 

    filename = 'theXField';
    print(1,filename,'-dpng','-r300')
    % savefig(1,filename)
    % matlab2tikz([filename '.tikz'],'height','\figureheight','width','\figurewidth','showInfo',false);
    % waitbar(0.85,f,'Plotting');

    clf; hold on
    surfc(X,Z,By)
    % plot(sampleX,sampleY,'k')
    xlabel('x')
    ylabel('z')
    c = colorbar;
    c.Label.String = 'B_y';
    % caxis([theMinimumB theMaximumB])
    view(30,15)
    box on
    pbaspect([1 max(max(zs))/max(max(xs)) 1]) 

    filename = 'theYField';
    print(1,filename,'-dpng','-r300')
    % savefig(1,filename)
    % matlab2tikz([filename '.tikz'],'height','\figureheight','width','\figurewidth','showInfo',false);
    % waitbar(0.925,f,'Plotting');

    clf; hold on
    surfc(X,Z,Bz)
    % plot(sampleX,sampleY,'k')
    xlabel('x')
    ylabel('z')
    c = colorbar;
    c.Label.String = 'B_z';
    % caxis([theMinimumB theMaximumB])
    view(30,15)
    box on
    pbaspect([1 max(max(zs))/max(max(xs)) 1]) 

    filename = 'theZField';
    print(1,filename,'-dpng','-r300')
    % savefig(1,filename)
    % matlab2tikz([filename '.tikz'],'height','\figureheight','width','\figurewidth','showInfo',false);

    theDifference = (max(max(Bz)) - min(min(Bz)))/min(min(Bz));
    fprintf('The relative difference is %.2f percent in the area.\n',theDifference*100)
  end

  % waitbar(1,f,'Plotting');
end

% close(f)

% elementOfLength
% Takes in the number of turns, N, the length, l, the radius, a, and the number
% of points in the coil, n, and spits out three coordinates for the element of
% length.
function [dx,dy,dz] = elementOfLength(N,l,a,n)
  dtheta = 2*pi*N/n;
  theta = linspace(0,2*pi*N - dtheta,n);
  dx = -a*sin(theta);
  dy = a*cos(theta);
  dz = (l/(2*pi*N))*ones(size(theta));
end

% coordinateOfCoil
% Takes in the number of turns, N, the length, l, the radius, a, and the number
% of points in the coil, n, and spits out three coordinates for the point in
% the coil.
function [x,y,z] = coordinateOfCoil(N,l,a,n)
  dtheta = 2*pi*N/n;
  theta = linspace(0,2*pi*N - dtheta,n);
  x = a*cos(theta);
  y = a*sin(theta);
  z = (l/2)*((theta/(pi*N) - 1));
end

function [x,z] = theSample
  x = [-1.1 1.1 1.1 -1.1 -1.1]*1e-3;
  z = [-2.5 -2.5 2.5 2.5 -2.5]*1e-3;
end