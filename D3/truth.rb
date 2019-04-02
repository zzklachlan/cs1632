require 'sinatra'
require 'sinatra/reloader'

set :saved_table, Hash.new

def check_params(ts, fs, size)
  puts 'check_params called..'
  return false if ts.nil? || fs.nil? || size.nil?
  if ts.length != 1
    is_valid = false
  elsif fs.length != 1
    puts 'cp: 2'
    is_valid = false
  elsif ts == fs
    puts 'cp: 3'
    is_valid = false
  elsif size.to_i < 2
    puts 'cp: 4'
    is_valid = false
  else
    puts 'cp: 5'
    is_valid = true
  end
  puts "returning #{is_valid}"
  is_valid
end

def const_array(ts, fs, size)
  pair = [fs, ts]
  pair.repeated_permutation(size.to_i).to_a
end

def const_tru_table(size)
  pair = [false, true]
  pair.repeated_permutation(size.to_i).to_a
end

def display_and(truth_table, row, ts, fs, size)
  result = truth_table[row][0]
  val = nil
  (1...size.to_i).each do |n|
    result &= truth_table[row][n]
  end
  val = ts if result == true
  val = fs if result == false
  val
end

def display_or(truth_table, row, ts, fs, size)
  result = truth_table[row][0]
  val = nil
  (1...size.to_i).each do |n|
    result |= truth_table[row][n]
  end
  val = ts if result == true
  val = fs if result == false
  val
end

def display_nand(truth_table, row, ts, fs, size)
  result = truth_table[row][0]
  val = nil
  (1...size.to_i).each do |n|
    result &= truth_table[row][n]
  end
  val = ts if result == false
  val = fs if result == true
  val
end

def display_nor(truth_table, row, ts, fs, size)
  result = truth_table[row][0]
  val = nil
  (1...size.to_i).each do |n|
    result |= truth_table[row][n]
  end
  val = ts if result == false
  val = fs if result == true
  val
end

def display_xor(truth_table, row, ts, fs, size)
  result = 0
  val = nil
  (0...size.to_i).each do |n|
    result += 1 if truth_table[row][n] == true
  end
  val = ts if (result%2) == 1
  val = fs if (result%2) == 0
  val
end

def display_single(truth_table, row, ts, fs, size)
  result = 0
  val = nil
  (0...size.to_i).each do |n|
    result += 1 if truth_table[row][n] == true
  end
  val = ts if result == 1
  val = fs if result != 1
  val
end

get '/display' do
  puts "in display.."
  ts = params['ts']
  fs = params['fs']
  size = params['size']
  name = params['name']

  ts = 'T' if ts == ''
  fs = 'F' if fs == ''
  size = '3' if size == ''

  settings.saved_table[name] = [ts, fs, size] unless name.nil?

  puts params
  if check_params(ts, fs, size)
    puts "params good"
    erb :display, :locals => { ts: ts, fs: fs, size: size}
  else
    puts "params bad" 
    erb :error_params
  end
end

get '/save/:name' do
  tname = params[:name]
  if settings.saved_table.has_key?(tname)
    ts = settings.saved_table[tname][0]
    fs = settings.saved_table[tname][1]
    size = settings.saved_table[tname][2]
    erb :display, :locals => { ts: ts, fs: fs, size: size}  
  else
    erb :not_found
  end
end

get '/' do
  erb :index
end

not_found do 
  status 404
  erb :error_address
end
