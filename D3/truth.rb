require 'sinatra'
require 'sinatra/reloader'

is_valid = true

def check_params(ts, fs, size)
  if !ts.nil? && ts.length != 1
    is_valid = false
  elsif !fs.nil? && fs.length != 1
    is_valid = false
  elsif !ts.nil? && !fs.nil? && ts == fs
    is_valid = false
  # elsif !size.nil? && size.to_i < 2
  #   is_valid = false
  end
  is_valid
end

post '/display' do
  erb :display
end

get '/' do
  ts = params['ts']
  fs = params['fs']
  size = params['size']

  # if !size.nil?
  #   puts "----------#{size.to_i}-------------"
  # end

  # puts "-----------#{is_valid}-----------------"
  if check_params ts, fs, size == false
    status 404
    erb :error
  else
    erb :index, :locals => { ts: ts, fs: fs, size: size}
  end
end
