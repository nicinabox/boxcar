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
end
