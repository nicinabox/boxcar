require 'boxcar/helpers'
require 'boxcar/api/smart'
require 'inifile'

class Boxcar::Disk
  extend  Boxcar::Helpers
  include Boxcar::Helpers
  include Boxcar::Smart

  attr_accessor :name, :color, :device, :id

  def self.all
    parse_ini('disks').to_h.map { |disk|
      new disk[1]
    }
  end

  def self.find(name)
    new parse_ini('disks').to_h[name]
  end

  def initialize(args = {})
    args.each do |k, v|
      unless v.nil? or /temp/ =~ k
        instance_variable_set("@#{k}", v)
      end
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

  def active?
    state != "standby"
  end

  def assigned?
    state != "unassigned"
  end

  def size
    to_bytes @sizeSb || @fsSize
  end

  def free
    to_bytes @fsFree
  end

  def temp
    @temp ||= temperature
  end

  def flash?
    name == 'flash'
  end

private

  def disk_states
    %w(active invalid disabled new unassigned standby)
  end
end
