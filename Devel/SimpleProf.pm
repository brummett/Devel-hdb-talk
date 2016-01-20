package Devel::SimpleProf;

use strict;
use warnings;
use base qw(Devel::Chitin);
use Time::HiRes;

Devel::SimpleProf->attach();
Devel::SimpleProf->trace(1);

my($last_line, $last_time) = (0, Time::HiRes::time);

sub notify_trace {
    my $now = Time::HiRes::time();
    my($self, $location) = @_;

    my $this_line = $location->line;
    if ($last_line) {
        my $diff = $now - $last_time;
        printf("Line %s took %0.3f ms\n",
                $last_line, ($now - $last_time)*1000);
    }
}

sub notify_resumed {
    my($self, $location) = @_;
    $last_line = $location->line;
    $last_time = Time::HiRes::time;
}

1;
