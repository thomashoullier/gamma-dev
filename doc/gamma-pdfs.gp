#!/bin/gnuplot
set terminal svg
set output "gamma-pdfs.svg"

set datafile separator ";"
set style fill solid 0.5

stats "gamma-1-2.txt" nooutput
N = STATS_records
binsize = (STATS_max_x - STATS_min_x) / (N - 1)

set ylabel "Counts"
set yrange [0:10000]

# TODO: * Superimpose the analytical gamma PDFs.

plot "gamma-1-2.txt" using 1:2:(binsize) every 1::1::N-2 w l title "a=1, b=2" lc rgb "red",\
     "gamma-2-2.txt" using 1:2:(binsize) every 1::1::N-2 w l title "a=2, b=2" lc rgb "orange",\
     "gamma-3-2.txt" using 1:2:(binsize) every 1::1::N-2 w l title "a=3, b=2" lc rgb "yellow",\
     "gamma-5-1.txt" using 1:2:(binsize) every 1::1::N-2 w l title "a=5, b=1" lc rgb "green",\
     "gamma-9-0.5.txt" using 1:2:(binsize) every 1::1::N-2 w l title "a=9, b=0.5" lc rgb "black",\
     "gamma-7.5-1.txt" using 1:2:(binsize) every 1::1::N-2 w l title "a=7.5, b=1" lc rgb "blue",\
     "gamma-0.5-1.txt" using 1:2:(binsize) every 1::1::N-2 w l title "a=0.5, b=1" lc rgb "purple"
