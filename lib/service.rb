require_relative 'vault'

class Service
  def initialize
    @vault = Vault.new
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
      [film, nil]
    end
  end

  def delete_film_by_id(id)
    deleted = @vault.delete_film_by_id(id)
    if deleted
      [true, nil]
    else
      [false, "Item not found #{id}"]
    end
  end
end
