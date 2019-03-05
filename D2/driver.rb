require_relative './location.rb'
require_relative './prospector.rb'

# Initialize the array of locations
def initialize_locations(prng)
  locations = []
  locations[0] = Location.new('Enumerable Canyon', 1, 1, prng)
  locations[1] = Location.new('Duck Type Beach', 2, 2, prng)
  locations[2] = Location.new('Monkey Patch City', 1, 1, prng)
  locations[3] = Location.new('Nil Town', 0, 3, prng)
  locations[4] = Location.new('Matzburg', 3, 0, prng)
  locations[5] = Location.new('Hash Crossing', 2, 2, prng)
  locations[6] = Location.new('Dynamic Palisades', 2, 2, prng)
  locations
end

# Initialize the array of prospectors
def initialize_prospectors(num_prospectors)
  prospectors = []
  (0...num_prospectors).each do |x|
    prospectors[x] = Prospector.new
  end
  prospectors
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

# For a prospector, do a single turn
def prospect(curr_prospector, curr_location)
  rubies = 0
  fake_rubies = 0
  loop do
    rubies = curr_location.num_rubies
    fake_rubies = curr_location.num_fake_rubies

    curr_prospector.incre_num_rubies rubies
    curr_prospector.incre_num_fake_rubies fake_rubies
    curr_prospector.incre_num_days

    if rubies.zero? && fake_rubies.zero?
      puts "\tFound no rubies or no fake rubies in #{curr_location.name}."
      break
    else
      puts "\tFound #{display_rubies rubies} and #{display_fake_rubies fake_rubies} in #{curr_location.name}."
    end
  end
  [rubies, fake_rubies]
end

def pritn_transition(old_location, curr_location)
  puts "Heading from #{old_location.name} to #{curr_location.name}."
end

# For a prospector, finish all the turns
def iterate(curr_prospector, curr_location, num_turns)
  loop do
    prospect curr_prospector, curr_location
    curr_prospector.incre_num_turns

    break if curr_prospector.num_turns == num_turns

    old_location = curr_location
    curr_location = curr_location.next_location
    pritn_transition old_location
  end
  curr_location
end

# Check if the arguments are valid
def check_valid(args)
  if args.count != 3 || args[1].to_i.zero? || args[2].to_i.zero?
    puts "Usage:
      ruby ruby_rush.rb *seed* *num_prospectors* *num_turns*
      *seed* should be an integer
      *num_prospectors* should be a non-negative integer
      *num_turns* should be a non-negative integer"
    return [1, nil, nil, nil]
  end
  [0, args[0].to_i, args[1].to_i, args[2].to_i]
end

# Play the game
def run_program(num_prospectors, prospectors, locations, num_turns)
  (0...num_prospectors).each do |n|
    puts "Rubyist #{n + 1} starting in Enumerable Canyon."
    iterate prospectors[n], locations[0], num_turns
    puts "After #{prospectors[n].num_days} days, Rubyist #{n + 1} found:"
    puts "\t#{display_rubies prospectors[n].num_rubies}.\n\t#{display_fake_rubies prospectors[n].num_fake_rubies}."
    prospectors[n].result(prospectors[n].num_rubies)
  end
end
