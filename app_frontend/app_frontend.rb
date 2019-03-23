require 'sinatra'

# port to run sinatra in
set :port, 8080

# views templates + default folder
require 'slim'
set :views, './app/'

before do
  @endpoint_backend = 'http://localhost:3000'
  @params = params
end

get '/' do
  slim :my_view
end
