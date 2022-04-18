require_relative 'vault'
require_relative 'film'

class VaultMemory < Vault
  def initialize
    @values = []
  end

  def find_films
    @values
  end

  def delete_film_by_id(id)
    data = @values.reject { |f| f.id == id }

    if @values.length == data.length
      false
    else
      @values = data
      true
    end
  end

  def update_film(film)
    data = find_films.delete_if { |x| x.id == film.id }
    @values = data << film
    nil
  end

  def store_film(film)
    data = find_films
    @values = data << film
    nil
  end
end
