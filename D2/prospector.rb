# Class that represents a single prospector
class Prospector
  attr_accessor :num_days
  attr_accessor :num_turns
  attr_accessor :num_rubies
  attr_accessor :num_fake_rubies

  # Constructor
  def initialize
    @num_days = 0
    @num_turns = 0
    @num_rubies = 0
    @num_fake_rubies = 0
  end

  # Add the number of new found rubies
  def incre_num_rubies(inc)
    @num_rubies += inc if inc.is_a? Integer
  end

  # Add the number of new found fake rubies
  def incre_num_fake_rubies(inc)
    @num_fake_rubies += inc if inc.is_a? Integer
  end

  # Increment the number of days
  def incre_num_days
    @num_days += 1
  end

  # Increment the n
  def incre_num_turns
    @num_turns += 1
  end

  # def iterate(curr_prospector, curr_location, num_turns)
  #   loop do
  #     prospect curr_prospector, curr_location
  #     curr_prospector.incre_num_turns

  #     break if curr_prospector.num_turns == num_turns

  #     old_location = curr_location
  #     curr_location = curr_location.next_location
  #     puts "Heading from #{old_location.name} to #{curr_location.name}."
  #   end
  # end

  def result(final_rubies)
    if final_rubies >= 10
      puts 'Going home victorious!'
    elsif final_rubies.zero?
      puts 'Going home empty-handed.'
    else
      puts 'Going home sad.'
    end
  end
end
