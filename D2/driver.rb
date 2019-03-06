require_relative './location.rb'
require_relative './prospector.rb'

# Initialize the array of locations
def initialize_locations(seed)
  prng = Random.new(seed)
  @locations = []
  @locations[0] = Location.new('Enumerable Canyon', 1, 1, prng)
  @locations[1] = Location.new('Duck Type Beach', 2, 2, prng)
  @locations[2] = Location.new('Monkey Patch City', 1, 1, prng)
  @locations[3] = Location.new('Nil Town', 0, 3, prng)
  @locations[4] = Location.new('Matzburg', 3, 0, prng)
  @locations[5] = Location.new('Hash Crossing', 2, 2, prng)
  @locations[6] = Location.new('Dynamic Palisades', 2, 2, prng)
  @locations
end

# Initialize the array of prospectors
def initialize_prospectors(num_prospectors)
  @prospectors = []
  (0...num_prospectors).each do |x|
    @prospectors[x] = Prospector.new
  end
  @prospectors
end

# Link all the locations
def initialize_neighbors
  @locations[0].neighbors = [@locations[1], @locations[2]]
  @locations[1].neighbors = [@locations[0], @locations[4]]
  @locations[2].neighbors = [@locations[3], @locations[0], @locations[4]]
  @locations[3].neighbors = [@locations[2], @locations[5]]
  @locations[4].neighbors = [@locations[2], @locations[1], @locations[5], @locations[6]]
  @locations[5].neighbors = [@locations[4], @locations[6]]
  @locations[6].neighbors = [@locations[4], @locations[5]]
end

# Create a map and initialize the prospectors
def create_graph(seed, num_prospectors)
  initialize_locations seed
  initialize_prospectors num_prospectors
  initialize_neighbors
  [@locations, @prospectors]
end

# Check if the arguments are valid
def check_valid(args)
  if args.count != 3 || args[1].to_i.zero? || args[2].to_i.zero?
    puts "Usage:
      ruby ruby_rush.rb *seed* *num_prospectors* *num_turns*
      *seed* should be an integer
      *num_prospectors* should be a postive integer
      *num_turns* should be a positive integer"
    return [1, nil, nil, nil]
  end
  [0, args[0].to_i, args[1].to_i, args[2].to_i]
end
