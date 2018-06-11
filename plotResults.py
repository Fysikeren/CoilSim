#!/usr/bin/python3
import matplotlib.pyplot as plt
import numpy as np

# X = np.genfromtxt("Output/X.txt", unpack=True)
X = np.genfromtxt("Output/X.txt")
Z = np.genfromtxt("Output/Z.txt")
Bz = np.genfromtxt("Output/Bz.txt")

plt.contour(X,Z,Bz)
