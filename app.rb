require 'sinatra'

set :public_folder, __dir__ + '/public'

get '/' do
  'Hello world! <a href="./erb">Go to ERB page</a>'
end

get '/erb' do
  erb :index
end