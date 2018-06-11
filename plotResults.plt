#!/usr/bin/gnuplot
reset

# set terminal png size 512,768
set terminal pngcairo size 512,768 enhanced font 'Verdana,9'

# define axis
# remove border on top and right and set color to gray
set style line 11 lc rgb '#808080' lt 1
# set border 3 back ls 11
set tics nomirror
# define grid
set style line 12 lc rgb '#808080' lt 0 lw 1
set grid back ls 12

# color definitions
set style line 1 lc rgb '#8b1a0e' pt 1 ps 1 lt 1 lw 2 # --- red
set style line 2 lc rgb '#5e9c36' pt 6 ps 1 lt 1 lw 2 # --- green

set key top right

set output 'Output/theCoil.png'
# set view equal xyz
# set size ratio -1
splot "Output/theCoil.txt" u 1:2:3 with line ls 2 title 'The coil'

set dgrid3d 50,50
set contour

set output 'Output/Bx.png'
splot "Output/XZBx.txt" u 1:2:3 with line ls 1

set output 'Output/By.png'
splot "Output/XZBy.txt" u 1:2:3 with line ls 1

set output 'Output/Bz.png'
splot "Output/XZBz.txt" u 1:2:3 with line ls 1

# pause -1 "Hit any key to continue"