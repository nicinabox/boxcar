require 'boxcar/helpers'

module Boxcar
  module Smart
    def temperature
      return if standby?

      temp = raw_value(device, 'Temperature_Celsius').strip
      temp.to_i unless temp.empty?
    end

    def device_model
      info['Device Model']
    end

    def serial_number
      info['Serial Number']
    end

  private

    def info
      return {} unless Boxcar::Helpers.unraid?
      @info ||= device_information
    end

    def standby?
      `hdparm -C /dev/#{device} 2>/dev/null` =~ /standby/
    end

    def raw_value(device, param)
      `smartctl -d ata -A /dev/#{device} | grep #{param} | awk '{ print $10; }' 2>/dev/null`
    end

    def device_information
      raw_info = `smartctl -i /dev/#{device}`
      refined_info = raw_info.scan(/(^[\w\s]+):\s+(.+$)/)
      Hash[*refined_info.flatten]
    end
  end
end
