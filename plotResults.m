% importAndPlot.m
clear

coilCoordinates = importdata('Output/theCoil.txt');

X = importdata('Output/X.txt');
Y = importdata('Output/Y.txt');
Z = importdata('Output/Z.txt');
Bx = importdata('Output/Bx.txt');
By = importdata('Output/By.txt');
Bz = importdata('Output/Bz.txt');

whos

setPlotSize(16,9,'centimeter')

clf; hold on
plot3(coilCoordinates(:,1),coilCoordinates(:,2),coilCoordinates(:,3))
xlim([min(min(X)) max(max(X))])
ylim([min(min(X)) max(max(X))])
zlim([min(coilCoordinates(:,3)) max(coilCoordinates(:,3))])
view(30,30)
box on
grid on
filename = 'Output/theCoil';
print(1,filename,'-dpng','-r300')
% savefig(1,filename)
% matlab2tikz([filename '.tikz'],'height','\figureheight','width','\figurewidth','showInfo',false);

quiver3(X,Y,Z,Bx,By,Bz)
xlim([min(min(X)) max(max(X))])
ylim([min(min(X)) max(max(X))])
zlim([min(coilCoordinates(:,3)) max(coilCoordinates(:,3))])
view(30,30)
box on
grid on
filename = 'Output/theField';
print(1,filename,'-dpng','-r300')

% minimumField = min([min(min(Bx)) min(min(By)) min(min(Bz))]);
% maximumField = max([max(max(Bx)) max(max(By)) max(max(Bz))]);
minimumField = -6e-6;
maximumField = 10e-6;

clf
mesh(X,Z,Bx)
zlim([minimumField maximumField])
view(30,30)
box on
filename = 'Output/Bx';
print(1,filename,'-dpng','-r300')

clf
mesh(X,Z,By)
zlim([minimumField maximumField])
view(30,30)
box on
filename = 'Output/By';
print(1,filename,'-dpng','-r300')

clf
mesh(X,Z,Bz)
zlim([minimumField maximumField])
view(30,30)
box on
filename = 'Output/Bz';
print(1,filename,'-dpng','-r300')

% clear

XZBzAnalytic = importdata('Output/XZBzAnalytic.txt');

n = sqrt(size(XZBzAnalytic,1)/2);

X = reshape(XZBzAnalytic(:,1),2*n,n);
Z = reshape(XZBzAnalytic(:,2),2*n,n);
BzAnalytic = reshape(XZBzAnalytic(:,3),2*n,n);

whos

clf
mesh(X,Z,BzAnalytic)
zlim([minimumField maximumField])
view(30,30)
box on
filename = 'Output/BzAnalytic';
print(1,filename,'-dpng','-r300')