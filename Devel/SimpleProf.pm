package Devel::SimpleProf;

use strict;
use warnings;
use base qw(Devel::Chitin);
use Time::HiRes;

Devel::SimpleProf->attach();
Devel::SimpleProf->trace(1);

my($last_location, $last_time) = (0, Time::HiRes::time);

sub notify_trace {
    my $now = Time::HiRes::time();
    my($self, $location) = @_;

    if ($last_location) {
        my $diff = $now - $last_time;
        printf("%s:%d took %0.3f ms\n",
                $last_location->filename,
                $last_location->line,
                ($now - $last_time)*1000);
    }
}

sub notify_trace_resumed {
    my($self, $location) = @_;
    $last_location = $location;
    $last_time = Time::HiRes::time;
}

1;
