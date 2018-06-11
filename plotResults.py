#!/home/mathias/Envs/myProject/bin/python
#!/usr/bin/python3
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
import numpy as np

# X = np.genfromtxt("Output/X.txt", unpack=True)
coil = np.genfromtxt("Output/theCoil.txt")
X = np.genfromtxt("Output/X.txt")
Z = np.genfromtxt("Output/Z.txt")
Bx = np.genfromtxt("Output/Bx.txt")
By = np.genfromtxt("Output/By.txt")
Bz = np.genfromtxt("Output/Bz.txt")

print(coil[:,0])

fig = plt.figure()
ax = fig.gca(projection = '3d')
ax.plot(coil[:,0], coil[:,1], coil[:,2])
fig.savefig('Output/theCoil.png', bbox_inches = "tight")

# plt.clf()
# plt.contourf(X, Z, Bx, cmap=cm.coolwarm)
# plt.savefig('Output/Bx.png', bbox_inches="tight")

# plt.clf()
# plt.contourf(X, Z, By, cmap=cm.coolwarm)
# plt.savefig('Output/By.png', bbox_inches="tight")

# plt.clf()
# plt.contourf(X, Z, Bz, cmap=cm.coolwarm)
# plt.savefig('Output/Bz.png', bbox_inches="tight")

fig = plt.figure()
ax = fig.gca(projection = '3d')
ax.plot_surface(X, Z, Bx, cmap = cm.coolwarm, antialiased = False)
fig.savefig('Output/Bx.png', bbox_inches = "tight")

fig = plt.figure()
ax = fig.gca(projection = '3d')
ax.plot_surface(X, Z, By, cmap = cm.coolwarm, antialiased = False)
fig.savefig('Output/By.png', bbox_inches = "tight")

fig = plt.figure()
ax = fig.gca(projection = '3d')
ax.plot_surface(X, Z, Bz, cmap = cm.coolwarm, antialiased = False)
fig.savefig('Output/Bz.png', bbox_inches = "tight")

# Axes3D.plot_surface(X,Z,Bz)
# plt.show()