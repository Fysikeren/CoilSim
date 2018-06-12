% importAndPlot.m
clear

coilCoordinates = importdata('Output/theCoil.txt');

% importdata('Output/XZBx.txt', [X[:] Z[:] Bx[:]]);
% importdata('Output/XZBy.txt', [X[:] Z[:] By[:]]);
% importdata('Output/XZBz.txt', [X[:] Z[:] Bz[:]]);

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

minimumField = min([min(min(Bx)) min(min(By)) min(min(Bz))]);
maximumField = max([max(max(Bx)) max(max(By)) max(max(Bz))]);

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