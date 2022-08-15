#!ruby

args = ARGV

expression = args[0].strip

parts = expression.split(' ')

minute_expression, hour_expression, day_expression, month_expression, weekday_expression, executable = parts

puts "minute_expression: #{minute_expression}"
puts "hour_expression: #{hour_expression}"
puts "day_expression: #{day_expression}"
puts "month_expression: #{month_expression}"
puts "weekday_expression: #{weekday_expression}"
puts "executable: #{executable}"
