require 'minitest/autorun'
require_relative '../lib/calculator'

class TestUser < Minitest::Test
  # good, bad and the ugly

  def test_sum_numbers
    calc = Calculator.new
    assert_equal(4, calc.sum(1, 3))
  end

  def test_sum_numbers_bad
    calc = Calculator.new
    assert_equal(4, calc.sum('1', 3))

    # typed, java => error/exception
    # dynamic, js => just do it
  end

  def test_sum_numbers_ugly
    calc = Calculator.new
    assert_equal(0, calc.sum('a', 'b'))
  end

  def test_sum_numbers_ugly_2
    calc = Calculator.new
    assert_equal(0, calc.sum(nil, nil))
  end

  # system tests, integration tests, code reviews, pair programming
end
