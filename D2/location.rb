# This is the class for different locations
class Location
  attr_accessor :name
  attr_accessor :max_rubies
  attr_accessor :max_fake_rubies
  attr_accessor :neighbors
  attr_accessor :prng

  def initialize(new_name, maxr, maxf, prng)
    @name = new_name
    @max_rubies = maxr
    @max_fake_rubies = maxf
    @prng = prng
    @neighbors = []
  end

  def num_rubies
    @prng.rand(@max_rubies + 1)
  end

  def num_fake_rubies
    @prng.rand(@max_fake_rubies + 1)
  end

  def add_neighbor(new_neighbor)
    @neighbors << new_neighbor
  end

  def next_location
    raise 'This location has no neighbors' if @neighbors.count.zero?

    num = @prng.rand(@neighbors.count)
    @next_location = neighbors[num]
    @next_location
  end
end
