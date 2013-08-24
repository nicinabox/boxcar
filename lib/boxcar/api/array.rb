require 'boxcar/api/core'
require 'inifile'

class Boxcar::Array < Boxcar::Core
  include Boxcar::Helpers

  class << self
    def started?
      status == 'STARTED'
    end

    def status
      return unless unraid?
      status = IniFile.new(`/root/mdcmd status`)
      status['global']['mdState']
    end

    def start
      if system '/root/mdcmd start'
        'Array started'
      end
    end

    def stop
      if system '/root/mdcmd stop'
        'Array stopped'
      end
    end
  end
end
