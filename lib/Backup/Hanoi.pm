package Backup::Hanoi;

use strict;
use warnings;

sub new {
    my $class   = shift;
    my $devices = shift // [];

    my $self = {}; 

    $self->{devices} = $devices;

    bless $self, $class;

    return $self;
}

sub get_device_for_cycle {

    my $self  = shift;
    my $cycle = shift // 0;

    # the number of devices predicts the size of the cycles
    my $devices_count = scalar @{$self->{devices}};

    # half a hanoi cycle is just what we need for backup
    my $hanoi_cycles_half = (2**$devices_count) / 2;

    # allow cycles to cross the limit, map them to first half
    my $modulo_cycle = $cycle % $hanoi_cycles_half;

    # change zero to maximum, so that zero gets highest device
    $modulo_cycle = $hanoi_cycles_half if ($modulo_cycle == 0);

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
