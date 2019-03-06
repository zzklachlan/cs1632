require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require_relative 'driver'

class DriverTest < Minitest::Test
  # UNIT TEST FOR METHOD initialize_locations(seed)
  # This test 
  def test_initialize_locations
    assert_equal initialize_locations(1234).count, 7
  end

  # UNIT TEST FOR METHOD initialize_prospectors(num_prospectors)
  # stub Prospector.new method
  # This test should check whether the initialize_prospectors can
  # return an array of prospectors with given size
  def test_initialize_prospectors
    assert_equal initialize_prospectors(5).count, 5
  end

  # UNIT TEST FOR METHOD create_graph
  # Expect call the method and return a location array and a prospector array
  def test_create_graph
    val = create_graph(1234, 5)
    locations_count = val[0].count
    prospectors_count = val[1].count
    assert_equal 7, locations_count
    assert_equal 5, prospectors_count
  end

  # UNIT TEST FOR METHOD check_valid
  # This test should print usage because the length 
  # Equivalence classes:
  # [2, 1] -> args length < 3
  # [2, 1, 0] -> num_of_turns == 0
  # [2, 0, 1] -> num_of_prospectors == 0

  # If the argumens is less than 3
  # EDGE CASE
  def test_check_invalid_length
    assert_equal check_valid([2, 1]), [1, nil, nil, nil]
  end

  # If num_of_turns == 0
  # EDGE CASE
  def test_check_invalid_turns
    assert_equal check_valid([2, 1, 0]), [1, nil, nil, nil]
  end

  # If num_of_prospectors == 0
  # EDGE CASE
  def test_check_invalid_prospectors
    assert_equal check_valid([2, 0, 1]), [1, nil, nil, nil]
  end

  # This test should return the precise array containing
  # exit code, seed, number of prospectors, and number of turns
  def test_check_valid
    assert_equal check_valid([2, '1', '5']), [0, 2, 1, 5]
  end
end
