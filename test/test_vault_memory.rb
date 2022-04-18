require 'minitest/autorun'

require_relative '../lib/vault_memory'

class TestVaultMemory < Minitest::Test
  def test_find_on_empty
    vault = VaultMemory.new
    data = vault.find_films
    assert_equal(0, data.length)
  end

  def test_delete_on_empty
    vault = VaultMemory.new
    result = vault.delete_film_by_id('1')
    assert_equal(false, result)
  end

  def test_update_on_empty
    vault = VaultMemory.new
    result = vault.update_film(Film.new('1', 'title', 'description', '1999', '120', '2022-10-10',
                                        'length', 'replacement_cost', 'rating', 'special_features'))
    assert_nil(result)
  end
end
