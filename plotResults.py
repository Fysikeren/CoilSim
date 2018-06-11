#!/usr/bin/python3
# from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import numpy as np

# X = np.genfromtxt("Output/X.txt", unpack=True)
X = np.genfromtxt("Output/X.txt")
Z = np.genfromtxt("Output/Z.txt")
Bx = np.genfromtxt("Output/Bx.txt")
By = np.genfromtxt("Output/By.txt")
Bz = np.genfromtxt("Output/Bz.txt")

plt.clf()
plt.contourf(X,Z,Bx)
plt.savefig('Output/Bx.png')

plt.clf()
plt.contourf(X,Z,By)
plt.savefig('Output/By.png')

plt.clf()
plt.contourf(X,Z,Bz)
plt.savefig('Output/Bz.png')

# Axes3D.plot_surface(X,Z,Bz)
# plt.show()