% importAndPlot.m
clear

coilCoordinates = importdata('Output/theCoil.txt');

X = importdata('Output/X.txt');
Y = importdata('Output/Y.txt');
Z = importdata('Output/Z.txt');
Bx = importdata('Output/Bx.txt');
By = importdata('Output/By.txt');
Bz = importdata('Output/Bz.txt');

% Mathematica uses "Indeterminate" where Matlab would use "NaN", so we replace
% those:
!sed -i 's/Indeterminate/NaN/g' Output/XZBzAnalytic.txt
XZBzAnalytic = importdata('Output/XZBzAnalytic.txt');

n = sqrt(size(XZBzAnalytic,1)/2);

% X = reshape(XZBzAnalytic(:,1),2*n,n);
% Z = reshape(XZBzAnalytic(:,2),2*n,n);
BzAnalytic = reshape(XZBzAnalytic(:,3),2*n,n);

whos

setPlotSize(16,9,'centimeter')

clf; hold on
plot3(coilCoordinates(:,1),coilCoordinates(:,3),coilCoordinates(:,2))
xlabel('x')
ylabel('z')
zlabel('y')
xlim([min(min(X)) max(max(X))])
ylim([min(min(Z)) max(max(Z))])
% zlim([min(coilCoordinates(:,3)) max(coilCoordinates(:,3))])
zlim([min(min(X)) max(max(X))])
view(30,30)
box on
grid on
filename = 'Output/theCoil';
print(1,filename,'-dpng','-r300')
% savefig(1,filename)
% matlab2tikz([filename '.tikz'],'height','\figureheight','width','\figurewidth','showInfo',false);

quiver3(X,Z,Y,Bx,Bz,By)
xlabel('x')
ylabel('z')
zlabel('y')
xlim([min(min(X)) max(max(X))])
ylim([min(min(Z)) max(max(Z))])
% zlim([min(coilCoordinates(:,3)) max(coilCoordinates(:,3))])
zlim([min(min(X)) max(max(X))])
view(30,30)
box on
grid on
filename = 'Output/theField';
print(1,filename,'-dpng','-r300')

minimumField = min([min(min(Bx)) min(min(By)) min(min(Bz)) min(min(BzAnalytic))]);
maximumField = max([max(max(Bx)) max(max(By)) max(max(Bz)) max(max(BzAnalytic))]);
% minimumField = -6e-6;
% maximumField = 10e-6;

clf; hold on
mesh(X,Z,Bx)
xlabel('x')
ylabel('z')
zlabel('B_x')
% plot3(coilCoordinates(:,1),coilCoordinates(:,3),coilCoordinates(:,2))
xlim([min(min(X)) max(max(X))])
ylim([min(min(Z)) max(max(Z))])
zlim([minimumField maximumField])
caxis([minimumField maximumField])
view(30,30)
box on
grid on
filename = 'Output/Bx';
print(1,filename,'-dpng','-r300')

clf; hold on
mesh(X,Z,By)
xlabel('x')
ylabel('z')
zlabel('B_y')
% plot3(coilCoordinates(:,1),coilCoordinates(:,3),coilCoordinates(:,2))
xlim([min(min(X)) max(max(X))])
ylim([min(min(Z)) max(max(Z))])
zlim([minimumField maximumField])
caxis([minimumField maximumField])
view(30,30)
box on
grid on
filename = 'Output/By';
print(1,filename,'-dpng','-r300')

clf; hold on
mesh(X,Z,Bz)
xlabel('x')
ylabel('z')
zlabel('B_z')
% plot3(coilCoordinates(:,1),coilCoordinates(:,3),coilCoordinates(:,2))
xlim([min(min(X)) max(max(X))])
ylim([min(min(Z)) max(max(Z))])
zlim([minimumField maximumField])
caxis([minimumField maximumField])
view(30,30)
box on
grid on
filename = 'Output/Bz';
print(1,filename,'-dpng','-r300')

clf; hold on
mesh(X,Z,BzAnalytic)
xlabel('x')
ylabel('z')
zlabel('B_{z,Analytic}')
% plot3(coilCoordinates(:,1),coilCoordinates(:,3),coilCoordinates(:,2))
xlim([min(min(X)) max(max(X))])
ylim([min(min(Z)) max(max(Z))])
zlim([minimumField maximumField])
caxis([minimumField maximumField])
view(30,30)
box on
grid on
filename = 'Output/BzAnalytic';
print(1,filename,'-dpng','-r300')

clf; hold on
mesh(X,Z,Bz - BzAnalytic)
xlabel('x')
ylabel('z')
zlabel('B_z - B_{z,Analytic}')
% plot3(coilCoordinates(:,1),coilCoordinates(:,3),coilCoordinates(:,2))
xlim([min(min(X)) max(max(X))])
ylim([min(min(Z)) max(max(Z))])
% zlim([minimumField maximumField])
caxis([minimumField maximumField])
view(30,30)
box on
grid on
filename = 'Output/BzDifference';
print(1,filename,'-dpng','-r300')