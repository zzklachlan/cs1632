require 'simplecov'
SimpleCov.start

require 'minitest/autorun'

require_relative 'location'
require_relative 'prospector'
require_relative 'driver'

class DriverTest < Minitest::Test
  # Special method!
  # This will run the following code before each test
  # We will re-use the @p and @l instance variable in each method
  # This was we don't have to type p = Prospector::new or 
  # l = Location::new in each test
  def setup
    @mock_prng = Minitest::Mock.new("test prng")
    @l = Location::new  "Main Location", 5, 5, @mock_prng
    @p = Prospector::new
  end
  
  def test_initialize_locations
    assert_equal initialize_locations(@mock_prng).count, 7
  end

  # UNIT TEST FOR METHOD initialize_prospectors(num_prospectors)
  # stub Prospector.new method
  def test_initialize_prospectors
    def Prospector.new; Minitest::Mock.new("test prospector"); end
    assert_equal initialize_prospectors(5).count, 5
  end

  # UNIT TEST FOR METHOD incre_num_rubies(x)
  # Equivalence classes:
  # x= 0 -> returns 'no rubies'
  # x= 1 -> returns '1 ruby'
  # x= 2..INFINITY -> returns '#{x} rubies'

  # If no rubies found
  def test_display_no_rubies
    assert_equal display_rubies(0), 'no rubies'
  end

  # If one ruby found
  def test_display_one_rubies
    assert_equal display_rubies(1), '1 ruby'
  end

  # If multiple rubies found
  def test_display_multiple_rubies
    assert_equal display_rubies(5), '5 rubies'
  end

  # UNIT TEST FOR METHOD incre_num_fake_rubies(x)
  # Equivalence classes:
  # x= 0 -> returns 'no fake rubies'
  # x= 1 -> returns '1 fake ruby'
  # x= 2..INFINITY -> returns '#{x} fake rubies'

  # If no fake rubies found
  def test_display_no_fake_rubies
    assert_equal display_fake_rubies(0), 'no fake rubies'
  end

  # If one fake ruby found
  def test_display_one_fake_rubies
    assert_equal display_fake_rubies(1), '1 fake ruby'
  end

  # If multiple fake rubies found
  def test_display_multiple_fake_rubies
    assert_equal display_fake_rubies(5), '5 fake rubies'
  end

  # def test_modify_rubies
  #   modify @p, 2, 0
  #   assert_equal @p.num_rubies, 2
  # end

  # UNIT TEST FOR METHOD prospect
  # stub
  def test_prospect
    mock_prospector = Minitest::Mock.new("prospector")
    mock_location = Minitest::Mock.new("location")

    def mock_location.num_rubies; 0; end
    def mock_location.num_fake_rubies; 0; end
    def mock_prospector.incre_num_rubies(x); 0; end
    def mock_prospector.incre_num_fake_rubies(x); 0; end
    def mock_prospector.incre_num_days; 0; end
    def mock_location.name; "mock"; end

    assert_equal prospect(mock_prospector, mock_location), [0, 0]

    assert_mock mock_location
    assert_mock mock_prospector
  end

  def test_iterate
    mock_prospector = Minitest::Mock.new("prospector")
    mock_location = Minitest::Mock.new("location")
  end

  def test_check_invalid
    assert_equal check_valid([2, 1]), [1, nil, nil, nil]
    assert_output ("Usage:
      ruby ruby_rush.rb *seed* *num_prospectors* *num_turns*
      *seed* should be an integer
      *num_prospectors* should be a non-negative integer
      *num_turns* should be a non-negative integer\n") {check_valid([2, 1])}
  end

  def test_check_valid
    assert_equal check_valid([2, '1', '5']), [0, 2, 1, 5]
  end

  def test_iterate
    mock_prospector = Minitest::Mock.new("prospector")
    mock_location = Minitest::Mock.new("location")
    test_next_location = Minitest::Mock.new("next location")

    def mock_prospector.incre_num_turns; 0; end
    def mock_prospector.num_turns; 0; end
    def prospect(mock_prospector, mock_location); 0; end
    def mock_location.next_location; mock_next_location; end
    #def mock_next_location.next_location; mocl_next_location; end

    refute_nil iterate(mock_prospector, mock_location, 2)

    assert_mock mock_prospector
  end
end
