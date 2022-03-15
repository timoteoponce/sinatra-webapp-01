require 'sinatra'
require_relative 'user'

set :public_folder, __dir__ + '/public'

get '/' do
  user = User.new("Test")

  "Hello world! from user #{user.name} <a href='./erb'>Go to ERB page</a>"
end

get '/erb' do
  erb :index
end