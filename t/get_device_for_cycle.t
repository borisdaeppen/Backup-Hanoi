use feature 'say';
use Test::More tests => 16;
use Backup::Hanoi;

#require_ok( 'Backup::Hanoi' );

my $devices =   [
                    'A',
                    'B',
                    'C',
                    'D',
                ];

my $backup = Backup::Hanoi->new($devices);

is $backup->get_device_for_cycle( 1), 'A', 'cycle  1';
is $backup->get_device_for_cycle( 2), 'B', 'cycle  2';
is $backup->get_device_for_cycle( 3), 'A', 'cycle  3';
is $backup->get_device_for_cycle( 4), 'C', 'cycle  4';
is $backup->get_device_for_cycle( 5), 'A', 'cycle  5';
is $backup->get_device_for_cycle( 6), 'B', 'cycle  6';
is $backup->get_device_for_cycle( 7), 'A', 'cycle  7';
is $backup->get_device_for_cycle( 8), 'D', 'cycle  8';
is $backup->get_device_for_cycle( 9), 'A', 'cycle  9';
is $backup->get_device_for_cycle(10), 'B', 'cycle 10';
is $backup->get_device_for_cycle(11), 'A', 'cycle 11';
is $backup->get_device_for_cycle(12), 'C', 'cycle 12';
is $backup->get_device_for_cycle(13), 'A', 'cycle 13';
is $backup->get_device_for_cycle(14), 'B', 'cycle 14';
is $backup->get_device_for_cycle(15), 'A', 'cycle 15';

is $backup->get_device_for_cycle(16), 'D', 'cycle 16';
