use strict;
use warnings;
use AI::MXNet qw(mx);
use Time::HiRes qw(time);
use Parallel::ForkManager;

my $ctx = mx->context->cpu;

my $size = 1024;        # tamaño de matrices
my $ops_per_child = 20; # operaciones por proceso
my @procs_list = (1, 2, 4, 6, 8, 12);

my @result_lines = ("Procesos,TotalOps,TiempoTotal,TiempoPorOp");

print "🏁 Benchmark escalado:\n";
for my $n_procs (@procs_list) {
    print "\n🔢 Ejecutando con $n_procs procesos...\n";
    my $start = time();
    my $pm = Parallel::ForkManager->new($n_procs);

    for (1..$n_procs) {
        $pm->start and next;

        my $A = mx->nd->random_uniform(0, 1, shape => [$size, $size], ctx => $ctx);
        my $B = mx->nd->random_uniform(0, 1, shape => [$size, $size], ctx => $ctx);

        for (1..$ops_per_child) {
            my $C = mx->nd->dot($A, $B);
            $C->wait_to_read;
        }

        $pm->finish;
    }

    $pm->wait_all_children;
    my $end = time();

    my $total_ops = $n_procs * $ops_per_child;
    my $elapsed = $end - $start;
    my $avg = $elapsed / $total_ops;

    printf("✅ %2d procesos | %4d ops | ⏱ %.3f s total | ⚡ %.5f s/op\n", $n_procs, $total_ops, $elapsed, $avg);
    push @result_lines, join(",", $n_procs, $total_ops, $elapsed, $avg);
}

# Guardar resultados en CSV
my $csv_file = "benchmark_results.csv";
open my $fh, ">", $csv_file or die "No puedo abrir $csv_file: $!";
print $fh "$_\n" for @result_lines;
close $fh;

print "\n📄 Resultados guardados en: $csv_file\n";

