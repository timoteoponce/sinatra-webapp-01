require 'csv'

class Vault

  PATH = "#{__dir__}/films.csv"

  def find_films
    CSV.read(PATH).map { |r| map_from_csv_row(r) }
  end

  def delete_film_by_id(id)
    original = CSV.read(PATH)
    data = original.delete_if { |x| x[0] == id }

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

  def update_film(f)
    data = CSV.read(PATH).delete_if { |x| x[0] == f['id'] }
    data = data << f.values
    CSV.open(PATH, 'w') do |csv|
      data.each do |r|
        csv << r
      end
    end
  end

  def store_film(f)
    CSV.open(PATH, 'a') do |csv|
      csv << f.values
    end
  end

  def map_from_csv_row(row)
    return {
        id: row[0],
        title: row[1],
        description: row[2],
        release_year: row[3],
        rental_duration: row[4],
        rental_rate: row[5],
        length: row[6],
        replacement_cost: row[7],
        rating: row[8],
        special_features: row[9]
      }
  end
end