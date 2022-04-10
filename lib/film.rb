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

  def initialize(id, title, description, release_year, rental_duration, rental_rate, length, replacement_cost, rating, special_features)
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

  def to_array
    [@id, @title, @description, @release_year, @rental_duration, @rental_rate, @length, @replacement_cost, @rating,
     @special_features]
  end

  def self.from_array(row)
    Film.new(*row)
  end

  def self.from_hash(hash)
    Film.new(*hash.values)
  end
end
