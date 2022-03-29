require 'sinatra'
require 'csv'
require 'json'

set :public_folder, __dir__ + '/public'

get '/' do
  "Fetch our most <a href='./films'>recent films</a>"
end

get '/films' do
  path = "#{__dir__}/films.csv"
  data = CSV.read(path).map {
    |r| {
      :id => r[0], 
      :title => r[1], 
      :description => r[2], 
      :release_year => r[3], 
      :rental_duration => r[4], 
      :rental_rate => r[5], 
      :length => r[6], 
      :replacement_cost => r[7], 
      :rating => r[8], 
      :special_features=> r[9]
    }
  }
  content_type :json
  data.to_json
end

post '/films' do
  path = "#{__dir__}/films.csv"
  data = CSV.read(path)
end

delete '/films/:id' do
  path = "#{__dir__}/films.csv"
  data = CSV.read(path).delete_if { |x| x[0] == params['id']}
  CSV.open(path, "w") do |csv|
    data.each { |r|
      csv << r 
    }
  end
  "Successfully removed"
end