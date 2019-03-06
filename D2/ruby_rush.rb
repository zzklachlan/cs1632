require_relative './location.rb'
require_relative './prospector.rb'
require_relative './driver.rb'

exit_code, seed, num_prospectors, num_turns = check_valid(ARGV) # Check the arguments
if exit_code.zero?
  locations, prospectors = create_graph(seed, num_prospectors)
  (0...num_prospectors).each do |n|
    puts "Rubyist #{n + 1} starting in Enumerable Canyon."
    prospectors[n].iterate prospectors[n], locations[0], num_turns
    puts "After #{prospectors[n].num_days} days, Rubyist #{n + 1} found:"
    puts "\t#{prospectors[n].display_rubies prospectors[n].num_rubies}.
    \t#{prospectors[n].display_fake_rubies prospectors[n].num_fake_rubies}."
    prospectors[n].result(prospectors[n].num_rubies)
  end
else
  exit(exit_code)
end
