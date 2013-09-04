require 'boxcar/helpers'
require 'boxcar/api/smart'
require 'inifile'

class Boxcar::Array

  class << self
    include Boxcar::Helpers
    include Boxcar::Smart

    def disk_ids
      Hash[all_disks.map { |d|
        ["#{d.device_model || d.id} (#{d.device})", d.id] unless d.name == 'flash'
      }]
    end

    def total_size
      disks = all_disks.reject { |d| /flash/ =~ d.name }
      sum_disks(disks, 'size')
    end

    def usable_size
      disks = all_disks.reject { |d| /parity|flash|cache/ =~ d.name }
      sum_disks(disks, 'size')
    end

    def parity_size
      parity = Boxcar::Disk.find('parity')
      parity.size
    end

    def cache_size
      cache = Boxcar::Disk.find('cache')
      cache.size
    end

    def free_space
      disks = all_disks.reject { |d| /parity|flash|cache/ =~ d.name }
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

    def all_disks
      @disks ||= Boxcar::Disk.all
    end
  end
end
