require 'sinatra'
require 'json'

require_relative 'service'
require_relative 'film'
require_relative 'event/event_service'
require_relative 'event/event_logger'

set :public_folder, __dir__ + '/public'

service = Service.new
event_service = EventService.new
event_service.add_handler(service)
event_service.add_handler(EventLogger.new)

get '/' do
  data = service.find_films
  data = data.sort_by { |r| r.id.to_i }
  paginate = paginate(data, params['page'] || '1')
  erb :index, locals: { paginate: paginate }
end

get '/new' do
  erb :new
end

get '/edit' do
  item = service.find_films_by_id(params['id'])
  puts "edit #{item}"
  erb :edit, locals: { item: item }
end

get '/films' do
  data = service.find_films
  logger.info "Returning '#{data.length}' items"
  content_type :json
  data.to_hash
end

post '/films' do
  film = Film.from_hash(JSON.parse(request.body.read))
  result = service.save_film(film)

  if result[0].nil?
    status 400
    body result[1]
  else
    msg = "Stored new item #{result[0]}"
    logger.info msg
    msg
  end
end

put '/films' do
  film = Film.from_hash(JSON.parse(request.body.read))
  result = service.update_film(film)

  if result[0].nil?
    status 404
    body result[1]
  else
    msg = "Updated item #{result[0]}"
    logger.info msg
    msg
  end
end

delete '/films/:id' do
  id = params['id']
  result = service.delete_film_by_id(id)

  if result[0]
    msg = "Successfully removed item #{id}"
    logger.info msg
    msg
  else
    status 404
    body "Item not found #{id}"
  end
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
