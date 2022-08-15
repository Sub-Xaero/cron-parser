# CRON Parser

### Dependencies

- Ruby 2.7.6

To run this script you will need an installed version of Ruby. You should install Ruby using your favourite version
manager. I recommend RVM.

Once you have Ruby installed and accessible on your path, you are ready to run the script.

### Setup steps

To run the script, you can either invoke Ruby to run the script, or on Unix systems you can  
give the script executable permissions and run the script directly.

To make the script executable you can run `chmod +x ./cron-parser.rb`.

### Running the program

You can invoke the script on the commandline i.e.

`ruby cron-parser.rb "0 0 * * * /usr/bin/find"`

`./cron-parser.rb "0 0 * * * /usr/bin/find"`

`./cron-parser.rb "*/15 0 1,15 JAN,MAR SUN-MONDAY /usr/bin/find"`

### Running the tests

There is a full test suite under `/test`.
To run the tests you will need to bundle a few dependencies.
Run `bundle install`, which will install `minitest`.

You can then run the tests with `rake test`.
