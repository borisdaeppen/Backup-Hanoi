package Backup::Hanoi;
# ABSTRACT: select backup according to algo

use strict;
use warnings;

use v5.6.0;

sub new {
    my $class   = shift;
    my $devices = shift;
    $devices = [] unless ($devices); # // operator needs v5.10

    # the number of devices predicts the size of the cycles
    my $device_count = scalar @{$devices};

    die "three devices needed.\n" if ($device_count < 3);

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
    my $cycle = shift;

    $cycle = 0 unless ($cycle); # // operator needs v5.10

    # treat negative numbers as normal FIFO
    # e.g. index -1 gives the second last element
    return $self->{devices}
        ->[(scalar @{$self->{devices}}) + $cycle -1]
            if ($cycle < 0);

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
 
 # enhanced compination with FIFO for initialisation
 # and Hanoi algorithm for overwriting
 for (-3 .. 99) {
     print $backup->get_device_for_cycle($_);
     print "\n";
 }

See also the script L<backup-hanoi>.

=head1 FUNCTIONS

=head2 new

Takes a reference to a list with at least three items.

=head2 get_device_for_cycle

Give any integer, receive a string which represents the selected item.

Negative numbers up to zero select devices according to FIFO.
Where 0 gives back the last element and (elements -1) the first.
This can be used to initialise each empty device.

Positive numbers select according to the algorithm «Tower of Hanoi».
This can be used to efficiently choose which device to overwrite.
