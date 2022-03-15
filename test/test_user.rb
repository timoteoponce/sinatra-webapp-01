require 'minitest/autorun'
require_relative '../lib/user'

class TestUser < Minitest::Test

    def test_simple
        user = User.new("test")
        assert_equal("test", user.name)
    end
end