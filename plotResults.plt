#!/usr/bin/gnuplot
reset

# set terminal png size 768,432
set terminal pngcairo size 1920,1080 enhanced font 'Verdana,20'

# define axis
# remove border on top and right and set color to gray
set style line 11 lc rgb '#808080' lt 1
# set border 3 back ls 11
set tics nomirror
# define grid
set style line 12 lc rgb '#808080' lt 0 lw 1
set grid back ls 12

# color definitions
set style line 1 lc rgb '#901A1E' pt 1 ps 1 lt 1 lw 2 # --- kured
set style line 2 lc rgb '#00543C' pt 6 ps 1 lt 1 lw 2 # --- kugreen
set style line 3 lc rgb '#505050' pt 6 ps 1 lt 1 lw 2 # --- grey

set key top right
set autoscale fix
set xyplane 0

set output 'Output/theCoil.png'
# set view equal xyz
# set size ratio -1
splot "Output/theCoil.txt" u 1:2:3 with line ls 2 title 'The coil'

set dgrid3d 75,75
# set contour

set output 'Output/Bx.png'
set zrange [-2e-6:4e-6]
splot "Output/XZBx.txt" u 1:2:3 with line ls 1 title 'B_x'

set output 'Output/By.png'
splot "Output/XZBy.txt" u 1:2:3 with line ls 1 title 'B_y'

set output 'Output/Bz.png'
splot "Output/XZBz.txt" u 1:2:3 with line ls 1 title 'B_z'

# set output 'Output/Ball.png'
# splot   "Output/XZBx.txt" u 1:2:3 with line ls 1 title 'B_x',\
#         "Output/XZBy.txt" u 1:2:3 with line ls 2 title 'B_y',\
#         "Output/XZBz.txt" u 1:2:3 with line ls 3 title 'B_z'

# pause -1 "Hit any key to continue"