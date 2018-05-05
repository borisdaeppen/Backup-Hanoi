use feature 'say';
use Test::More tests => 33;
use Backup::Hanoi;

#require_ok( 'Backup::Hanoi' );

my $devices =   [
                    'A',
                    'B',
                    'C',
                    'D',
                ];

my $backup = Backup::Hanoi->new($devices);

is $backup->get_device_for_cycle( 0), 'D', 'cycle  0';

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
is $backup->get_device_for_cycle(17), 'A', 'cycle 17';
is $backup->get_device_for_cycle(18), 'B', 'cycle 18';
is $backup->get_device_for_cycle(19), 'A', 'cycle 19';
is $backup->get_device_for_cycle(20), 'C', 'cycle 20';
is $backup->get_device_for_cycle(21), 'A', 'cycle 21';
is $backup->get_device_for_cycle(22), 'B', 'cycle 22';
is $backup->get_device_for_cycle(23), 'A', 'cycle 23';
is $backup->get_device_for_cycle(24), 'D', 'cycle 24';
is $backup->get_device_for_cycle(25), 'A', 'cycle 25';
is $backup->get_device_for_cycle(26), 'B', 'cycle 26';
is $backup->get_device_for_cycle(27), 'A', 'cycle 27';
is $backup->get_device_for_cycle(28), 'C', 'cycle 28';
is $backup->get_device_for_cycle(29), 'A', 'cycle 29';
is $backup->get_device_for_cycle(30), 'B', 'cycle 30';
is $backup->get_device_for_cycle(31), 'A', 'cycle 31';

is $backup->get_device_for_cycle(32), 'D', 'cycle 32';
