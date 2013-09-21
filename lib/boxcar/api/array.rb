require 'boxcar/api/disk'
require 'boxcar/api/smart'
require 'inifile'

class Boxcar::Array < Boxcar::Disk
  extend Boxcar::Smart

  def self.total_size
    disks = all.reject { |disk| disk.name == 'flash' }
    sum_disks(disks, 'size')
  end

  def self.usable_size
    disks = all.reject { |d| /parity|flash|cache/ =~ d.name }
    sum_disks(disks, 'size')
  end

  class << self

    def parity_size
      parity = Boxcar::Disk.find('parity')
      parity.size
    end

    def cache_size
      cache = Boxcar::Disk.find('cache')
      cache.size
    end

    def free_space
      disks = all.reject { |d| /parity|flash|cache/ =~ d.name }
      sum_disks(disks, 'free')
    end

    def used_space
      usable_size - free_space
    end

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

  private

    # def all
    #   @disks ||= Boxcar::Disk.all
    # end
  end
end
