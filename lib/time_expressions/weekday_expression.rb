require_relative 'time_expression'

class WeekdayExpression < TimeExpression

  DAYS = {
    'SUN' => 0,
    'MON' => 1,
    'TUE' => 2,
    'WED' => 3,
    'THU' => 4,
    'FRI' => 5,
    'SAT' => 6
  }.freeze

  RANGE = (0..6).freeze

  def occurrences
    clamp_array(super, RANGE.begin, RANGE.end)
  end

  private

  def parse_expression(expression)
    case expression
    when '*'
      RANGE.to_a
    when /^\*\/\d+$/
      interval = expression.gsub(/\*\//, '').to_i
      raise ArgumentError, "Invalid interval: #{interval}" if interval <= 0

      RANGE.step(interval).to_a
    when /^\d+-\d+$/
      from, to = expression.split('-').map(&:to_i)
      (from..to).to_a
    when Regexp.new("^#{weekday_regex_str}$")
      [DAYS[expression.strip.upcase.slice(0, 3)]]
    when Regexp.new("^#{weekday_regex_str}-#{weekday_regex_str}$")
      from_day, to_day = expression.split('-')
      from_day = from_day.strip.upcase.slice(0, 3)
      to_day = to_day.strip.upcase.slice(0, 3)
      from_day_index = DAYS[from_day]
      raise ArgumentError, "Invalid day: #{from_day}" if from_day_index.nil?

      to_day_index = DAYS[to_day]
      raise ArgumentError, "Invalid day: #{to_day}" if to_day_index.nil?

      (from_day_index..to_day_index).to_a
    when /^\d+$/
      [expression.to_i]
    else
      raise ArgumentError, "Invalid or unrecognised expression: #{expression}"
    end
  end

  def weekday_regex_str
    DAYS.keys.join('|')
  end

end
