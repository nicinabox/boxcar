require 'boxcar/api/disk'
require 'boxcar/api/smart'
require 'inifile'

class Boxcar::Array < Boxcar::Disk
  extend Boxcar::Smart

  def self.total_size
    disks = all.reject { |disk| disk.flash? }
    sum_disks(disks, 'size')
  end

  def self.usable_size
    disks = all.reject { |disk| disk.special? }
    sum_disks(disks, 'size')
  end

  def self.parity_size
    parity = Boxcar::Disk.find('parity')
    parity.size
  end

  def self.cache_size
    cache = Boxcar::Disk.find('cache')
    cache.size
  end

  def self.free_space
    disks = all.reject { |disk| disk.special? }
    sum_disks(disks, 'free')
  end

  def self.used_space
    usable_size - free_space
  end

  def self.started?
    status == 'STARTED'
  end

  def self.status
    return unless unraid?
    status = IniFile.new(`/root/mdcmd status`)
    status['global']['mdState']
  end

  def self.start
    if system '/root/mdcmd start'
      'Array started'
    end
  end

  def self.stop
    if system '/root/mdcmd stop'
      'Array stopped'
    end
  end
end
