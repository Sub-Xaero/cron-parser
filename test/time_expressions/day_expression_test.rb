require "minitest/autorun"

require "lib/time_expressions/day_expression"

class DayExpressionTest < Minitest::Test

  def test_can_handle_wildcard
    expression = DayExpression.new('*')
    assert_equal(
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31],
      expression.occurrences
    )
  end

  def test_can_handle_single_day
    expression = DayExpression.new('12')
    assert_equal(
      [12],
      expression.occurrences
    )
  end

  def test_can_handle_range_of_days
    expression = DayExpression.new('12-15')
    assert_equal(
      [12, 13, 14, 15],
      expression.occurrences
    )
  end

  def test_can_handle_comma_separated_days
    expression = DayExpression.new('12,15,30')
    assert_equal(
      [12, 15, 30],
      expression.occurrences
    )
  end

  def test_can_handle_interval_of_days
    expression = DayExpression.new('*/2')
    assert_equal(
      [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31],
      expression.occurrences
    )
  end

  def test_can_handle_comma_and_range_of_days
    expression = DayExpression.new('1,2,3,9-11')
    assert_equal(
      [1, 2, 3, 9, 10, 11],
      expression.occurrences
    )
  end

  def test_rejects_invalid_days
    expression = DayExpression.new('1,32')
    assert_equal(
      [1],
      expression.occurrences
    )
  end

end
