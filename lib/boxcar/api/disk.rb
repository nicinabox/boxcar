require 'boxcar/helpers'
require 'inifile'

class Boxcar::Disk
  include Boxcar::Helpers

  attr_accessor :name, :color, :device, :id,
                :numErrors, :sizeSb, :fsSize

  class << self

    def all
      parse_disks.to_h.map { |disk|
        new disk[1]
      }
    end

  private

    def parse_disks
      disks_ini = if unraid?
                    '/var/local/emhttp/disks.ini'
                  else
                    'test/files/disks.ini'
                  end

      IniFile.load(disks_ini)
    end
  end

  def initialize(args = {})
    args.each do |k, v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def state
    states = disk_states

    case color
    when /blink/
      states[5]
    when /green/
      states[0]
    when /yellow/
      states[1]
    when /red/
      states[2]
    when /blue/
      states[3]
    when /grey/
      states[4]
    end
  end

  def spinning?
    state != "not-spinning"
  end

  def assigned?
    state != "unassigned"
  end

  def size
    to_bytes sizeSb || fsSize
  end

  def temp
    nil if @temp == "*"
  end

private

  def disk_states
    %w(normal invalid disabled new unassigned not-spinning)
  end
end
