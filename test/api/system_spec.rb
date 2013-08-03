require './test/test_runner'
require './app/api/system'

class SystemTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def test_uptime
    system = System.new
    system.stubs(:proc_uptime).returns('90501.54 356207.33')

    assert_equal '1 days, 1 hours, 8 minutes', system.uptime
  end

  def test_motherboard
    system = System.new
    system.stubs(:manufacturer).returns('ASUSTeK Computer INC.')
    system.stubs(:product).returns('P8H67-M PRO')

    assert_equal 'ASUSTeK Computer INC. - P8H67-M PRO', system.motherboard
  end

  def test_cpu
    system = System.new
    system.stubs(:processor).returns('Intel(R) Core(TM) i3-2120 CPU @ 3.30GHz')

    assert_equal 'Intel(R) Core(TM) i3-2120 CPU @ 3.30GHz', system.cpu
  end

  def test_cpu_clock
    system = System.new
    system.stubs(:processor_speed).returns('3433 MHz')

    assert_equal '3.433 GHz', system.cpu_clock
  end

  def test_cpu_cache
    system = System.new
    system.stubs(:processor_cache).returns('128 kB\n512 kB\n3072 kB')

    assert_equal '128 kB, 512 kB, 3072 kB', system.cpu_cache
  end

  def test_memory
    system = System.new
    system.stubs(:memory_module).returns('2048 Module')
    system.stubs(:memory_capacity).returns('32 GB')

    assert_equal '2048 Module (32 GB max)', system.memory
  end

  def test_network_bond0
    system = System.new
    system.stubs(:connected_interface).returns('bond0')
    system.stubs(:interface_speed).with('bond0').returns('adaptive load balancing')
    system.stubs(:interface_duplex).with('bond0').returns('Full')

    assert_equal 'bond0: adaptive load balancing - Full Duplex', system.network
  end

  def test_network_eth0
    system = System.new
    system.stubs(:connected_interface).returns('eth0')
    system.stubs(:interface_speed).with('eth0').returns('1000Mb/s')
    system.stubs(:interface_duplex).with('eth0').returns('Full')

    assert_equal 'eth0: 1000Mb/s - Full Duplex', system.network
  end

  def test_connected_afp_users
    system = System.new
    system.stubs(:connected_afp_users).returns(1)
    assert_equal 1, system.connected_afp_users
  end

  def test_connected_smb_users
    system = System.new
    system.stubs(:connected_smb_users).returns(1)
    assert_equal 1, system.connected_smb_users
  end
end
