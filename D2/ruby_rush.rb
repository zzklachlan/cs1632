require_relative "location.rb"
require_relative "prospector.rb"

# Enumerable Canyon, which connects to Duck Type Beach and Monkey Patch City; 
# Duck Type Beach, which connects to Enumerable Canyon and Matzburg; 
# Monkey Patch City, which connects to Nil Town, Enumerable Canyon, and Matzburg; 
# Nil Town, which connects to Monkey Patch City and Hash Crossing; 
# Matzburg, which connects to Monkey Patch City, Duck Type Beach, Hash Crossing, and Dynamic Palisades; 
# Hash Crossing, which connects to Matzburg, Nil Town, and Dynamic Palisades; 
# and Dynamic Palisades, which connects to Matzburg and Hash Crossing.

# Location          | Max Rubies | Max Fake Rubies
# ------------------------------------------------
# Enumerable Canyon |    1       |    1
# Duck Type Beach   |    2       |    2
# Monkey Patch City |    1       |    1
# Nil Town          |    0       |    3
# Matzburg          |    3       |    0
# Hash Crossing     |    2       |    2
# Dynamic Palisades |    2       |    2
# ------------------------------------------------

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

def initialize_prospectors(num_prospectors, locations)
	prospectors = []
	(0...num_prospectors).each do |x|
		prospectors[x] = Prospector.new(x+1, locations)
	end
	prospectors
end

def display_rubies(rubies)
	result = ""
	if rubies == 0
		result += "no rubies"
	elsif rubies == 1
		result += "1 ruby"
	else
		result += "#{rubies} rubies"
	end
	result			
end

def display_fake_rubies(fake_rubies)
	result = ""
	if fake_rubies == 0
		result += "no fake rubies"
	elsif fake_rubies == 1
		result += "1 fake ruby"
	else
		result += "#{fake_rubies} fake rubies"	
	end	
	result	
end

def prospect(curr_prospector, curr_location)
	rubies = 0
	fake_rubies = 0
	loop do
		rubies = curr_location.get_num_rubies
		fake_rubies = curr_location.get_num_fake_rubies
		curr_prospector.incre_num_rubies rubies
		curr_prospector.incre_num_fake_rubies fake_rubies
		curr_prospector.incre_num_days
		#print_result rubies, fake_rubies, curr_location

		if(rubies == 0 && fake_rubies == 0)
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
	
		if curr_prospector.num_turns == num_turns
			break
		end	

		old_location = curr_location
		curr_location = curr_location.get_next_location
		puts "Heading from #{old_location.name} to #{curr_location.name}."	
	end
end


raise "Enter integers for seed, the number of prospectors, and number of turns at command line" unless ARGV.count == 3
seed, num_prospectors, num_turns = ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i

prng = Random.new(seed)
locations = initialize_locations prng
construct_graph locations
prospectors = initialize_prospectors num_prospectors, locations

(0...prospectors.count).each do |n|
	puts "Rubyist #{n+1} starting in Enumerable Canyon."
	iterate prospectors[n], locations[0], num_turns
	puts "After #{prospectors[n].num_days} days, Rubyist #{n+1} found:"
	puts "\t#{display_rubies prospectors[n].num_rubies}.\n\t#{display_fake_rubies prospectors[n].num_fake_rubies}."
	prospectors[n].result
end