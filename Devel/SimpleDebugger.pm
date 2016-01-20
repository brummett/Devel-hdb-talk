package Devel::SimpleDebugger;

use base qw(Devel::Chitin);
Devel::SimpleDebugger->attach();

sub notify_stopped {
    my($self, $location) = @_;
    my $file_lines = $self->file_source($location->filename);

    printf("Stopped at %s:%d >> %s",
            $location->filename,
            $location->line,
            $file_lines->[ $location->line ]);
    scalar(<STDIN>);
    $self->step;
}

1;
