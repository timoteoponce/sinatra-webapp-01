require_relative 'vault_json'
require_relative 'event/event_handler'

class Service < EventPublisher
  def initialize
    @vault = VaultJson.new
  end

  def find_films
    @vault.find_films
  end

  def find_films_by_id(id)
    @vault.find_films.find { |f| f.id == id }
  end

  def save_film(film)
    existing = @vault.find_films.find { |f| f.id == film.id }

    if existing.nil?
      @vault.store_film(film)
      publish('service', "new film stored #{film}")
      [film, nil]
    else
      [nil, "An item with the same ID #{film.id} already exists"]
    end
  end

  def update_film(film)
    existing = @vault.find_films.find { |f| f.id == film.id }

    if existing.nil?
      [nil, "An item with ID #{film.id} is missing"]
    else
      @vault.update_film(film)
      publish('service', "Film updated #{film}")
      [film, nil]
    end
  end

  def delete_film_by_id(id)
    deleted = @vault.delete_film_by_id(id)
    if deleted
      publish('service', "Film deleted #{id}")
      [true, nil]
    else
      [false, "Item not found #{id}"]
    end
  end
end
