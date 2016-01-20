package Devel::SimpleProf;

use strict;
use warnings;
use base qw(Devel::Chitin);
use Time::HiRes;

Devel::SimpleProf->attach();
Devel::SimpleProf->trace(1);

my($last_line, $last_time);
sub notify_trace {
    my $now = Time::HiRes::time();
    my($self, $location) = @_;

    my $this_line = $location->line;
    if ($last_line) {
        my $diff = $now - $last_time;
        printf("Line %s took %0.3f ms\n",
                $last_line, ($now - $last_time)*1000);
    }

    ($last_line, $last_time) = ($this_line, Time::HiRes::time);
}
        
