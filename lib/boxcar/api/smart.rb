require 'boxcar/helpers'

module Boxcar
  module Smart
    def temperature
      raw_temp = `smartctl -d ata -A  /dev/#{device} | grep -i temperature`
      raw_temp.match(/[\d]+$/)
    end

    def device_model
      info['Device Model']
    end

    def serial_number
      info['Serial Number']
    end

    def info
      return {} unless Boxcar::Helpers.unraid?
      @info ||= parse_smart_info
    end

  private

    def parse_smart_info
      raw_info = `smartctl -i /dev/#{device}`
      refined_info = raw_info.scan(/(^[\w\s]+):\s+(.+$)/)
      Hash[*refined_info.flatten]
    end
  end
end
