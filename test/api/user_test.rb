require './test/test_runner'
require 'boxcar/api/user'

class UserTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def test_list
    users = Boxcar::User.new

    assert_equal ['root'], users.list
  end

  def test_add
    users = Boxcar::User.new

    users.add(
      :username    => 'nic',
      :password    => 'test',
      :description => 'A test user'
    )

    assert_equal ['root', 'nic'], users.list

  end

  def test_delete
    users = Boxcar::User.new
    users.add(
      :username => 'nic'
    )
    assert_equal ['root', 'nic']. users.list
  end
end
