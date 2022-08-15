require "minitest/autorun"
require "lib/time_expressions/hour_expression"

class HourExpressionTest < Minitest::Test

  def test_can_handle_wildcard
    expression = HourExpression.new('*')
    assert_equal(
      [0, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23],
      expression.occurrences
    )
  end

  def test_can_handle_single_hour
    expression = HourExpression.new('12')
    assert_equal(
      [12],
      expression.occurrences
    )
  end

  def test_can_handle_range_of_hours
    expression = HourExpression.new('12-15')
    assert_equal(
      [12, 13, 14, 15],
      expression.occurrences
    )
  end

  def test_can_handle_comma_separated_hours
    expression = HourExpression.new('12,15,22')
    assert_equal(
      [12, 15, 22],
      expression.occurrences
    )
  end

  def test_can_handle_interval_of_hours
    expression = HourExpression.new('*/2')
    assert_equal(
      [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22],
      expression.occurrences
    )
  end

  def test_can_handle_comma_and_range_of_hours
    expression = HourExpression.new('1,2,3,9-11')
    assert_equal(
      [1, 2, 3, 9, 10, 11],
      expression.occurrences
    )
  end
end
