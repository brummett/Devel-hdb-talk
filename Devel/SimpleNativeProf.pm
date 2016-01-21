package Devel::SimpleNativeProf;

use strict;
use warnings;
use Time::HiRes;

CHECK { $DB::trace = 1 }

package DB; 
our @file_lines;
my($last_line, $last_line_executed, $last_file, $last_time);
sub DB {
    my $now = Time::HiRes::time;
    my($package, $filename, $line) = caller;

    *file_lines = $main::{'_<' . $filename};

    if ($last_line) {
        my $diff = $now - $last_time;
        printf("%s:%d took %0.3f ms\n\t%s\n",
                $last_file,
                $last_line,
                $diff * 1000,
                $last_line_executed);
    }

    $last_line = $line;
    $last_line_executed = $file_lines[$line];
    $last_file = $filename;
    $last_time = Time::HiRes::time;
}

1;
