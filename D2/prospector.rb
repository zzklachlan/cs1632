require_relative './location.rb'

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

  # Display the result of a prospection
  def result(final_rubies)
    if final_rubies >= 10
      puts 'Going home victorious!'
    elsif final_rubies.zero?
      puts 'Going home empty-handed.'
    elsif final_rubies < 0
      puts 'The number of rubies should be non negative.'
    else
      puts 'Going home sad.'
    end
  end

  def prospect(curr_location)
    rubies = 0
    fake_rubies = 0
    loop do
      rubies = curr_location.num_rubies
      fake_rubies = curr_location.num_fake_rubies
      @num_days += 1
      @num_rubies += rubies
      @num_fake_rubies += fake_rubies

      if rubies.zero? && fake_rubies.zero?
        puts "\tFound no rubies or no fake rubies in #{curr_location.name}."
        break
      else
        puts "\tFound #{display_rubies rubies} and #{display_fake_rubies fake_rubies} in #{curr_location.name}."
      end
    end
  end

  # For a prospector, finish all the turns
  def iterate(curr_prospector, curr_location, num_turns)
    loop do
      curr_prospector.prospect(curr_location)
      @num_turns += 1

      break if @num_turns == num_turns

      old_location = curr_location
      curr_location = old_location.next_location
      puts "Heading from #{old_location.name} to #{curr_location.name}."
    end
  end

  # Display the number of rubies
  def display_rubies(rubies)
    result = ''
    result + if rubies.zero? # If no fake rubies
               'no rubies'
             elsif rubies == 1 # If only one fake ruby
               '1 ruby'
             else
               "#{rubies} rubies" # If multiple fake rubies
             end
  end

  # Display the number of fake rubies
  def display_fake_rubies(fake_rubies)
    result = ''
    result + if fake_rubies.zero? # If no fake rubies
               'no fake rubies'
             elsif fake_rubies == 1 # If only one fake ruby
               '1 fake ruby'
             else
               "#{fake_rubies} fake rubies" # If multiple fake rubies
             end
  end
end
