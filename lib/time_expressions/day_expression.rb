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
    when /^\d+-\d+\/\d+$/ # Range with Interval
      from_to_str, interval_str = expression.split("/")
      from, to = from_to_str.split('-').map(&:to_i)
      interval = interval_str.to_i

      raise ArgumentError, "Invalid interval: #{interval}" if interval <= 0
      raise ArgumentError, "Invalid from number in range: #{from}" if from <= 0
      raise ArgumentError, "Invalid to number in range: #{to}" if to <= 0

      (from..to).step(interval).to_a
    when /^\*\/\d+$/ # Interval
      interval = expression.slice(2..).to_i
      raise ArgumentError, "Invalid interval: #{interval}" if interval <= 0

      RANGE.step(interval).to_a
    else
      super
    end
  end

end
