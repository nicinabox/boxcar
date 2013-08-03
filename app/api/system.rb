require './app/helpers/api_helpers'

class System
  include ApiHelpers

  def uptime
    uptime = proc_uptime
    return if uptime.empty?

    total_seconds = uptime.split(' ').first.to_f

    dhms = [60, 60, 24].reduce([total_seconds]) { |m, o|
      m.unshift(m.shift.divmod(o)).flatten
    }

    "%d days, %d hours, %d minutes" % dhms
  end

  def motherboard
    [manufacturer, product].join(' - ')
  end

  def cpu
    processor
  end

  def cpu_clock
    convert_mhz_to_ghz processor_speed
  end

  def cpu_cache
    processor_cache.gsub('\n', ', ')
  end

  def memory
    "#{memory_module} (#{memory_capacity} max)"
  end

  def network
    interface = connected_interface
    "#{interface}: #{interface_speed(interface)} - #{interface_duplex(interface)} Duplex"
  end

  private
  def proc_uptime
   `cat /proc/uptime`
  end

  def manufacturer
    `dmidecode -q -t 2 | awk -F: '/Manufacturer:/ {print $2}'`
  end

  def product
    `dmidecode -q -t 2 | awk -F: '/Product Name:/ {print $2}'`
  end

  def processor
    `dmidecode -q -t 4 | awk -F: '/Version:/ {print $2}'`
  end

  def processor_clock
    `dmidecode -q -t 4 | awk -F: '/Current Speed:/ {print $2}'`
  end

  def processor_cache
    `dmidecode -q -t 7 | awk -F: '/Installed Size:/ {print $2}'`
  end

  def memory_module
    `dmidecode -q -t 17 | awk '/Size:/ {total+=$2;unit=$3} END {print total,unit}'`
  end

  def memory_capacity
    `dmidecode -q -t 16 | awk -F: '/Maximum Capacity:/ {print $2}'`
  end

  def connected_interface
    `ifconfig -s | awk '$1~/[0-9]$/ {print $1}'`
  end

  def interface_speed(interface)
    `ethtool #{interface} | awk -F: '/Speed:/ {print $2}'`
  end

  def interface_duplex(interface)
    `ethtool #{interface} | awk -F: '/Duplex:/ {print $2}'`
  end
end
