use strict;
use warnings;
package Backup::Hanoi;

use Debug::Statements;
my $d = 1;

sub new {
    my $class   = shift;
    my $devices = shift;

    my $self = {
                    devices  => 0,
               };

    $self->{devices} = $devices;

    bless $self, $class;

    return $self;
}

sub get_device_for_cycle {

    my $self  = shift;
    my $cycle = shift;

    my $devices_count = scalar @{$self->{devices}};
    my $hanoi_cycles = (2**$devices_count) -1;

    my $device_mapped_cycle = $cycle % $hanoi_cycles;

    my $hanoi_number = 
        _get_right_zeros_from_digital_representation(
                $device_mapped_cycle);

    return $self->{devices}->[$hanoi_number];

}

sub _get_right_zeros_from_digital_representation {

    my $number = shift;

    my $binary = sprintf "%b", $number;

    # represent number zero as empty string in binary
    $binary = '' if ($binary == 0);

    my $zeros_from_the_right = 0;

    if ( $binary =~ /(0+)$/ ) {
        my $zero_capture = $1;

        $zeros_from_the_right = length $zero_capture;
    }

    return $zeros_from_the_right;
}

1;
