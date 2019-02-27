# This is the class for different locations
class Location
	attr_accessor :name
	attr_accessor :max_rubies
	attr_accessor :max_fake_rubies
	attr_accessor :neighbors
	attr_accessor :prng

	def initialize(n, mr, mf, prng) 
		@name = n
		@max_rubies = mr
		@max_fake_rubies = mf
		@@prng = prng
		@neighbors = []
	end

	def get_num_rubies
		@@prng.rand(@max_rubies + 1)
	end

	def get_num_fake_rubies
		@@prng.rand(@max_fake_rubies + 1)
	end

	def add_neighbor(new_neighbor)
		@neighbors << new_neighbor
	end

	def get_next_location
		raise "This location has no neighbors" if neighbors.count == 0
		num = @@prng.rand(@neighbors.count)
		#puts @neighbors.count
		#puts num
		@next_location = neighbors[num]
		@next_location
	end
end

