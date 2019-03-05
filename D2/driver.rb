require_relative './location.rb'
require_relative './prospector.rb'

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

def construct_graph(locations)
  locations[0].add_neighbor(locations[1])
  locations[0].add_neighbor(locations[2])
  locations[1].add_neighbor(locations[0])
  locations[1].add_neighbor(locations[4])
  locations[2].add_neighbor(locations[3])
  locations[2].add_neighbor(locations[0])
  locations[2].add_neighbor(locations[4])
  locations[3].add_neighbor(locations[2])
  locations[3].add_neighbor(locations[5])
  locations[4].add_neighbor(locations[2])
  locations[4].add_neighbor(locations[1])
  locations[4].add_neighbor(locations[5])
  locations[4].add_neighbor(locations[6])
  locations[5].add_neighbor(locations[4])
  locations[5].add_neighbor(locations[3])
  locations[5].add_neighbor(locations[6])
  locations[6].add_neighbor(locations[4])
  locations[6].add_neighbor(locations[5])
end

def initialize_prospectors(num_prospectors)
  prospectors = []
  (0...num_prospectors).each do |x|
    prospectors[x] = Prospector.new
  end
  prospectors
end

def display_rubies(rubies)
  result = ''
  result + if rubies.zero?
             'no rubies'
           elsif rubies == 1
             '1 ruby'
           else
             "#{rubies} rubies"
           end
end

def display_fake_rubies(fake_rubies)
  result = ''
  result + if fake_rubies.zero?
             'no fake rubies'
           elsif fake_rubies == 1
             '1 fake ruby'
           else
             "#{fake_rubies} fake rubies"
           end
end

def modify(curr_prospector, rubies, fake_rubies)
  curr_prospector.incre_num_rubies rubies
  curr_prospector.incre_num_fake_rubies fake_rubies
  curr_prospector.incre_num_days
end

def prospect(curr_prospector, curr_location)
  rubies = 0
  fake_rubies = 0
  loop do
    rubies = curr_location.num_rubies
    fake_rubies = curr_location.num_fake_rubies

    modify curr_prospector, rubies, fake_rubies

    if rubies.zero? && fake_rubies.zero?
      puts "\tFound no rubies or no fake rubies in #{curr_location.name}."
      break
    else
      puts "\tFound #{display_rubies rubies} and #{display_fake_rubies fake_rubies} in #{curr_location.name}."
    end
  end
end

def iterate(curr_prospector, curr_location, num_turns)
  loop do
    prospect curr_prospector, curr_location
    curr_prospector.incre_num_turns

    break if curr_prospector.num_turns == num_turns

    old_location = curr_location
    curr_location = curr_location.next_location
    puts "Heading from #{old_location.name} to #{curr_location.name}."
  end
end

def check_valid
  raise 'Enter integers for seed, the number of prospectors, and number of turns at command line' unless ARGV.count == 3

  # seed = arg1.to_i
  # num_prospectors = arg2.to_i
  # num_turns = arg3.to_i
end

def run_program(prospectors, locations, num_turns)
  (0...prospectors.count).each do |n|
    puts "Rubyist #{n + 1} starting in Enumerable Canyon."
    iterate prospectors[n], locations[0], num_turns
    puts "After #{prospectors[n].num_days} days, Rubyist #{n + 1} found:"
    puts "\t#{display_rubies prospectors[n].num_rubies}.\n\t#{display_fake_rubies prospectors[n].num_fake_rubies}."
    prospectors[n].result
  end
end
