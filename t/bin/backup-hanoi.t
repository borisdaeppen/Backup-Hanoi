use Test::Script tests => 3;

script_compiles('bin/backup-hanoi');
script_runs(['bin/backup-hanoi', 't/bin/example_devices.txt', 8]);
script_stdout_is("D\n", 't/bin/example_devices 8 -> D');
