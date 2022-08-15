require_relative 'time_expression'

class DayExpression < TimeExpression

  RANGE = (1..31).freeze

  def occurrences
    clamp_array(super, RANGE.begin, RANGE.end)
  end

  private

  def parse_expression(expression)
    case expression
    when '*' # Wildcard
      RANGE.to_a
    when /^\*\/\d+$/ # Interval
      interval = expression.slice(2..).to_i
      raise ArgumentError, "Invalid interval: #{interval}" if interval <= 0

      RANGE.step(interval).to_a
    else
      super
    end
  end

end
