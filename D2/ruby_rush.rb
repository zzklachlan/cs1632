require_relative './location.rb'
require_relative './prospector.rb'
require_relative './driver.rb'

check_valid # check if the arguments are valid
prng = Random.new(ARGV[0].to_i) # create a pseudorandom generator
locations = initialize_locations prng # initialize all locations
construct_graph locations # create a graph of all locations
prospectors = initialize_prospectors ARGV[1].to_i # initialize a list of prospectors

run_program prospectors, locations, ARGV[2].to_i # run the program
