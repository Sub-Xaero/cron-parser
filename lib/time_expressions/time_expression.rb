class TimeExpression

  def initialize(expression)
    @expressions = expression.split(",")
  end

  def occurrences
    @expressions.map { |expression| parse_expression(expression) }.flatten.uniq.sort
  end

  private

  def parse_expression(expression)
    raise NotImplementedError, "You must define #parse_expression in #{self.class}"
  end

  def clamp_array(array, min, max)
    array.filter { |value| value >= min && value <= max }
  end

end
