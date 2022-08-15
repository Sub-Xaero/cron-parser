
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
    when '*'
      RANGE.to_a
    when /^\*\/\d+$/
      interval = expression.gsub(/\*\//, '').to_i
      raise ArgumentError, "Invalid interval: #{interval}" if interval <= 0

      RANGE.step(interval).to_a
    when /^\d+-\d+$/
      from, to = expression.split('-').map(&:to_i)
      (from..to).to_a
    when /^(#{month_regex_str})$/i
      month = MONTHS[expression.upcase]
      raise ArgumentError, "Invalid month: #{expression}" if month.nil?
      [month]
    when /^(#{month_regex_str})\-(#{month_regex_str})$/i
      from_month, to_month = expression.split('-')
      from_month_index = MONTHS[from_month]
      raise ArgumentError, "Invalid month: #{from_month}" if from_month_index.nil?

      to_month_index = MONTHS[to_month]
      raise ArgumentError, "Invalid month: #{to_month}" if to_month_index.nil?

      (from_month_index..to_month_index).to_a
    when /^\d+$/
      [expression.to_i]
    else
      raise ArgumentError, "Invalid or unrecognised expression: #{expression}"
    end
  end

  def month_regex_str
    MONTHS.keys.join('|')
  end

end
