require 'minitest/autorun'
require "lib/time_expressions/weekday_expression"

class WeekdayExpressionTest < Minitest::Test

  def test_can_handle_wildcard
    expression = WeekdayExpression.new('*')
    assert_equal(
      [0, 1, 2, 3, 4, 5, 6],
      expression.occurrences
    )
  end

  def test_can_handle_single_weekday
    expression = WeekdayExpression.new('5')
    assert_equal(
      [5],
      expression.occurrences
    )

    expression = WeekdayExpression.new('4')
    assert_equal(
      [4],
      expression.occurrences
    )
  end

  def test_can_handle_single_word_weekday
    expression = WeekdayExpression.new('SUN')
    assert_equal(
      [0],
      expression.occurrences
    )

    expression = WeekdayExpression.new('WED')
    assert_equal(
      [3],
      expression.occurrences
    )
  end

  def test_can_handle_multiple_word_weekday
    expression = WeekdayExpression.new('SUN,WED')
    assert_equal(
      [0, 3],
      expression.occurrences
    )
  end

  def test_can_handle_multiple_word_weekday_with_range
    expression = WeekdayExpression.new('SUN-WED,FRI-SAT')
    assert_equal(
      [0, 1, 2, 3, 5, 6],
      expression.occurrences
    )
  end

  def test_can_handle_range_of_weekdays
    expression = WeekdayExpression.new('2-5')
    assert_equal(
      [2, 3, 4, 5],
      expression.occurrences
    )
  end

  def test_can_handle_comma_separated_weekdays
    expression = WeekdayExpression.new('1,5,3')
    assert_equal(
      [1,3,5],
      expression.occurrences
    )
  end

  def test_can_handle_interval_of_weekdays
    expression = WeekdayExpression.new('*/2')
    assert_equal(
      [0, 2, 4, 6],
      expression.occurrences
    )
  end

  def test_can_handle_comma_and_range_of_weekdays
    expression = WeekdayExpression.new('1,2,3')
    assert_equal(
      [1, 2, 3],
      expression.occurrences
    )
  end

  def test_rejects_invalid_weekdays
    expression = WeekdayExpression.new('1,32')
    assert_equal(
      [1],
      expression.occurrences
    )
  end

end
