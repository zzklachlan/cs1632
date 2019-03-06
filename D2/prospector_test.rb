require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require_relative 'prospector'

class ProspectorTest < Minitest::Test

  # Special method!
  # This will run the following code before each test
  # We will re-use the @p instance variable in each method
  # This was we don't have to type p = Prospector::new in each test
  def setup
    @p = Prospector::new
  end

  # UNIT TEST FOR METHOD Prospector.new
  # The new Location object should not be null
  def test_new_Prospector_not_nil
    refute_nil @p
    assert_kind_of Prospector, @p
  end

  # If no rubies found
  def test_display_no_rubies
    assert_equal @p.display_rubies(0), 'no rubies'
  end

  # If one ruby found
  def test_display_one_rubies
    assert_equal @p.display_rubies(1), '1 ruby'
  end

  # If multiple rubies found
  def test_display_multiple_rubies
    assert_equal @p.display_rubies(5), '5 rubies'
  end

  # UNIT TEST FOR METHOD incre_num_fake_rubies(x)
  # Equivalence classes:
  # x= 0 -> returns 'no fake rubies'
  # x= 1 -> returns '1 fake ruby'
  # x= 2..INFINITY -> returns '#{x} fake rubies'

  # If no fake rubies found
  def test_display_no_fake_rubies
    assert_equal @p.display_fake_rubies(0), 'no fake rubies'
  end

  # If one fake ruby found
  def test_display_one_fake_rubies
    assert_equal @p.display_fake_rubies(1), '1 fake ruby'
  end

  # If multiple fake rubies found
  def test_display_multiple_fake_rubies
    assert_equal @p.display_fake_rubies(5), '5 fake rubies'
  end

  # UNIT TEST FOR METHOD result
  # Equivalence classes:
  # num_rubies= 10..INFINITY -> returns 'Going home victorious!'
  # num_rubies= 0 -> returns 'Going home empty-handed.'
  # num_rubies= 0..9 -> returns 'Going home sad.'
  # num_rubies= -INFINITY...0 -> returns '

  # If num_rubies >= 10
  def test_victorious_result
    assert_output("Going home victorious!\n") {@p.result(10)}
  end

  # If num_rubies == 0
  def test_empty_handed_result
    assert_output("Going home empty-handed.\n") {@p.result(0)}
  end

  # If 0 < num_rubies < 10
  def test_sad_result
    assert_output("Going home sad.\n") {@p.result(1)}
  end

  # If num_rubies < 0
  # EDGE CASE
  def test_negative_result
    assert_output("The number of rubies should be non negative.\n") {@p.result(-1)}
  end

  # UNIT TEST FOR METHOD prospect
  # stub the methods used in prospect
  # This test should check whether a prospector can find pseudorandom
  # number of rubies and fake rubies
  # STUB METHOD
  def test_prospect
    mock_location = Minitest::Mock.new("location")

    def mock_location.num_rubies; 0; end
    def mock_location.num_fake_rubies; 0; end
    def mock_location.name; "mock"; end

    assert_equal @p.num_rubies, 0
    assert_equal @p.num_fake_rubies, 0
    assert_output("\tFound no rubies or no fake rubies in mock.\n") {@p.prospect(mock_location)}

    assert_mock mock_location
  end

  # UNIT TEST FOR METHOD iterate(curr_prospector, curr_location, num_turns)
  # This test should check whether a prospector can prospect 
  # a given location with given number of turns 
  # STUB METHOD
  def test_iterate
    mock_location = Minitest::Mock.new("mock")

    def @p.prospect(mock_location); nil; end
    def mock_location.next_location; self; end
    def mock_location.name; 'mock'; end

    @p.iterate(@p, mock_location, 2)
    assert_equal @p.num_turns, 2

    assert_mock mock_location
  end
end