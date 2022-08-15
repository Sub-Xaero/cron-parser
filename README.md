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

## System Architecture

The main entrypoint for the program is `cron-parser.rb`.
This script is responsible for parsing the input and splitting the input string into
the 5 individual fields of the cron expression, and delegating the parsing of the individual fields
to the appropriate parser.

There is a base class, called `TimeExpression`, which is the base class for all expression types and contains a couple
of common helper methods, and some base parser cases that are common across all fields i.e single digit and digit range

All expression types are implemented in their own class that inherits from `TimeExpression`,
extending the `parse_expression` method to implement each of their specific use cases, and delegate back
to `TimeExpression` for any common/shared cases.

The parsing for each expression type is largely done by a cascading series of regexes that detect what type of
expression is being parsed i.e. `*` wildcards or `*/15` increments, and performing the appropriate steps to calculate
the full set of possible values for the expression.

Composite expressions, i.e. those that are comma-separated `1,2,3,4-12` are split and parsed as individual expressions
whose results are zipped together at the end.

Extending the functionality of an expression type is done by adding a new case to the `parse_expression` method.

Adding a new expression type is done by adding a new class that inherits from `TimeExpression` and implementing the
`parse_expression` method.
