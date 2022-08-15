require_relative 'time_expression'

class MonthExpression < TimeExpression

  MONTHS = {
    'JAN' => 1,
    'FEB' => 2,
    'MAR' => 3,
    'APR' => 4,
    'MAY' => 5,
    'JUN' => 6,
    'JUL' => 7,
    'AUG' => 8,
    'SEP' => 9,
    'OCT' => 10,
    'NOV' => 11,
    'DEC' => 12
  }.freeze

  RANGE = (1..12).freeze

  def occurrences
    clamp_array(super, RANGE.begin, RANGE.end)
  end

  private

  def parse_expression(expression)
    case expression
    when '*' # Wildcard
      RANGE.to_a
    when /^\*\/\d+$/ # Interval
      interval = expression.gsub(/\*\//, '').to_i
      raise ArgumentError, "Invalid interval: #{interval}" if interval <= 0

      RANGE.step(interval).to_a
    when /^(#{month_regex_str})$/i # Single month word i.e. "JAN"
      month = MONTHS[expression.upcase]
      raise ArgumentError, "Invalid month: #{expression}" if month.nil?
      [month]
    when /^(#{month_regex_str})\-(#{month_regex_str})$/i # Range of month words i.e. "JAN-FEB"
      from_month, to_month = expression.split('-')
      from_month_index = MONTHS[from_month]
      raise ArgumentError, "Invalid month: #{from_month}" if from_month_index.nil?

      to_month_index = MONTHS[to_month]
      raise ArgumentError, "Invalid month: #{to_month}" if to_month_index.nil?

      (from_month_index..to_month_index).to_a
    else
      super
    end
  end

  # @return [String] A string of all the month words separated by a pipe, for use in a Regex capture group.
  # @example "JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC"
  def month_regex_str
    MONTHS.keys.join('|')
  end

end
