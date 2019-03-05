require_relative './location.rb'
require_relative './prospector.rb'
require_relative './driver.rb'

exit_code, seed, num_prospectors, num_turns = check_valid(ARGV) # Check the arguments
if exit_code.zero?
  prng = Random.new(seed) # create a pseudorandom generator
  locations = initialize_locations prng # initialize all locations
  locations[0].neighbors = [locations[1], locations[2]]
  locations[1].neighbors = [locations[0], locations[4]]
  locations[2].neighbors = [locations[3], locations[0], locations[4]]
  locations[3].neighbors = [locations[2], locations[5]]
  locations[4].neighbors = [locations[2], locations[1], locations[5], locations[6]]
  locations[5].neighbors = [locations[4], locations[6]]
  locations[6].neighbors = [locations[4], locations[5]]
  prospectors = initialize_prospectors num_prospectors # initialize a list of prospectors
  run_program num_prospectors, prospectors, locations, num_turns # run the program
end
exit(exit_code)
