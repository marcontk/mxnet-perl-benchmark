set datafile separator ","
set title "Benchmark Paralelo con Perl + MXNet (Mac Pro 2013)"
set xlabel "Número de procesos"
set ylabel "Tiempo (segundos)"
set grid
set key outside top center horizontal
set term pngcairo size 900,600 enhanced font 'Verdana,10'
set output 'benchmark_plot.png'

plot \
    "benchmark_results.csv" using 1:4 with linespoints title "⏱ Tiempo por operación" lw 2 pt 7 lc rgb "blue", \
    "benchmark_results.csv" using 1:3 with linespoints title "🕒 Tiempo total" lw 2 pt 5 lc rgb "red"

