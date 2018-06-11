% testLineElements.m
% Plots the points of the coil along with the line elements (which are shown as
% vector arrows) to check that the functions used for the calculations actually
% give the right thing. It all seems to work alright.

clear

N = 1;
l = 1;
a = 1;
n = 10;

[x,y,z] = coordinateOfCoil(N,l,a,n);
[dx,dy,dz] = elementOfLength(N,l,a,n);
[nx,ny,nz] = coordinateOfCoil(N,l,a,1e2);

clf; hold on
% plot(x,y,'.')
% quiver(x,y,dx,dy)
% plot(nx,ny)
plot3(x,y,z,'.')
quiver3(x,y,z,dx,dy,dz)
plot3(nx,ny,nz)
view(30,45)
grid on

% Test of whether the length of the line elements makes sense
(dx.^2 + dy.^2 + dz.^2) - (a^2 + l^2/(4*pi^2*N^2)) % This should be zero

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