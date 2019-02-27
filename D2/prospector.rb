require_relative "location.rb"

class Prospector
	attr_accessor :id
	attr_accessor :num_days
	attr_accessor :num_turns
	attr_accessor :num_rubies
	attr_accessor :num_fake_rubies
	attr_accessor :curr_location

	def initialize(i, location)
		@id = i
		@num_days = 0
		@num_turns = 0
		@num_rubies = 0
		@num_fake_rubies = 0
		@curr_location = location
	end

	def incre_num_rubies(i)
		@num_rubies += i
	end

	def incre_num_fake_rubies(i)
		@num_fake_rubies += i
	end

	def incre_num_days
		@num_days += 1
	end

	def incre_num_turns
		@num_turns += 1
	end

	def result
		if @num_rubies >= 10
			puts "Going home victorious!"
		elsif @num_rubies == 0
			puts "Going home empty-handed."
		else
			puts "Going home sad."
		end				
	end
end