require 'simplecov'
SimpleCov.start

require 'minitest/autorun'

require_relative 'location'
require_relative 'prospector'
require_relative 'driver'

class DriverTest < Minitest::Test

    # UNIT TEST FOR METHOD initialize_prospectors(num_prospectors)
    def test_initialize_prospectors
      def Prospector.new; Minitest::Mock.new("test prospector"); end
      assert_equal initialize_prospectors(5).count, 5
    end

    # UNIT TEST FOR METHOD incre_num_rubies(x)
    # Equivalence classes:
    # x= -INFINITY..-1 -> returns -x
    # x= 0..INFINITY -> returns x
    # x= (not a number) -> returns nil
    def test_display_no_rubies
      assert_equal display_rubies(0), 'no rubies'
    end
end