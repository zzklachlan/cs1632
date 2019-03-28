require 'sinatra'
require 'sinatra/reloader'

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

get '/display' do
  puts "in display.."
  ts = params['ts']
  fs = params['fs']
  size = params['size']

  ts = 'T' if ts == ''
  fs = 'F' if fs == ''
  size = '3' if size == ''

  puts params
  if check_params(ts, fs, size)
    puts "params good"
    erb :display, :locals => { ts: ts, fs: fs, size: size}
  else
    puts "params bad" 
    erb :error_params
  end
end

get '/' do
  erb :index
end

not_found do 
  status 404
  erb :error_address
end
