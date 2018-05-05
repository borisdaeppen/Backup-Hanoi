package Backup::Hanoi;
# ABSTRACT: select backup according to algo

use strict;
use warnings;

sub new {
    my $class   = shift;
    my $devices = shift // [];

    die "You need at least three devices, for this to work.\n"
        if ($devices < 3);

    # the number of devices predicts the size of the cycles
    my $device_count = scalar @{$devices};

    # half a hanoi cycle is just what we need for backup
    my $hanoi_cycles_half = (2**$device_count) / 2;

    my $self = {    devices           => $devices,
                    hanoi_cycles_half => $hanoi_cycles_half,
               };

    bless $self, $class;

    return $self;
}

sub get_device_for_cycle {

    my $self  = shift;
    my $cycle = shift // 0;

    # allow cycle to cross hanoi limit, map it to first half
    my $modulo_cycle = $cycle % $self->{hanoi_cycles_half};

    # change zero to maximum, so that zero gets highest device
    $modulo_cycle = $self->{hanoi_cycles_half}
        if ($modulo_cycle == 0);

    # calculate which device is used for given cycle
    my $hanoi_number = 
        _get_right_zeros_from_digital_representation(
                $modulo_cycle);

    # select and return device
    return $self->{devices}->[$hanoi_number];

}

sub _get_right_zeros_from_digital_representation {

    my $number = shift;

    # convert to binary format: e.g. number 5 -> 101
    my $binary = sprintf "%b", $number;

    # represent number zero as empty string
    $binary = '' if ($binary == 0);


    # count the zeros, at the right from the binary number

    my $zeros_from_the_right = 0;

    if ( $binary =~ /(0+)$/ ) {
        my $zero_capture = $1;

        $zeros_from_the_right = length $zero_capture;
    }

    return $zeros_from_the_right;
}

1;

__END__

=encoding utf8

=head1 SYNOPSIS

This is an early release.
This code is currently not used in production by the author.
Use it with care!

 my @devices = ('A', 'B', 'C', 'D');
 my $backup  = Backup::Hanoi->new(\@devices);

 # calculate the next 100 backup cycles
 for (0 .. 99) {
     print $backup->get_device_for_cycle($_);
     print "\n";
 }

See also the script L<backup-hanoi>.

=head1 FUNCTIONS

=head2 get_device_for_cycle

Takes a reference to a list with at least three items.

=head2 get_device_for_cycle

Give a positive integer greather than zero, receive a string which reprecents the selcted item.
