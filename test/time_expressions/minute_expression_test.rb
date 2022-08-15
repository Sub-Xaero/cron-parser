require "minitest/autorun"
require "lib/time_expressions/minute_expression"

class MinuteExpressionTest < Minitest::Test

  def test_can_handle_wildcard
    expression = MinuteExpression.new('*')
    assert_equal(
      (0..59).to_a,
      expression.occurrences
    )
  end

  def test_can_handle_single_minute
    expression = MinuteExpression.new('12')
    assert_equal(
      [12],
      expression.occurrences
    )
  end

  def test_can_handle_range_of_minutes
    expression = MinuteExpression.new('12-15')
    assert_equal(
      [12, 13, 14, 15],
      expression.occurrences
    )
  end

  def test_can_handle_comma_separated_minutes
    expression = MinuteExpression.new('12,15,30')
    assert_equal(
      [12, 15, 30],
      expression.occurrences
    )
  end

  def test_can_handle_interval_of_minutes
    expression = MinuteExpression.new('*/15')
    assert_equal(
      [0, 15, 30, 45],
      expression.occurrences
    )

    expression = MinuteExpression.new('*/10')
    assert_equal(
      [0, 10, 20, 30, 40, 50],
      expression.occurrences
    )

    expression = MinuteExpression.new('*/30')
    assert_equal(
      [0, 30],
      expression.occurrences
    )

    expression = MinuteExpression.new('*/22')
    assert_equal(
      [0, 22, 44],
      expression.occurrences
    )
  end

  def test_can_handle_comma_and_range_of_minutes
    expression = MinuteExpression.new('1,2,3,9-11')
    assert_equal(
      [1, 2, 3, 9, 10, 11],
      expression.occurrences
    )
  end

  def test_rejects_invalid_minutes
    expression = MinuteExpression.new('1,62')
    assert_equal(
      [1],
      expression.occurrences
    )
  end

end
