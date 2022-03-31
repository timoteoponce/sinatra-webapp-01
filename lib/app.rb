require 'sinatra'
require 'csv'
require 'json'

set :public_folder, __dir__ + '/public'

path = "#{__dir__}/films.csv"

get '/' do
  data = CSV.read(path).map do |r|
    {
      id: r[0],
      title: r[1],
      description: r[2],
      release_year: r[3],
      rental_duration: r[4],
      rental_rate: r[5],
      length: r[6],
      replacement_cost: r[7],
      rating: r[8],
      special_features: r[9]
    }
  end
  data = data.sort_by { |r| r[:id].to_i }
  paginate = paginate(data, params['page'] || '1')
  erb :index, locals: { paginate: paginate }
end

get '/new' do
  erb :new
end

get '/edit' do
  r = CSV.read(path).find { |r| r[0] == params['id'] }
  item = {
    id: r[0],
    title: r[1],
    description: r[2],
    release_year: r[3],
    rental_duration: r[4],
    rental_rate: r[5],
    length: r[6],
    replacement_cost: r[7],
    rating: r[8],
    special_features: r[9]
  }
  erb :edit, locals: { item: item }
end

def paginate(items, page_str)
  page = page_str.to_i
  total = items.length
  per_page = 10
  last_page = total / per_page
  from = (page - 1) * per_page
  next_page = (page + 1) <= last_page ? page + 1 : nil
  previous_page = (page - 1).zero? ? nil : page - 1
  { list: items.slice(from, per_page), last_page: last_page, next_page: next_page, previous_page: previous_page }
end

get '/films' do
  data = CSV.read(path).map do |r|
    {
      id: r[0],
      title: r[1],
      description: r[2],
      release_year: r[3],
      rental_duration: r[4],
      rental_rate: r[5],
      length: r[6],
      replacement_cost: r[7],
      rating: r[8],
      special_features: r[9]
    }
  end
  logger.info "Returning '#{data.length}' items"
  content_type :json
  data.to_json
end

post '/films' do
  payload = JSON.parse(request.body.read)
  existing = CSV.read(path).find { |r| r[0] == payload['id'] }

  if existing.nil?
    CSV.open(path, 'a') do |csv|
      csv << payload.values
    end
    msg = "Stored new item #{payload}"
    logger.info msg
    msg
  else
    status 400
    body "An item with the same ID #{payload['id']} already exists"
  end
end

put '/films' do
  payload = JSON.parse(request.body.read)
  existing = CSV.read(path).find { |r| r[0] == payload['id'] }

  if existing.nil?
    status 404
    body "An item with the same ID #{payload['id']} must exists"
  else
    data = CSV.read(path).delete_if { |x| x[0] == payload['id'] }
    data = data << payload.values
    CSV.open(path, 'w') do |csv|
      data.each do |r|
        csv << r
      end
    end
    msg = "Stored item #{payload}"
    logger.info msg
    msg
  end
end

delete '/films/:id' do
  existing = CSV.read(path).find { |r| r[0] == params['id'] }
  if existing.nil?
    status 404
    body "Item not found #{params['id']}"
  else
    data = CSV.read(path).delete_if { |x| x[0] == params['id'] }
    CSV.open(path, 'w') do |csv|
      data.each do |r|
        csv << r
      end
    end
    msg = "Successfully removed item #{params['id']}"
    logger.info msg
    msg
  end
end
