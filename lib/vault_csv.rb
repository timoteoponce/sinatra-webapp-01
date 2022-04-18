require 'csv'
require_relative 'film'
require_relative 'vault'

class VaultCsv < Vault
  PATH = "#{__dir__}/films.csv"

  def find_films
    CSV.read(PATH).map { |r| Film.from_array(r) }
  end

  def delete_film_by_id(id)
    original = CSV.read(PATH)
    data = original.reject { |x| x[0] == id }

    if original.length == data.length
      false
    else
      CSV.open(PATH, 'w') do |csv|
        data.each do |r|
          csv << r
        end
      end
      true
    end
  end

  def update_film(film)
    data = CSV.read(PATH).delete_if { |x| x[0] == film.id }
    data = data << film.to_array
    CSV.open(PATH, 'w') do |csv|
      data.each do |r|
        csv << r
      end
    end
    nil
  end

  def store_film(film)
    CSV.open(PATH, 'a') do |csv|
      csv << film.to_array
    end
    nil
  end
end
