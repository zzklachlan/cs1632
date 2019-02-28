# Class that represents a single prospector
class Prospector
  attr_accessor :id
  attr_accessor :num_days
  attr_accessor :num_turns
  attr_accessor :num_rubies
  attr_accessor :num_fake_rubies

  def initialize(pid)
    @id = pid
    @num_days = 0
    @num_turns = 0
    @num_rubies = 0
    @num_fake_rubies = 0
  end

  def incre_num_rubies(inc)
    @num_rubies += inc
  end

  def incre_num_fake_rubies(inc)
    @num_fake_rubies += inc
  end

  def incre_num_days
    @num_days += 1
  end

  def incre_num_turns
    @num_turns += 1
  end

  def result
    if @num_rubies >= 10
      puts 'Going home victorious!'
    elsif @num_rubies.zero?
      puts 'Going home empty-handed.'
    else
      puts 'Going home sad.'
    end
  end
end
