use strict;
use warnings;

do {
    my $name = "world";
    say_hello($name);
};

do_forking_thing();

throw_uncaught_exception();

sub say_hello {
    my $who = shift;
    my $message = format_message("Hello", $who);
    print $message,"\n"
}

sub format_message {
    my($greeting, $person) = @_;
    return join(', ', $greeting, $person);
}

sub do_forking_thing {
    if (my $pid = fork()) {
        print "In parent, child pid is $pid\n";
        my $waited = waitpid($pid, 0);
        print "Child process is done\n";
    } else {
        print "*** In child, press enter to finish up...\n";
        scalar(<STDIN>);
        print "*** child exiting\n";
        exit;
    }
}

sub throw_uncaught_exception {
    die "Ow, my eye!\n";
}

