require 'sinatra'

# port to run sinatra in
set :port, 3001

# debugging
require 'pry-byebug'

# load all files
Dir[File.expand_path('./app/**/*.rb')].map { |f| require f }

before do
  # return JSONs
  headers 'Content-Type' => 'application/json'
end

# routes
get '/' do
  MyController.new.control
end
