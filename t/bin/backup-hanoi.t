use Test::Script tests => 11;

script_compiles('bin/backup-hanoi');

script_runs(['bin/backup-hanoi', 't/bin/example_devices.txt', 8]);
script_stdout_is("D\n", 't/bin/example_devices 8 -> D');

script_runs(['bin/backup-hanoi', 't/bin/example_devices.txt', -1]);
script_stdout_is("D\n", 't/bin/example_devices -1 -> D');

script_runs(['bin/backup-hanoi', 't/bin/example_devices.txt', -1, 1]);
script_stdout_is("D\nE\nA\n", 't/bin/example_devices -1 1 -> DEA');

script_runs(['bin/backup-hanoi', 't/bin/example_devices.txt', "init", 0]);
script_stdout_is("A\nB\nC\nD\nE\n", 't/bin/example_devices init 0 -> ABCDE');

script_runs(['bin/backup-hanoi', 't/bin/example_devices.txt', "-4", 0]);
script_stdout_is("A\nB\nC\nD\nE\n", 't/bin/example_devices -4 0 -> ABCDE');
