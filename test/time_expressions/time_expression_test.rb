require 'minitest/autorun'
require "lib/time_expressions/time_expression"

class TimeExpressionTest < Minitest::Test

  def test_initialize
    expression = TimeExpression.new('12,15,30')
    assert_equal(
      ["12", "15", "30"],
      expression.expressions, "The initializer is expected to split the passed comma-separated expression into an array of expressions"
    )

    expression2 = TimeExpression.new('12-15')
    assert_equal(
      ['12-15'],
      expression2.expressions,
      "The initializer does not set the @expressions instance variable to the expected value"
    )
  end

  def test_clamp_array
    clamped_array = TimeExpression.new("").send(:clamp_array, [-1, 1, 2, 3, 4], 1, 3)
    assert_equal [1, 2, 3], clamped_array

    clamped_array = TimeExpression.new("").send(:clamp_array, [1, 2], 1, 2)
    assert_equal [1, 2], clamped_array
  end

end
