require 'sinatra'
require 'json'

require_relative 'vault'

set :public_folder, __dir__ + '/public'

vault = Vault.new

get '/' do
  data = vault.find_films
  data = data.sort_by { |r| r['id'].to_i }
  paginate = paginate(data, params['page'] || '1')
  erb :index, locals: { paginate: paginate }
end

get '/new' do
  erb :new
end

get '/edit' do
  item = vault.find_films.find { |f| f['id'] == params['id'] }
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
  data = vault.find_films
  logger.info "Returning '#{data.length}' items"
  content_type :json
  data.to_json
end

post '/films' do
  payload = JSON.parse(request.body.read)
  existing = vault.find_films.find { |f| f['payload'] == payload['id'] }

  if existing.nil?
    store_film(payload)
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
  existing = vault.find_films.find { |f| f['id'] == payload['id'] }

  if existing.nil?
    status 404
    body "An item with the same ID #{payload['id']} must exists"
  else
    update_film(payload)
    msg = "Stored item #{payload}"
    logger.info msg
    msg
  end
end

delete '/films/:id' do
  deleted = vault.delete_film_by_id(params['id'])
  if !deleted
    status 404
    body "Item not found #{params['id']}"
  else
    msg = "Successfully removed item #{params['id']}"
    logger.info msg
    msg
  end
end