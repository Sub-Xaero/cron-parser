
require_relative 'time_expression'

class DayExpression < TimeExpression

  RANGE = (1..31).freeze

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
    when /^\d+$/
      [expression.to_i]
    else
      raise ArgumentError, "Invalid or unrecognised expression: #{expression}"
    end
  end

end
