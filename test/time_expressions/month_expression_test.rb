require "minitest/autorun"
require "lib/time_expressions/month_expression"

class MonthExpressionTest < Minitest::Test

  def test_can_handle_wildcard
    expression = MonthExpression.new('*')
    assert_equal(
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      expression.occurrences
    )
  end

  def test_can_handle_single_month
    expression = MonthExpression.new('12')
    assert_equal(
      [12],
      expression.occurrences
    )

    expression = MonthExpression.new('4')
    assert_equal(
      [4],
      expression.occurrences
    )
  end

  def test_can_handle_single_word_month
    expression = MonthExpression.new('FEB')
    assert_equal(
      [2],
      expression.occurrences
    )

    expression = MonthExpression.new('MAR')
    assert_equal(
      [3],
      expression.occurrences
    )
  end

  def test_can_handle_multiple_word_month
    expression = MonthExpression.new('FEB,MAR')
    assert_equal(
      [2, 3],
      expression.occurrences
    )
  end

  def test_can_handle_multiple_word_month_with_range
    expression = MonthExpression.new('FEB-MAR,JUN-AUG')
    assert_equal(
      [2, 3, 6, 7, 8],
      expression.occurrences
    )
  end

  def test_can_handle_range_of_months
    expression = MonthExpression.new('9-12')
    assert_equal(
      [9, 10, 11, 12],
      expression.occurrences
    )
  end

  def test_can_handle_comma_separated_months
    expression = MonthExpression.new('1,5,3')
    assert_equal(
      [1,3,5],
      expression.occurrences
    )
  end

  def test_can_handle_interval_of_months
    expression = MonthExpression.new('*/2')
    assert_equal(
      [1, 3, 5, 7, 9, 11],
      expression.occurrences
    )
  end

  def test_can_handle_comma_and_range_of_months
    expression = MonthExpression.new('1,2,3,9-11')
    assert_equal(
      [1, 2, 3, 9, 10, 11],
      expression.occurrences
    )
  end

  def test_rejects_invalid_months
    expression = MonthExpression.new('1,32')
    assert_equal(
      [1],
      expression.occurrences
    )
  end

end
