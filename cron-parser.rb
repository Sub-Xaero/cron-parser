#!ruby

require 'date'
require './lib/time_expressions/minute_expression'
require './lib/time_expressions/hour_expression'
require './lib/time_expressions/day_expression'
require './lib/time_expressions/month_expression'
require './lib/time_expressions/weekday_expression'

args = ARGV

expression = args[0].strip

parts = expression.split(' ')

minute_expression, hour_expression, day_expression, month_expression, weekday_expression, *executable = parts

minutes = MinuteExpression.new(minute_expression).occurrences
hours = HourExpression.new(hour_expression).occurrences
days = DayExpression.new(day_expression).occurrences
months = MonthExpression.new(month_expression).occurrences
weekdays = WeekdayExpression.new(weekday_expression).occurrences

def next_date_instances(counter, minutes:, hours:, days:, months:, weekdays:)
  now = DateTime.now
  year = now.year

  next_instances = []
  loop do
    months.each do |month|
      days.each do |day|
        hours.each do |hour|
          minutes.each do |minute|
            return next_instances if counter == 0

            date = DateTime.new(year, month, day, hour, minute)
            puts date
            if date > now && weekdays.include?(date.wday)
              next_instances << date
              counter -= 1
            end
          end
        end
      end
    end
    year += 1
  end

  next_instances
end

next_instances = next_date_instances(5, minutes: minutes, hours: hours, days: days, months: months, weekdays: weekdays)

def formatted_message(message, limit: 14)
  # If the given string is less than `limit` chars long, pad it, otherwise truncate it
  # The returned string is always `limit` characters long
  message.strip.ljust(limit).slice(0, limit)
end

# Formats the output for the given field and values, as a 14 character padded field name, and a space separated array of values
# @param field [String] The name of the field to output
# @param values [Array] The values to output, as an array
# @return [void]
def field_output(field, values)
  puts "#{formatted_message(field)}#{[*values].join(" ")}"
end

field_output('minute', minutes)
field_output('hour', hours)
field_output('day of month', days)
field_output('month', months)
field_output('day of week', weekdays)
field_output('command', executable)
field_output('next instances', next_instances.map(&:iso8601))
