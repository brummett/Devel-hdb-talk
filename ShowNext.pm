package ShowNext;

use parent qw(Devel::Chitin);

ShowNext->attach();
ShowNext->trace(1);

my $ready = 0;
INIT { $ready = 1 }

sub notify_trace {
    my($self, $loc) = @_;
    return unless $ready;
    print "On line ",$loc->line,", next: ", $self->next_statement(1),"\n";
    
    local $@;
    if (my $part_of = eval { $self->next_statement(2) }) {
        print "\tpart of $part_of\n";
    }
}

1;
