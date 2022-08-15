require_relative 'time_expression'

class HourExpression < TimeExpression

  RANGE = (0..23).freeze

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
    else
      super
    end
  end

end
