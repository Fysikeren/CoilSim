#!/usr/bin/gnuplot
set terminal png size 512,768

set output 'Output/theCoil.png'
# set view equal xyz
# set size ratio -1
splot "Output/theCoil.txt" u 1:2:3 with lines

set dgrid3d 50,50

set output 'Output/Bx.png'
splot "Output/XZBx.txt" u 1:2:3 with lines

set output 'Output/By.png'
splot "Output/XZBy.txt" u 1:2:3 with lines

set output 'Output/Bz.png'
splot "Output/XZBz.txt" u 1:2:3 with lines

# pause -1 "Hit any key to continue"