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
end
