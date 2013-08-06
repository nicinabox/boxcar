require './test/test_runner'
require 'boxcar/user'

class UserTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def test_list
    users = User.new

    assert_equal ['root'], users.list
  end

  def test_add
    users = User.new

    users.add(
      :username    => 'nic',
      :password    => 'test',
      :description => 'A test user'
    )

    assert_equal ['root', 'nic'], users.list

  end

  def test_delete
    users = User.new
    users.add(
      :username => 'nic'
    )
    assert_equal ['root', 'nic']. users.list
  end
end
