require 'boxcar/api/core'
require 'inifile'

class Boxcar::Disk < Boxcar::Core
  include Boxcar::Helpers
  STATES = %w(normal invalid disabled new not-present not-spinning)

  class << self
    def all
      parse_disks.to_h
    end

    def parse_disks
      disks = if unraid?
                '/var/local/emhttp/disks/ini'
              else
                'test/files/disks.ini'
              end

      IniFile.load(disks)
    end

    def color_to_state(color)
      case color
      when /blink/
        STATES[5]
      when /green/
        STATES[0]
      when /yellow/
        STATES[1]
      when /red/
        STATES[2]
      when /blue/
        STATES[3]
      when /grey/
        STATES[4]
      end
    end

  end


end
