require_relative 'film'

##
# Vault component that defines the contractual operations to perform any kind of film persistence
class Vault
  ##
  # Finds all films persisted, returns an empty array in the case of empty data
  def find_films
    raise 'Not implemented'
  end

  ##
  # Deletes a given film from the persisted entries
  # @param **_id** film ID (number) of the entry to delete
  def delete_film_by_id(_id)
    raise 'Not implemented'
  end

  ##
  # Updates the persisted values of a given film
  # @param **_film** Film to update, its **id** must not be null
  def update_film(_film)
    raise 'Not implemented'
  end

  ##
  # Stores a given film into the persistence target
  # @param **_film** Film to store, its **id** must not be null
  def store_film(_film)
    raise 'Not implemented'
  end
end
