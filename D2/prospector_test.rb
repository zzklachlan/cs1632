require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require_relative 'prospector'

class ProspectorTest < Minitest::Test

  def setup
    @p = Prospector::new
  end

  def test_new_Prospector_not_nil
    refute_nil @p
    assert_kind_of Prospector, @p
  end

  def test_constructor
    assert_equal @p.num_days, 0
    assert_equal @p.num_turns, 0
    assert_equal @p.num_rubies, 0
    assert_equal @p.num_fake_rubies, 0
  end

  # UNIT TEST FOR METHOD incre_num_rubies(x)
  # Equivalence classes:
  # x= -INFINITY..-1 -> subtract x
  # x= 0..INFINITY -> add x
  # x= (not a number) -> no change

  # If the number of rubies is negative
  def test_incre_negative_num_rubies
    @p.incre_num_rubies(-1)
    assert_equal @p.num_rubies, -1
  end

  # If the number of rubies is positive
  def test_incre_positive_num_rubies
    @p.incre_num_rubies(1)
    assert_equal @p.num_rubies, 1
  end

  # If not a number
  def test_not_a_num_rubies
    @p.incre_num_rubies('non-number')
    assert_equal @p.num_rubies, 0
  end

  # UNIT TEST FOR METHOD incre_num_fake_rubies(x)
  # Equivalence classes:
  # x= -INFINITY..-1 -> subtract x
  # x= 0..INFINITY -> add x
  # x= (not a number) -> no change

  # If the number of fake rubies is negative
  def test_incre_negative_num_fake_rubies
    @p.incre_num_fake_rubies(-1)
    assert_equal @p.num_fake_rubies, -1
  end

  # If the number of fake rubies is postive
  def test_incre_positive_num_fake_rubies
    @p.incre_num_fake_rubies(1)
    assert_equal @p.num_fake_rubies, 1
  end

  # If not a number
  def test_not_a_num_fake_rubies
    @p.incre_num_fake_rubies('non-number')
    assert_equal @p.num_fake_rubies, 0
  end

  def test_incre_num_days
    @p.incre_num_days
    assert_equal @p.num_days, 1
  end

  def test_incre_num_turns
    @p.incre_num_turns
    assert_equal @p.num_turns, 1
  end

  # UNIT TEST FOR METHOD result
  # Equivalence classes:
  # num_rubies= 10..INFINITY -> returns 'Going home victorious!'
  # num_rubies= 0 -> returns 'Going home empty-handed.'
  # num_rubies= 0..9 -> returns 'Going home sad.'

  # If num_rubies >= 10
  def test_victorious_result
    @p.num_rubies = 10
    assert_output("Going home victorious!\n") {@p.result}
  end

  # If num_rubies == 0
  def test_empty_handed_result
    @p.num_rubies = 0
    assert_output("Going home empty-handed.\n") {@p.result}
  end

  # If 0 < num_rubies < 10
  def test_sad_result
    @p.num_rubies = 1
    assert_output("Going home sad.\n") {@p.result}
  end
end