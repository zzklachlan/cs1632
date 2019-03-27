require 'sinatra'
require 'sinatra/reloader'

is_valid = true

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
  # elsif !size.nil? && size.to_i < 2
    #   is_valid = false
  else
    puts 'cp: 4'
    is_valid = true
  end
  puts "returning #{is_valid}"
  is_valid
end

post '/display' do
  ts = params['ts']
  fs = params['fs']
  size = params['size']

  # if !size.nil?
  #   puts "----------#{size.to_i}-------------"
  # end

  # puts "-----------#{is_valid}-----------------"
  puts params
  if check_params(ts, fs, size)
    erb :display, :locals => { ts: ts, fs: fs, size: size}
  else
    status 404
    erb :error
  end

end

get '/' do
  erb :index
end
