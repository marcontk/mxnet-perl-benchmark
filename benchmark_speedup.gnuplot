set datafile separator ","
set title "Aceleración relativa (Speedup) - Mac Pro 2013"
set xlabel "Número de procesos"
set ylabel "Speedup (vs 1 proceso)"
set grid
set key left top
set term pngcairo size 800,600 enhanced font 'Verdana,10'
set output 'benchmark_speedup.png'

# Tiempo con 1 proceso (ajústalo si cambias dataset)
tiempo_base = 1.011

plot "benchmark_results.csv" using 1:(tiempo_base/$3) with linespoints \
    title "Speedup total" lw 2 pt 7 lc rgb "dark-green"

