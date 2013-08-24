require 'boxcar/helpers'
require 'inifile'

class Boxcar::Disk
  class << self
    include Boxcar::Helpers

    def all
      parse_disks.to_h
    end

    def parse_disks
      disks = if unraid?
                '/var/local/emhttp/disks.ini'
              else
                'test/files/disks.ini'
              end

      IniFile.load(disks)
    end

    def color_to_state(color)
      state = states

      case color
      when /blink/
        state[5]
      when /green/
        state[0]
      when /yellow/
        state[1]
      when /red/
        state[2]
      when /blue/
        state[3]
      when /grey/
        state[4]
      end
    end

  end


end
