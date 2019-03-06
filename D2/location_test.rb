require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require_relative 'location'

class LocationTest < Minitest::Test

  # Special method!
  # This will run the following code before each test
  # We will re-use the @l instance variable in each method
  # This was we don't have to type l = Location::new in each test
  def setup
    @mock_prng = Minitest::Mock.new("test prng")
    @l = Location::new  "Main Location", 5, 5, @mock_prng
  end
  
  # UNIT TEST FOR METHOD Location.new
  # The new Location object should not be null and shoule be a location object
  def test_new_location_not_nil
    refute_nil @l
    assert_kind_of Location, @l
  end

  # UNIT TEST FOR METHOD num_rubies
  # double the random class, stub the rand method
  # This method should return a positive number of rubies
  # STUB METHOD
  def test_num_rubies
    def @mock_prng.rand(x); 2; end
    val = @l.num_rubies
    assert_equal val, 2
  end

  # UNIT TEST FOR METHOD num_fake_rubies
  # double the random class, stub the rand method
  # This method should return a positive number of fake rubies
  # STUB METHOD
  def test_num_fake_rubies
    def @mock_prng.rand(x); 1; end
    val = @l.num_fake_rubies
    assert_equal val, 1
  end

  # UNIT TEST FOR METHOD add_neighbor
  # test whether a neighbor can be added
  # This method should add one neighbor to any location object
  def test_add_neighbor
    test_neighbor = Location::new "test neighbor", 3, 3, @mock_prng
    assert_kind_of Location, test_neighbor

    @l.add_neighbor(test_neighbor)
    assert_equal @l.neighbors.count, 1
  end

  # UNIT TEST FOR METHOD next_location
  # stub the rand method and 
  # test whether the next_location method can get a neighbor of the current location
  # STUB METHOD
  def test_next_location
    test_neighbor = Location::new "test neighbor", 3, 3, @mock_prng
    @l.add_neighbor(test_neighbor)

    def @mock_prng.rand(x); 0; end
    test_next_location = @l.next_location

    refute_nil test_next_location
    assert_kind_of Location, test_next_location
  end

  # Try to get next location when the current location has no neighbors
  # An exception should raise
  # EDGE CASE
  def test_next_location_with_no_neighbor
   assert_raises "This location has no neighbors." do
    test_neighbor = Location::new "test neighbor", 3, 3, @mock_prng
    test_neighbor.next_location 
   end
  end
end