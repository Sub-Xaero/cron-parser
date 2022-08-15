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
    when '*'  # Wildcard
      RANGE.to_a
    when /^\*\/\d+$/ # Interval
      interval = expression.gsub(/\*\//, '').to_i
      raise ArgumentError, "Invalid interval: #{interval}" if interval <= 0

      RANGE.step(interval).to_a
    when /^(#{weekday_regex_str})$/ # Single weekday word (e.g. 'SUN')
      day = DAYS[expression.strip.upcase]
      raise ArgumentError, "Invalid weekday: #{expression}" if day.nil?
      [day]
    when /^(#{weekday_regex_str})-(#{weekday_regex_str})$/ # Range of weekday words (e.g. MON-FRI)
      from_day, to_day = expression.split('-')
      from_day_index = DAYS[from_day]
      raise ArgumentError, "Invalid day: #{from_day}" if from_day_index.nil?

      to_day_index = DAYS[to_day]
      raise ArgumentError, "Invalid day: #{to_day}" if to_day_index.nil?

      (from_day_index..to_day_index).to_a
    else
      super
    end
  end

  # @return [String] A string of all the weekday words separated by a pipe, for use in a Regex capture group.
  # @example "SUN|MON|TUE|WED|THU|FRI|SAT"
  def weekday_regex_str
    DAYS.keys.join('|')
  end

end
