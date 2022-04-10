class Film
  attr_accessor :id,
    :title,
    :description,
    :release_year,
    :rental_duration,
    :rental_rate,
    :length,
    :replacement_cost,
    :rating,
    :special_features

  def initialize(id,title,description,release_year,rental_duration,rental_rate,length,replacement_cost,rating,special_features)
    @id = id
    @title = title
    @description = description
    @release_year = release_year
    @rental_duration = rental_duration
    @rental_rate = rental_rate
    @length = length
    @replacement_cost = replacement_cost
    @rating = rating
    @special_features = special_features
  end

  def to_csv
    [@id, @title, @description, @release_year, @rental_duration, @rental_rate, @length, @replacement_cost, @rating, @special_features]
  end

  def self.from_csv(row)
    Film.new(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9])
  end

  def self.from_json(json)
    puts "#{json[:id]}"
    Film.new(
      json['id'],
      json['title'],
      json['description'],
      json['release_year'],
      json['rental_duration'],
      json['rental_rate'],
      json['length'],
      json['replacement_cost'],
      json['rating'],
      json['special_features']
    )
  end
end
