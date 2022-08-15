class TimeExpression

  attr_reader :expressions

  def initialize(expression)
    @expressions = expression.split(",")
  end

  def occurrences
    @expressions.map { |expression| parse_expression(expression) }.flatten.uniq.sort
  end

  private

  def parse_expression(expression)
    case expression
    when /^\d+$/
      # Single number
      [expression.to_i]
    when /^\d+-\d+$/
      # Number range
      from, to = expression.split('-').map(&:to_i)
      (from..to).to_a
    else
      raise ArgumentError, "Invalid or unrecognised expression: #{expression}"
    end
  end

  def clamp_array(array, min, max)
    while array.first && array.first < min
      array.shift
    end
    while array.first && array.last > max
      array.pop
    end
    array
  end

end
