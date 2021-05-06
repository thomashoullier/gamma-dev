#!/bin/gnuplot
set terminal svg
set output "beta-pdfs.svg"

set datafile separator ";"
set style fill solid 0.5

stats "beta-0.5-0.5.txt" nooutput
N = STATS_records
binsize = (STATS_max_x - STATS_min_x) / (N - 1)

set ylabel "Counts"
set yrange [0:2500]

lww=2
set ls 1 lw lww lc rgb "#e41a1c"
set ls 2 lw lww lc rgb "#377eb8"
set ls 3 lw lww lc rgb "#4daf4a"
set ls 4 lw lww lc rgb "#984ea3"
set ls 5 lw lww lc rgb "#ff7f00"

set key center top

plot "beta-0.5-0.5.txt" using 1:2:(binsize) every 1::1::N-2 w l ls 1 title "α=0.5, β=0.5",\
     "beta-5-1.txt" using 1:2:(binsize) every 1::1::N-2 w l ls 2 title "α=5, β=1",\
     "beta-1-3.txt" using 1:2:(binsize) every 1::1::N-2 w l ls 3 title "α=1, β=3",\
     "beta-2-2.txt" using 1:2:(binsize) every 1::1::N-2 w l ls 4 title "α=2, β=2",\
     "beta-2-5.txt" using 1:2:(binsize) every 1::1::N-2 w l ls 5 title "α=2, β=5",\
