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
  
  def test_new_location_not_nil
    refute_nil @l
    assert_kind_of Location, @l
  end

  def test_constructor
    assert_equal @l.name, 'Main Location'
    assert_equal @l.max_rubies, 5
    assert_equal @l.max_fake_rubies, 5
    assert_equal @l.prng, @mock_prng
    refute_nil @l.neighbors
  end

  # UNIT TEST FOR METHOD num_rubies
  # double the random class, stub the rand method
  def test_num_rubies_mock
    def @mock_prng.rand(x); 2; end
    val = @l.num_rubies
    assert_equal val, 2

    assert_mock @mock_prng
  end

  # UNIT TEST FOR METHOD num_fake_rubies
  # double the random class, stub the rand method
  def test_num_fake_rubies_mock
    def @mock_prng.rand(x); 1; end
    val = @l.num_fake_rubies
    assert_equal val, 1

    assert_mock @mock_prng
  end

  # UNIT TEST FOR METHOD add_neighbor
  # test whether a neighbor can be added
  def test_add_neighbor
    test_neighbor = Location::new "test neighbor", 3, 3, @mock_prng
    assert_kind_of Location, test_neighbor

    @l.add_neighbor(test_neighbor)
    assert_equal @l.neighbors.count, 1
  end

  # UNIT TEST FOR METHOD next_location
  # stub the rand method and test whether the next_location method can get a neighbor of the current location
  def test_next_location
    def @mock_prng.rand(x); 0; end
    test_neighbor = Location::new "test neighbor", 3, 3, @mock_prng
    @l.add_neighbor(test_neighbor)

    test_next_location = @l.next_location

    refute_nil test_next_location
    assert_kind_of Location, test_next_location
  end

  # Edge Case 
  # Try to get next location when the current location has no neighbors
  def test_next_location_with_no_neighbor
   assert_raises "This location has no neighbors." do
    test_neighbor = Location::new "test neighbor", 3, 3, @mock_prng
    test_neighbor.next_location 
   end
  end
end