require 'sinatra/base'

# debugging
require 'pry-byebug'

# rest client
require 'rest-client'

# load all files
Dir[File.expand_path('./app/errors/**/*.rb')].map { |f| require f }
Dir[File.expand_path('./app/**/*.rb')].map { |f| require f }

# backend app
class AppBackend < Sinatra::Base
  # port to run sinatra in
  set :port, 3000

  before do
    # return JSONs
    headers 'Content-Type' => 'application/json'
    # tell the browser that is ok to show result
    headers 'Access-Control-Allow-Origin' => 'http://localhost:8080'
    # ??
    headers 'Access-Control-Allow-Credentials' => 'true'
  end

  # routes
  get '/' do
    MyController.new.control(params: params)
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
