# This is the class for different locations
class Location
  attr_accessor :name
  attr_accessor :max_rubies
  attr_accessor :max_fake_rubies
  attr_accessor :neighbors
  attr_accessor :prng

  # Constructor
  def initialize(new_name, maxr, maxf, prng)
    @name = new_name
    @max_rubies = maxr
    @max_fake_rubies = maxf
    @prng = prng
    @neighbors = []
  end

  # Return a pseudorandom number of rubies
  def num_rubies
    @prng.rand(@max_rubies + 1)
  end

  # Return a pseudorandom number of fake rubies
  def num_fake_rubies
    @prng.rand(@max_fake_rubies + 1)
  end

  # Add a neighbor to a specific location
  def add_neighbor(new_neighbor)
    @neighbors << new_neighbor
  end

  # Get the next pseudorandom loction from its neighbors
  def next_location
    raise 'This location has no neighbors.' if @neighbors.count.zero?

    num = @prng.rand(@neighbors.count)
    @next_location = neighbors[num]
    @next_location
  end
end
