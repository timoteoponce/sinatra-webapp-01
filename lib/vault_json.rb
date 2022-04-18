require 'json'
require_relative 'vault'
require_relative 'film'

class VaultJson < Vault
  PATH = "#{__dir__}/films.json"

  def find_films
    file = File.open(PATH)
    begin
      JSON.load(file).map { |f| Film.from_hash(f) }
    rescue StandardError
      []
    ensure
      file.close if !file.nil? && !file.closed?
    end
  end

  def delete_film_by_id(id)
    original = find_films
    data = original.reject { |f| f.id == id }

    if original.length == data.length
      false
    else
      persist(data)
      true
    end
  end

  def update_film(film)
    data = find_films.delete_if { |x| x.id == film.id }
    persist(data << film)
  end

  def store_film(film)
    data = find_films
    persist(data << film)
  end

  private def persist(films)
    data = films.map { |f| f.to_hash }
    File.write(PATH, JSON.generate(data), mode: 'w')
  end
end
